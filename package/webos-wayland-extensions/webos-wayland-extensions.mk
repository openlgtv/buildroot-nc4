################################################################################
#
# webos-wayland-extensions
#
################################################################################

WEBOS_WAYLAND_EXTENSIONS_VERSION = 715829259cfb061ddcb5e16efa2a420e99af57e8
WEBOS_WAYLAND_EXTENSIONS_SITE = $(call github,webosose,webos-wayland-extensions,$(WEBOS_WAYLAND_EXTENSIONS_VERSION))

WEBOS_WAYLAND_EXTENSIONS_INSTALL_STAGING = YES
WEBOS_WAYLAND_EXTENSIONS_INSTALL_TARGET = NO
WEBOS_WAYLAND_EXTENSIONS_SUPPORTS_IN_SOURCE_BUILD = NO

WEBOS_WAYLAND_EXTENSIONS_DEPENDENCIES = host-wayland

define WEBOS_WAYLAND_EXTENSIONS_LINK_CMAKE_MODULES
	ln -snf $(STAGING_DIR)/usr/local/webos/Modules/webOS $(@D)/webOS
endef

WEBOS_WAYLAND_EXTENSIONS_PRE_CONFIGURE_HOOKS += WEBOS_WAYLAND_EXTENSIONS_LINK_CMAKE_MODULES

WEBOS_WAYLAND_EXTENSIONS_CONF_OPTS += \
	-DCMAKE_POLICY_DEFAULT_CMP0053=OLD \
	-DCMAKE_MODULE_PATH="$(@D)/cmake;$(STAGING_DIR)/usr/local/webos/Modules" \
	-DWEBOS_INSTALL_ROOT=/

$(eval $(cmake-package))
