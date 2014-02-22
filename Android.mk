LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

kmod_common_cflags := \
				-DSYSCONFDIR=\"/system/etc\" \
				-DVERSION=\"16\" \
				-DPACKAGE=\"kmod\" \
				-Wno-unused-parameter \
				-Wno-missing-field-initializers \
				-Wno-maybe-uninitialized \
				-D_BSD_SOURCE=\"1\"

				
kmod_common_includes := external/kmod/lib
					
kmod_lib_src_files := lib/libkmod-lib.c \
					lib/libkmod-list.c \
					lib/libkmod-config.c \
					lib/libkmod-index.c \
					lib/libkmod-module.c \
					lib/libkmod-file.c \
					lib/libkmod-elf.c \
					lib/libkmod-signature.c \
					lib/libkmod-hash.c \
					lib/libkmod-array.c \
					lib/libkmod-util.c 

kmod_src_files := tools/kmod_main.c \
					tools/lsmod.c \
					tools/rmmod.c \
					tools/insmod.c \
					tools/modinfo.c \
					tools/modprobe.c \
					tools/log.c \
					tools/static-nodes.c 



include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(kmod_lib_src_files)
LOCAL_MODULE := libkmod
LOCAL_CFLAGS += $(kmod_common_cflags) 
include $(BUILD_SHARED_LIBRARY)


include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(kmod_lib_src_files)
LOCAL_MODULE := libkmod
LOCAL_CFLAGS += $(kmod_common_cflags) 
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(kmod_lib_src_files)
LOCAL_MODULE := libkmod
LOCAL_CFLAGS += -D_GNU_SOURCE=1 $(kmod_common_cflags) 
include $(BUILD_HOST_STATIC_LIBRARY)


include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(kmod_lib_src_files)
LOCAL_MODULE := libkmod
LOCAL_CFLAGS += -D_GNU_SOURCE=1 $(kmod_common_cflags) 
include $(BUILD_HOST_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(kmod_src_files)
LOCAL_MODULE := kmod
LOCAL_SHARED_LIBRARIES := libkmod
LOCAL_C_INCLUDES := $(kmod_common_includes)
LOCAL_CFLAGS += $(kmod_common_cflags) 
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(kmod_src_files)
LOCAL_MODULE := kmod_static
LOCAL_STATIC_LIBRARIES := libc libkmod
LOCAL_C_INCLUDES := $(kmod_common_includes)
LOCAL_CFLAGS += $(kmod_common_cflags) 
LOCAL_FORCE_STATIC_EXECUTABLE := true
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(kmod_src_files) tools/depmod.c 
LOCAL_MODULE := kmod
LOCAL_SHARED_LIBRARIES := libkmod
LOCAL_C_INCLUDES := $(kmod_common_includes)
LOCAL_CFLAGS += -D_GNU_SOURCE=1  $(kmod_common_cflags) 
include $(BUILD_HOST_EXECUTABLE)

