################################################################################
#
# webos-userland
#
################################################################################

WEBOS_USERLAND_VERSION = f3a6cb591dac7525f6f2ce145361757ca4e043b5
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
