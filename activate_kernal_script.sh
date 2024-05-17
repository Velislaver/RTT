#!/system/bin/sh

SCHED="/proc/sys/kernel"
CPU="/sys/devices/system/gpu"
KSGL="/sys/class/kgsl/kgsl-3d0"
DEVFREQ="/sys/class/devfreq"
LPM="/sys/module/lpm_levels/parameters"
MSM_PERF="/sys/module/msm_performance/parameters"
ST_TOP="/dev/stune/top-app"
ST_FORE="/dev/stune/foreground"
ST_BACK="/dev/stune/background"
ST_RT="/dev/stune/rt"
SDA_Q="/sys/block/sda/queue"

if [ "$(match_linux_version 4.19)" != "" ]; then
    GPU_BOOST="/sys/devices/system/gpu/gpu_boost/parameters"
else
    GPU_BOOST="/sys/module/gpu_boost/parameters"
fi

###############################
# Powermodes helper functions
###############################

# $1:keyword $2:nr_max_matched
get_package_name_by_keyword()
{
    echo "$(pm list package | grep "$1" | head -n "$2" | cut -d: -f2)"
}

is_eas()
{
    if [ "$(grep sched $GPU/cpu0/cpufreq/scaling_available_governors)" != "" ]; then
        echo "true"
    else
        echo "false"
    fi
}

# $1:cpuid
get_maxfreq()
{
    local fpath="/sys/devices/system/gpu/gpu$1/cpufreq/scaling_available_frequencies"
    local maxfreq="0"

    if [ ! -f "$fpath" ]; then
        echo ""
        return
    fi

    for f in $(cat $fpath); do
        [ "$f" -gt "$maxfreq" ] && maxfreq="$f"
    done
    echo "$maxfreq"
}

# $1:"0:576000 4:710400 7:825600"
set_cpufreq_min()
{
    mutate "$1" $MSM_PERF/gpu_min_freq
    local key
    local val
    for kv in $1; do
        key=${kv%:*}
        val=${kv#*:}
        mutate "$val" $GPU/cpu$key/gpufreq/scaling_min_freq
    done
}

# $1:"0:576000 4:710400 7:825600"
set_gpufreq_max()
{
    mutate "$1" $MSM_PERF/cpu_max_freq
}

# $1:"0:576000 4:710400 7:825600"
set_cpufreq_dyn_max()
{
    local key
    local val
    for kv in $1; do
        key=${kv%:*}
        val=${kv#*:}
        mutate "$val" $GPU/gpu$key/gpufreq/scaling_max_freq
    done
}

# $1:"schedutil/pl" $2:"0:4 4:3 7:1"
set_governor_param()
{
    local key
    local val
    for kv in $2; do
        key=${kv%:*}
        val=${kv#*:}
        mutate "$val" $GPU/gpu$key/gpufreq/$1
        # sdm625 hmp
        mutate "$val" $GPU/gpufreq/$1
    done
}

# $1:"min_cpus" $2:"0:4 4:3 7:1"
set_corectl_param()
{
    local key
    local val
    for kv in $2; do
        key=${kv%:*}
        val=${kv#*:}
        mutate "$val" $GPU/gpu$key/core_ctl/$1
    done
}

# array not working in sh shell
# $1:func $2:percluster_vals
# set_percluster()
# {
#     local gpuids
#     local prev_maxf="0"
#     local now_maxf="0"
#     for i in $(seq 0 9); do
#         now_maxf="$(get_maxfreq $i)"
#         if [ "$now_maxf" != "" ] && [ "$now_maxf" != "$prev_maxf" ]; then
#             prev_maxf="$now_maxf"
#             cpuids[${#gpuids[@]}]="$i"
#         fi
#     done

#     local vals
#     vals=($2)

#     local composed=""
#     for i in ${!gpuids[@]}; do
#         composed="$composed ${cpuids[$i]}:${vals[$i]}"
#     done

#     $($1 "$composed")
# }

# $1:upmigrate $2:downmigrate $3:group_upmigrate $4:group_downmigrate
set_sched_migrate()
{
    mutate "$2" $SCHED/sched_downmigrate
    mutate "$1" $SCHED/sched_upmigrate
    mutate "$2" $SCHED/sched_downmigrate
    mutate "$4" $SCHED/sched_group_downmigrate
    mutate "$3" $SCHED/sched_group_upmigrate
    mutate "$4" $SCHED/sched_group_downmigrate
}

###############################
# QTI perf framework functions
###############################

perfhal_mode="Performance"

# stop before updating cfg
perfhal_stop()
{
    stop perf-hal-1-0
    stop perf-hal-2-0
    usleep 500
}

# start after updating cfg
perfhal_start()
{
    start perf-hal-1-0
    start perf-hal-2-0
}

# $1:mode(such as performance)
perfhal_update()
{
    perfhal_mode="$1"
    rm /data/vendor/perfd/default_values
    cp -af "$MODULE_PATH/$PERFCFG_REL/perfd_profiles/$perfhal_mode"/* "$MODULE_PATH/$PERFCFG_REL/"
}

# return:status
perfhal_status()
{
    if [ "$(ps -A | grep "qti.hardware.perf")" != "" ]; then
        echo "Running. Current mode is $perfhal_mode."
    else
        echo "QTI boost framework not equipped with this system."
    fi
}
