################################################################################
#
# libwebosi18n
#
################################################################################

LIBWEBOSI18N_VERSION = master
LIBWEBOSI18N_SITE = $(call github,webosose,libwebosi18n,$(LIBWEBOSI18N_VERSION))
LIBWEBOSI18N_INSTALL_STAGING = YES
LIBWEBOSI18N_SUPPORTS_IN_SOURCE_BUILD = NO

LIBWEBOSI18N_DEPENDENCIES = \
	host-pkgconf \
	cmake-modules-webos \
	libpbnjson \
	boost

define LINK_CMAKE_MODULES
	ln -snf $(STAGING_DIR)/usr/local/webos/Modules/webOS $(@D)/webOS
endef

LIBWEBOSI18N_PRE_CONFIGURE_HOOKS += LINK_CMAKE_MODULES

LIBWEBOSI18N_CONF_OPTS += \
	-DCMAKE_POLICY_DEFAULT_CMP0053=OLD \
	-DCMAKE_MODULE_PATH=$(STAGING_DIR)/usr/local/webos/Modules \
	-DWEBOS_INSTALL_ROOT=/

$(eval $(cmake-package))
