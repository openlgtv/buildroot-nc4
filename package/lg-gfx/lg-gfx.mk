################################################################################
#
# lg-gfx
#
################################################################################

# SDK 5_01_01_01 only support EABIhf so we downgrade to 5_01_00_01 if EABIhf is
# not available.
ifeq ($(BR2_ARM_EABIHF),y)
LG_GFX_VERSION = 5_01_01_02
LG_GFX_SOURCE = Graphics_SDK_setuplinux_hardfp_$(LG_GFX_VERSION).bin
else
LG_GFX_VERSION = 5_01_00_01
LG_GFX_SOURCE = Graphics_SDK_setuplinux_softfp_$(LG_GFX_VERSION).bin
endif

LG_GFX_SO_VERSION = 1.10.2359475
LG_GFX_SITE = http://downloads.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/gfxsdk/$(LG_GFX_VERSION)/exports
LG_GFX_LICENSE = Technology / Software Publicly Available
LG_GFX_LICENSE_FILES = TSPA.txt
LG_GFX_INSTALL_STAGING = YES

LG_GFX_DEPENDENCIES = linux

LG_GFX_PROVIDES = libegl libgles powervr

ifeq ($(BR2_PACKAGE_LG_GFX_DEBUG),y)
LG_GFX_DEBUG_LIB = dbg
else
LG_GFX_DEBUG_LIB = rel
endif

LG_GFX_OMAPES = 5.x
LG_GFX_BIN_PATH = gfx_$(LG_GFX_DEBUG_LIB)_es$(LG_GFX_OMAPES)

LG_GFX_DEMO_MAKE_OPTS = \
	PLATFORM=LinuxARMV7 \
	X11BUILD=0 \
	PLAT_CC="$(TARGET_CC)" \
	PLAT_CPP="$(TARGET_CXX)" \
	PLAT_AR="$(TARGET_AR)"

# The only required binary is pvrsrvctl all others are optional
LG_GFX_BIN = pvrsrvctl

ifeq ($(BR2_PACKAGE_LG_GFX_DEBUG),y)
LG_GFX_BIN += \
	eglinfo ews_server ews_server_es2 ews_test_gles1 ews_test_gles2 \
	ews_test_swrender gles1test1 gles2test1 pvr2d_test services_test \
	sgx_blit_test sgx_clipblit_test sgx_flip_test sgx_init_test \
	sgx_render_flip_test xeglinfo xgles1test1 xgles2test1 xmultiegltest
endif

#libews libpvrPVR2D_WAYLANDWSEGL pvr_drv 
LG_GFX_LIBS = \
	libpvr2d \
	libpvrPVR2D_CobraNetCast40WSEGL \
	libpvrPVR2D_NullWSEGL \
	libPVRScopeServices libsrv_init libsrv_um libusc

LG_GFX_EGLIMAGE_LIBS = \
	libEGL libGLES_CM libGLESv1_CM libGLESv2 libglslcompiler libIMGegl

LG_GFX_API_LIBS = \
	libafopenapi libafcommon liblgopenapi libdbgfrwk

LG_GFX_MTK5398_HAL = \
	libgal libmtal libmtk5398

LG_GFX_DEMOS = ChameleonMan MagicLantern
LG_GFX_DEMOS_LOC = GFX_Linux_SDK/OGLES2/SDKPackage/Demos
LG_GFX_DEMOS_MAKE_LOC = OGLES2/Build/LinuxGeneric
LG_GFX_DEMOS_BIN_LOC = OGLES2/Build/LinuxARMV7/ReleaseRaw/

LG_GFX_HDR_DIRS = OGLES2/EGL OGLES2/EWS OGLES2/GLES2 OGLES2/KHR \
	OGLES/GLES bufferclass_ti/ pvr2d/ wsegl/

define LG_GFX_EXTRACT_CMDS
	chmod +x $(DL_DIR)/$(LG_GFX_SOURCE)
	printf "Y\nY\n qY\n\n" | $(DL_DIR)/$(LG_GFX_SOURCE) \
		--prefix $(@D) \
		--mode console
endef

ifeq ($(BR2_PACKAGE_LG_GFX_DEMOS),y)
define LG_GFX_BUILD_DEMO_CMDS
	$(foreach demo, $(LG_GFX_DEMOS), \
		$(TARGET_MAKE_ENV) $(MAKE1) -C \
			$(@D)/$(LG_GFX_DEMOS_LOC)/$(demo)/$(LG_GFX_DEMOS_MAKE_LOC) \
			$(LG_GFX_DEMO_MAKE_OPTS) all
	)
endef
endif

define LG_GFX_BUILD_CMDS
	$(LG_GFX_BUILD_DEMO_CMDS)
endef

# Install libs
# argument 1 is the location to install to (e.g. STAGING_DIR, TARGET_DIR)
define LG_GFX_INSTALL_LIBS
	$(foreach lib,$(LG_GFX_LIBS),
		$(INSTALL) -D -m 0644 package/lg-gfx/libs/$(lib).so \
			$(1)/usr/lib/$(lib).so.$(LG_GFX_SO_VERSION); \
		ln -sf $(lib).so.$(LG_GFX_SO_VERSION) \
			$(1)/usr/lib/$(lib).so
	)
	$(foreach lib,$(LG_GFX_EGLIMAGE_LIBS),
		$(if $(BR2_PACKAGE_LG_GFX_EGLIMAGE),
			$(INSTALL) -D -m 0644 package/lg-gfx/libs/$(lib).so \
				$(1)/usr/lib/$(lib).so.$(LG_GFX_SO_VERSION);
		,
			$(INSTALL) -D -m 0644 $(@D)/$(LG_GFX_BIN_PATH)/$(lib).so \
				$(1)/usr/lib/$(lib).so.$(LG_GFX_SO_VERSION);
		)
		ln -sf $(lib).so.$(LG_GFX_SO_VERSION) \
			$(1)/usr/lib/$(lib).so
	)
	$(foreach lib,$(LG_GFX_API_LIBS),
		$(INSTALL) -D -m 0644 package/lg-gfx/libs/lg/$(lib).so \
			$(1)/usr/lib/$(lib).so.$(LG_GFX_SO_VERSION); \
		ln -sf $(lib).so.$(LG_GFX_SO_VERSION) \
			$(1)/usr/lib/$(lib).so
	)
	$(foreach lib,$(LG_GFX_MTK5398_HAL),
		$(INSTALL) -D -m 0644 package/lg-gfx/libs/mtk/$(lib).so \
			$(1)/usr/lib/$(lib).so.$(LG_GFX_SO_VERSION); \
		ln -sf $(lib).so.$(LG_GFX_SO_VERSION) \
			$(1)/usr/lib/$(lib).so
	)
endef

define LG_GFX_INSTALL_STAGING_CMDS
	$(foreach incdir,$(LG_GFX_HDR_DIRS),
		$(INSTALL) -d $(STAGING_DIR)/usr/include/$(notdir $(incdir)); \
		$(INSTALL) -D -m 0644 $(@D)/include/$(incdir)/*.h \
			$(STAGING_DIR)/usr/include/$(notdir $(incdir))/
	)
	$(call LG_GFX_INSTALL_LIBS,$(STAGING_DIR))

	$(INSTALL) -D -m 0644 package/lg-gfx/egl.pc \
		$(STAGING_DIR)/usr/lib/pkgconfig/egl.pc
	$(INSTALL) -D -m 0644 package/lg-gfx/glesv2.pc \
		$(STAGING_DIR)/usr/lib/pkgconfig/glesv2.pc
endef

define LG_GFX_INSTALL_BINS_CMDS
	$(foreach bin,$(LG_GFX_BIN),
		[ ! -f $(@D)/$(LG_GFX_BIN_PATH)/$(bin) ] && cp $(@D)/gfx_rel_es$(LG_GFX_OMAPES)/$(bin) $(@D)/$(LG_GFX_BIN_PATH) || exit 0
		$(INSTALL) -D -m 0755 $(@D)/$(LG_GFX_BIN_PATH)/$(bin) \
			$(TARGET_DIR)/usr/bin/$(bin)
	)
endef

define LG_GFX_INSTALL_CONF_CMDS
	# libs use the following file for configuration.
	$(INSTALL) -D -m 0644 package/lg-gfx/powervr.ini \
		$(TARGET_DIR)/etc/powervr.ini
endef

ifeq ($(BR2_PACKAGE_LG_GFX_DEMOS),y)
define LG_GFX_INSTALL_DEMOS_CMDS
	$(foreach demo,$(LG_GFX_DEMOS),
		$(INSTALL) -D -m 0755 \
		$(@D)/$(LG_GFX_DEMOS_LOC)/$(demo)/$(LG_GFX_DEMOS_BIN_LOC)/OGLES2$(demo) \
		$(TARGET_DIR)/usr/bin/OGLES2$(demo)
	)
endef
endif

define LG_GFX_INSTALL_TARGET_CMDS
	$(LG_GFX_INSTALL_BINS_CMDS)
	$(call LG_GFX_INSTALL_LIBS,$(TARGET_DIR))
	$(LG_GFX_INSTALL_CONF_CMDS)
	$(LG_GFX_INSTALL_DEMOS_CMDS)
endef

$(eval $(generic-package))
