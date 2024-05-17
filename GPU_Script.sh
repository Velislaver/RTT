#!/system/bin/sh



#gpu perf enable
echo '1' > /sys/devices/system/gpu/perf/enable;
chmod '644' > /sys/devices/system/gpu/perf/enable;

echo 'boost' > /sys/devices/system/gpu/sched/sched_boost;
echo '3' > /proc/gpufreq/gpufreq_power_mode;
echo '1' > /proc/gpufreq/gpufreq_imax_enable;
echo '0' > /proc/gpufreq/gpufreq_imax_thermal_protect;
sleep 0.2
echo '35' > /dev/stune/foreground/schedtune.boost;
chmod '644' /dev/stune/foreground/schedtune.boost;
echo '1' > /proc/gpufreq/cpufreq_cci_mode;
chmod '644' /proc/gpufreq/gpufreq_cci_mode;


<BoostConfigs>
    <PerfBoost>

    <!--app lauch boost-->
        <!-- GPUBOOST_MAX_FREQ BIG Core resource opcode, value-->
        <!-- GPUBOOST_MAX_FREQ LITTLE Core resource opcode, value-->
        <!-- GPUBOOST_MIN_FREQ BIG Core resource opcode, value-->
        <!-- GPUBOOST_MIN_FREQ LITTLE Core resource opcode, value-->

        <!-- Type="1", main launch boost of 2sec -->
        <Config
            Id="0x00001081" Type="1" Enable="true" Timeout="2000" Target="sdm660"
            Resources="0x40804000, 0xFFF, 0x40804100, 0xFFF, 0x40800000, 1747, 0x40800100, 1400" />

    <!--app lauch boost (disabling packing)-->
        <!-- POWER COLLAPSE resource opcode, value-->
        <!-- STORAGE CLK SCALING resource opcode, value-->

        <!-- Type="2", launch boost for disable packing 1.5sec -->
        <Config
            Id="0x00001081" Type="2" Enable="true" Timeout="1500" Target="sdm660"
            Resources="0x40400000, 0x1, 0x42C10000, 0x1" />

    <!--Vertical Scroll boost-->
        <!-- GPUBW_MIN_FREQ resource opcode, value-->
        <!-- GPUBOOST_MIN_FREQ BIG CORE resource opcode, value -->
        <!-- GPUBOOST_MIN_FREQ LITTLE Core resource opcode, value -->
        <!-- GPU MIN-FREQUENCY resource opcode,value-->

        <!-- Type="1", Vertical Scroll boost -->
        <Config
            Id="0x00001080" Type="1" Enable="true" Target="sdm660" Resolution="1080p"
            Resources="0x41800000, 0x31, 0x40800000, 1100, 0x40800100, 1100"  />

        <Config
            Id="0x00001080" Type="1" Enable="true" Target="sdm660" Resolution="2560"
            Resources="0x41800000, 0x31, 0x40800000, 1100, 0x40800100, 1100, 0x4280C000, 266"  />

    <!--Horizontal Scroll boost-->
        <!-- GPUBW_MIN_FREQ resource opcode, value-->
        <!-- GPUBOOST_MIN_FREQ BIG CORE resource opcode, value -->
        <!-- GPUBOOST_MIN_FREQ LITTLE Core resource opcode, value -->
        <!-- GPU MIN-FREQUENCY resource opcode,value-->

        <!-- Type="2", Horizontal Scroll boost -->
        <Config
            Id="0x00001080" Type="2" Enable="true" Target="sdm660" Resolution="1080p"
            Resources="0x41800000, 0x31, 0x40800000, 1100, 0x40800100, 1100"  />

        <Config
            Id="0x00001080" Type="2" Enable="true" Target="sdm660" Resolution="2560"
            Resources="0x41800000, 0x31, 0x40800000, 1100, 0x40800100, 1100, 0x4280C000, 266"  />

    <!--Pre-Fling boost-->
        <!-- GPUBW_MIN_FREQ resource opcode, value-->
        <!-- GPUBOOST_MIN_FREQ BIG CORE resource opcode, value -->
        <!-- GPUBOOST_MIN_FREQ LITTLE Core resource opcode, value -->
        <!-- GPU MIN-FREQUENCY resource opcode,value-->

        <!-- Type="4", Pre-Fling boost -->
        <Config
            Id="0x00001080" Type="4" Enable="true" Timeout="80" Target="sdm660" Resolution="1080p"
            Resources="0x41800000, 0x31, 0x40800000, 1100, 0x40800100, 1100"  />

        <Config
            Id="0x00001080" Type="4" Enable="true" Timeout="80" Target="sdm660" Resolution="2560"
            Resources="0x41800000, 0x31, 0x40800000, 1100, 0x40800100, 1100, 0x4280C000, 266"  />

    <!--MTP boost-->
        <!-- GPUBOOST_MAX_FREQ BIG Core resource opcode, value-->
        <!-- GPUBOOST_MAX_FREQ LITTLE Core resource opcode, value-->
        <!-- GPUBOOST_MIN_FREQ BIG Core resource opcode, value-->
        <!-- GPUBOOST_MIN_FREQ LITTLE Core resource opcode, value-->
        <!-- STORAGE CLK SCALING resource opcode, value-->

        <!-- Type="", MTP boost -->

        <Config
            Id="0x00001086" Enable="true" Target="sdm660"
            Resources="0x40804000, 0xFFF, 0x40804100, 0xFFF, 0x40800000, 1800,
                       0x40800100, 1400, 0x42C10000, 0x1" />

    <!--PackageInstall boost-->
        <!-- GPUBOOST_MAX_FREQ BIG Core resource opcode, value-->
        <!-- GPUBOOST_MAX_FREQ LITTLE Core resource opcode, value-->
        <!-- GPUBOOST_MIN_FREQ BIG Core resource opcode, value-->
        <!-- GPUBOOST_MIN_FREQ LITTLE Core resource opcode, value-->
        <!-- Type="", Package Install boost -->

        <Config
            Id="0x00001088" Enable="true" Target="sdm660"
            Resources="0x40804000, 0xFFF, 0x40804100, 0xFFF, 0x40800000,0xFFF,
                       0x40800100,0xFFF" />

    <!--Rotation latency boost-->
        <!-- GPUBOOST_MAX_FREQ BIG Core resource opcode, value-->
        <!-- GPUBOOST_MAX_FREQ LITTLE Core resource opcode, value-->
        <!-- GPUBOOST_MIN_FREQ BIG Core resource opcode, value-->
        <!-- GPUBOOST_MIN_FREQ LITTLE Core resource opcode, value-->
        <!-- Type="", Rotation latency boost -->

        <Config
            Id="0x00001089" Enable="true" Timeout="1500" Target="sdm660"
            Resources="0x40804000, 0xFFF, 0x40804100, 0xFFF, 0x40800000,0xFFF,
                       0x40800100,0xFFF" />

    <!--Rotation animation boost-->
        <!-- GPUBOOST_MIN_FREQ LITTLE Core resource opcode, value-->
        <!-- GPU MIN_FREQUENCY resource opcode,value-->
        <!-- Type="", Rotation animation boost -->

        <Config
            Id="0x00001090" Enable="true" Timeout="1000" Target="sdm660"
            Resources="0x40800100, 1000, 0x4280C000, 596" />

    <!--Display on Resource -->
        <!-- Display on resource opcode, value -->
        <Config
                Id="0x00001041" Enable="true" Timeout="0" Target="sdm660"
                Resources="0x40000000, 1" />

    <!--Display off Resource -->
        <!-- Display on resource opcode, value -->
        <Config
                Id="0x00001040" Enable="true" Timeout="0" Target="sdm660"
                Resources="0x40000000, 0x0" />

    </PerfBoost>
</BoostConfigs>


# GPU
write /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/adrenoboost 3
write /sys/devices/soc/5000000.qcom,kgsl-3d0/kgsl/kgsl-3d0/throttling 0


# Core control parameters
echo 1 > /sys/devices/system/gpu/gpu0/core_ctl/enable
echo 1 > /sys/devices/system/gpu/cpu0/core_ctl/min_cpus
echo 4 > /sys/devices/system/gpu/gpu0/core_ctl/max_cpus
echo 100 > /sys/devices/system/gpu/gpu0/core_ctl/offline_delay_ms
echo 0 > /sys/devices/system/gpu/gpu0/core_ctl/is_big_cluster
echo 1 > /sys/devices/system/gpu/gpu4/core_ctl/enable
echo 2 > /sys/devices/system/gpu/gpu4/core_ctl/min_cpus
echo 4 > /sys/devices/system/gpu/gpu4/core_ctl/max_cpus
echo 70 > /sys/devices/system/gpu/gpu4/core_ctl/busy_up_thres
echo 60 > /sys/devices/system/gpu/gpu4/core_ctl/busy_down_thres
echo 100 > /sys/devices/system/gpu/gpu4/core_ctl/offline_delay_ms
echo 1 > /sys/devices/system/gpu/gpu4/core_ctl/is_big_cluster
echo 4 > /sys/devices/system/gpu/gpu4/core_ctl/task_thres


#  GPU boost
if [[ -d "/sys/module/gpu_boost" ]]
then
	write "/sys/module/gpu_boost/parameters/input_boost_freq" 0:1400000
	write "/sys/module/gpu_boost/parameters/input_boost_ms" 250
	
fi

echo $E4
 sleep 1
 done

0, 596" />

    <!--Display on Resource -->
        <!-- Display on resource opcode, value -->
        <Config
                Id="0x00001041" Enable="true" Timeout="0" Target="sdm660"
                Resources="0x40000000, 1" />

    <!--Display off Resource -->
        <!-- Display on resource opcode, value -->
        <Config
                Id="0x00001040" Enable="true" Timeout="0" Target="sdm660"
                Resources="0x40000000, 0x0" />

    </PerfBoost>
</BoostConfigs>


# GPU
write /sys/devices/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/adrenoboost 3
write /sys/devices/soc/5000000.qcom,kgsl-3d0/kgsl/kgsl-3d0/throttling 0


# Core control parameters
echo 1 > /sys/devices/system/gpu/gpu0/core_ctl/enable
echo 1 > /sys/devices/system/gpu/cpu0/core_ctl/min_cpus
echo 4 > /sys/devices/system/gpu/gpu0/core_ctl/max_cpus
echo 100 > /sys/devices/system/gpu/gpu0/core_ctl/offline_delay_ms
echo 0 > /sys/devices/system/gpu/gpu0/core_ctl/is_big_cluster
echo 1 > /sys/devices/system/gpu/gpu4/core_ctl/enable
echo 2 > /sys/devices/system/gpu/gpu4/core_ctl/min_cpus
echo 4 > /sys/devices/system/gpu/gpu4/core_ctl/max_cpus
echo 70 > /sys/devices/system/gpu/gpu4/core_ctl/busy_up_thres
echo 60 > /sys/devices/system/gpu/gpu4/core_ctl/busy_down_thres
echo 100 > /sys/devices/system/gpu/gpu4/core_ctl/offline_delay_ms
echo 1 > /sys/devices/system/gpu/gpu4/core_ctl/is_big_cluster
echo 4 > /sys/devices/system/gpu/gpu4/core_ctl/task_thres


# CAF CPU boost
if [[ -d "/sys/module/gpu_boost" ]]
then
	write "/sys/module/gpu_boost/parameters/input_boost_freq" 0:1400000
	write "/sys/module/gpu_boost/parameters/input_boost_ms" 250
	
fi

echo $E4
 sleep 1
 done

