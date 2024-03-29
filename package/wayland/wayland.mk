################################################################################
#
# wayland
#
################################################################################

WAYLAND_VERSION = 1.11.0
WAYLAND_SITE = http://wayland.freedesktop.org/releases
WAYLAND_SOURCE = wayland-$(WAYLAND_VERSION).tar.xz
WAYLAND_LICENSE = MIT
WAYLAND_LICENSE_FILES = COPYING
WAYLAND_INSTALL_STAGING = YES
WAYLAND_DEPENDENCIES = host-pkgconf host-wayland expat libffi libxml2

HOST_WAYLAND_VERSION = 1.15.0
HOST_WAYLAND_SITE = http://wayland.freedesktop.org/releases
HOST_WAYLAND_SOURCE = wayland-$(HOST_WAYLAND_VERSION).tar.xz
HOST_WAYLAND_DEPENDENCIES = host-pkgconf host-expat host-libffi host-libxml2

# wayland-scanner is only needed for building, not on the target
WAYLAND_CONF_OPTS = --disable-scanner --with-host-scanner

# Remove the DTD from the target, it's not needed at runtime
define WAYLAND_TARGET_CLEANUP
	rm -rf $(TARGET_DIR)/usr/share/wayland
endef
WAYLAND_POST_INSTALL_TARGET_HOOKS += WAYLAND_TARGET_CLEANUP

$(eval $(autotools-package))
$(eval $(host-autotools-package))
