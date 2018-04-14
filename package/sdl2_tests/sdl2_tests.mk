################################################################################
#
# sdl2
#
################################################################################

SDL2_TESTS_VERSION = 2.0.3
SDL2_TESTS_SOURCE = SDL2-$(SDL2_TESTS_VERSION).tar.gz
SDL2_TESTS_SITE = http://www.libsdl.org/release
SDL2_TESTS_LICENSE = zlib
SDL2_TESTS_LICENSE_FILES = COPYING
SDL2_TESTS_INSTALL_STAGING = YES
SDL2_TESTS_SUBDIR = test

#SDL2_CONF_OPTS +=

ifeq ($(BR2_PACKAGE_SDL2_DIRECTFB),y)
SDL2_TESTS_DEPENDENCIES += directfb
SDL2_TESTS_CONF_OPTS += --enable-video-directfb
TARGET_CFLAGS += -I$(STAGING_DIR)/usr/include/directfb
else
SDL2_TESTS_CONF_OPTS += --disable-video-directfb
endif


# We must enable static build to get compilation successful.
SDL2_TESTS_CONF_OPTS += --enable-static

define SDL2_TESTS_CONFIGURE_CMDS
	(cd $(@D)/$(SDL2_TESTS_SUBDIR); rm -rf config.cache; \
		$(TARGET_CONFIGURE_OPTS) \
		$(TARGET_CONFIGURE_ARGS) \
		./configure \
		$(SDL2_TESTS_CONF_OPTS) \
	)
endef

define SDL2_TESTS_BUILD_CMDS
	$(MAKE) -C $(@D)/$(SDL2_TESTS_SUBDIR)
endef

define SDL2_TESTS_INSTALL_TARGET_CMDS
	find $(@D)/$(SDL2_TESTS_SUBDIR) -maxdepth 1 -type f -perm /a+x -exec cp {} $(TARGET_DIR)/usr/bin/ \;
	mkdir -p $(TARGET_DIR)/usr/share/sdl2-tests
	cp -Ra $(@D)/$(SDL2_TESTS_SUBDIR)/shapes $(TARGET_DIR)/usr/share/sdl2-tests
endef

$(eval $(generic-package))
