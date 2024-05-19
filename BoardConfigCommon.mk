#
# Copyright (C) 2023 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

COMMON_PATH := device/samsung/universal9830-common

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a55

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# Audio
BOARD_LOW_LATENCY_CAPTURE_DURATION := 20
BOARD_USB_PLAYBACK_DURATION := 5
BOARD_USE_MMAP_HW_VOLUME_CONTROL := true
BOARD_USE_QUAD_MIC := true
BOARD_USE_SEC_AUDIO_DYNAMIC_NREC := true
BOARD_USE_SEC_AUDIO_PARAM_UPDATE := false
BOARD_USE_SEC_AUDIO_RESAMPLER := true
BOARD_USE_SEC_AUDIO_SAMSUNGRECORD := true
BOARD_USE_SEC_AUDIO_SOUND_TRIGGER_ENABLED := true
# BOARD_USE_SEC_AUDIO_SUPPORT_GAMECHAT_SPK_AEC := true
BOARD_USE_SEC_AUDIO_SUPPORT_LISTENBACK_DSPEFFECT := true
BOARD_USE_USB_OFFLOAD := true

ifneq ($(TARGET_DEVICE),r8s)
BOARD_USE_CAMCORDER_QUAD_MIC := true
endif

# Camera
$(call soong_config_set,samsungCameraVars,usage_64bit,true)
SOONG_CONFIG_NAMESPACES += samsungCameraVars
SOONG_CONFIG_samsungCameraVars += extra_ids
ifeq ($(TARGET_DEVICE),r8s)
# ID=50 is telephoto
SOONG_CONFIG_samsungCameraVars_extra_ids := 50
else
# ID=52 is telephoto
SOONG_CONFIG_samsungCameraVars_extra_ids := 52
endif

# Compatibility Matrix
DEVICE_MATRIX_FILE := $(COMMON_PATH)/compatibility_matrix.xml

# Dexpreopt
ifeq ($(HOST_OS),linux)
  ifneq ($(TARGET_BUILD_VARIANT),eng)
    WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY ?= false
    WITH_DEXPREOPT := true
  endif
endif

# Dynamic Partitions
BOARD_SAMSUNG_DYNAMIC_PARTITIONS_SIZE := 9432989696
BOARD_SAMSUNG_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext vendor product odm
BOARD_SUPER_PARTITION_GROUPS := samsung_dynamic_partitions
BOARD_SUPER_PARTITION_SIZE := 9437184000

ifneq ($(WITH_GMS),true)
  BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 1258291200
  BOARD_PRODUCTIMAGE_EXTFS_INODE_COUNT := -1
  BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 1258291200
  BOARD_SYSTEMIMAGE_EXTFS_INODE_COUNT := -1
  BOARD_SYSTEM_EXTIMAGE_PARTITION_RESERVED_SIZE := 1258291200
  BOARD_SYSTEM_EXTIMAGE_EXTFS_INODE_COUNT := -1
endif

# DTB
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_DTB_CFG := $(COMMON_PATH)/configs/kernel/exynos990.cfg

# DTBO
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_DTBO_CFG := $(COMMON_PATH)/configs/kernel/$(TARGET_DEVICE).cfg

# Filesystem
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Firmware
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Framework Matrix
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := $(COMMON_PATH)/device_framework_matrix.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += vendor/lineage/config/device_framework_matrix.xml

# Kernel
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_CUSTOM_BOOTIMG := true
BOARD_MKBOOTIMG_ARGS := --base 0x10000000 --pagesize 2048 --dtb_offset 0x00000000 --kernel_offset 0x00008000 --ramdisk_offset 0x01000000 --tags_offset 0x00000100  --header_version 2  
#BOARD_KERNEL_CMDLINE := The bootloader ignores the cmdline from the boot.img
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_USE_LZ4 := true

# Keymaster
TARGET_KEYMASTER_VARIANT := samsung

# Metadata
BOARD_USES_METADATA_PARTITION := true

# Lineage health
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_PATH := /sys/class/power_supply/battery/charging_enabled
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED := 1
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED := 0
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS := true
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE := true
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE := false

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 61865984
BOARD_CACHEIMAGE_PARTITION_SIZE := 629145600
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_FLASH_BLOCK_SIZE := 4096
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 69009408
BOARD_ROOT_EXTRA_FOLDERS := efs

# Platform
BOARD_VENDOR := samsung
TARGET_BOARD_PLATFORM := universal990
TARGET_BOOTLOADER_BOARD_NAME := exynos990
TARGET_SOC := exynos990

# Properties
TARGET_SYSTEM_PROP += $(COMMON_PATH)/system.prop
TARGET_SYSTEM_EXT_PROP += $(COMMON_PATH)/system_ext.prop
TARGET_VENDOR_PROP += $(COMMON_PATH)/vendor.prop

# Recovery
BOARD_HAS_DOWNLOAD_MODE := true
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_USES_FULL_RECOVERY_IMAGE := true
TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/ramdisk/etc/fstab.exynos990
TARGET_RECOVERY_PIXEL_FORMAT := "ABGR_8888"

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := $(COMMON_PATH)/releasetools

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# SECComp filters
BOARD_SECCOMP_POLICY += $(COMMON_PATH)/seccomp

# Security
VENDOR_SECURITY_PATCH := 2024-03-01

# SELinux
include device/lineage/sepolicy/exynos/sepolicy.mk
BOARD_SEPOLICY_TEE_FLAVOR := teegris
include device/samsung_slsi/sepolicy/sepolicy.mk
BOARD_VENDOR_SEPOLICY_DIRS += $(COMMON_PATH)/sepolicy/vendor

# SoundTrigger
BOARD_SOUNDTRIGGER_CONFIG_PATH := $(COMMON_PATH)/configs/sthal
BOARD_USE_SOUNDTRIGGER_HAL := true
BOARD_USE_SOUNDTRIGGER_HAL_2_3 := true
BOARD_USE_SOUNDTRIGGER_HAL_MMAP := true

# USB
$(call soong_config_set,samsungUsbGadgetVars,gadget_name,10e00000.dwc3)

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# Call Samsung LSI board support package
include hardware/samsung_slsi-linaro/config/BoardConfig9830.mk

# Call the proprietary setup
include vendor/samsung/universal9830-common/BoardConfigVendor.mk
