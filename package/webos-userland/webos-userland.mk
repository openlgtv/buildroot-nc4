################################################################################
#
# webos-userland
#
################################################################################

WEBOS_USERLAND_VERSION = 21601ed7b63da168d10d0879c9d462178d5377f5
WEBOS_USERLAND_SITE = $(call github,sundermann,webos-userland,$(WEBOS_USERLAND_VERSION))
WEBOS_USERLAND_LICENSE = Apache/MIT
WEBOS_USERLAND_INSTALL_STAGING = YES

WEBOS_USERLAND_PROVIDES = libegl libgles

WEBOS_USERLAND_POST_INSTALL_TARGET_HOOKS += WEBOS_USERLAND_EXTRA_LIBS_TARGET

WEBOS_USERLAND_POST_INSTALL_STAGING_HOOKS += WEBOS_USERLAND_EXTRA_LIBS_STAGING

define WEBOS_USERLAND_POST_TARGET_CLEANUP
	rm -Rf $(TARGET_DIR)/usr/src
endef
WEBOS_USERLAND_POST_INSTALL_TARGET_HOOKS += WEBOS_USERLAND_POST_TARGET_CLEANUP

$(eval $(cmake-package))
