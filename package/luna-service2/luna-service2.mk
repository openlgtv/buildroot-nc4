################################################################################
#
# luna-service2
#
################################################################################

LUNA_SERVICE2_VERSION = master
LUNA_SERVICE2_SITE = $(call github,webosose,luna-service2,$(LUNA_SERVICE2_VERSION))
LUNA_SERVICE2_INSTALL_STAGING = YES
LUNA_SERVICE2_SUPPORTS_IN_SOURCE_BUILD = NO

LUNA_SERVICE2_DEPENDENCIES = \
	host-pkgconf \
	cmake-modules-webos \
	libglib2 \
	host-pkgconf \
	libpbnjson \
	pmloglib

define LUNA_SERVICE2_LINK_CMAKE_MODULES
	ln -snf $(STAGING_DIR)/usr/local/webos/Modules/webOS $(@D)/webOS
endef

LUNA_SERVICE2_CFLAGS += \
	-DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_54 \
	-DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_54
	
LUNA_SERVICE2_CXXFLAGS += \
	-DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_54 \
	-DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_54

LUNA_SERVICE2_PRE_CONFIGURE_HOOKS += \
	LUNA_SERVICE2_LINK_CMAKE_MODULES \

LUNA_SERVICE2_CONF_OPTS += \
	-DCMAKE_MODULE_PATH=$(STAGING_DIR)/usr/local/webos/Modules \
	-DCMAKE_C_FLAGS="$(LUNA_SERVICE2_CFLAGS)" \
	-DCMAKE_CXX_FLAGS="$(LUNA_SERVICE2_CXXFLAGS)" \
	-DWEBOS_INSTALL_ROOT=/ 
	
$(eval $(cmake-package))
