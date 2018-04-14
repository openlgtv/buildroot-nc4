################################################################################
#
# sdlmame
#
################################################################################

SDLMAME_VERSION = master
SDLMAME_SITE = https://github.com/mamedev/mame.git
SDLMAME_SITE_METHOD = git
SDLMAME_DEPENDENCIES = sdl2 sdl2_ttf

TARGET_CFLAGS += -I$(STAGING_DIR)/usr/include
TARGET_MAKE_ENV += \
	OS=linux \
	CROSS_BUILD=1 \
	TARGETOS=linux \
	OSD=sdl \
	NO_USE_MIDI=1 \
	NO_X11=1 \
	NO_USE_XINPUT=1 \
	NO_OPENGL=1 \
	USE_QTDEBUG=0 \
	TOOLCHAIN=$(TARGET_CROSS) \
	CFLAGS="$(TARGET_CFLAGS)" \
	PKG_CONFIG_PATH="$(STAGING_DIR)/usr/lib/pkgconfig" \
	PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)"

#ifeq ($(BR2_arm),y)
#TARGET_MAKE_ENV += PLATFORM=arm
#endif

#ifeq (y,$(filter y,$(BR2_i386) $(BR2_x86_64)))
#TARGET_MAKE_ENV += PLATFORM=x86
#endif

#ifeq ($(BR2_powerpc),y)
#TARGET_MAKE_ENV += PLATFORM=ppc
#endif

#ifeq (y,$(filter y,$(BR2_mips) $(BR2_mipsel)))
#TARGET_MAKE_ENV += PLATFORM=mips
#endif

#ifeq (y,$(filter y,$(BR2_mips64) $(BR2_mips64el)))
#TARGET_MAKE_ENV += PLATFORM=mips64
#endif

#ifeq ($(BR2_aarch64),y)
#TARGET_MAKE_ENV += PLATFORM=arm64
#endif

#	AS="$(TARGET_AS)" \
#	AR="$(TARGET_AR)" \
#	LD="$(TARGET_LD)" \
#	CC="$(TARGET_CC)" \
#	CXX="$(TARGET_CXX)" \
#	CPP="$(TARGET_CPP)" \
#	RANLIB="$(TARGET_RANLIB)" \

define SDLMAME_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define SDLMAME_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install
endef

$(eval $(generic-package))