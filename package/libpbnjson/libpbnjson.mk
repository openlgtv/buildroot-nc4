################################################################################
#
# libpbnjson
#
################################################################################

LIBPBNJSON_VERSION = db844b635d32283d0571347186a7fc2dcbd5fa31
LIBPBNJSON_SITE = $(call github,webosose,libpbnjson,$(LIBPBNJSON_VERSION))
LIBPBNJSON_INSTALL_STAGING = YES

LIBPBNJSON_DEPENDENCIES = \
	host-flex \
	host-bison \
	host-pkgconf \
	host-gperf \
	host-lemon \
	cmake-modules-webos \
	boost \
	$(if $(BR2_PACKAGE_WEBOS_GMP),webos-gmp,gmp) \
	libglib2 \
	liburiparser \
	yajl

LIBPBNJSON_SUPPORTS_IN_SOURCE_BUILD = NO

define LIBPBNJSON_LINK_CMAKE_MODULES
	ln -snf $(STAGING_DIR)/usr/local/webos/Modules/webOS $(@D)/webOS
endef

define LIBPBNJSON_LOCAL_BUILD_FIXES
	$(SED) 's|static_assert|_Static_assert|g' -i $(@D)/src/pbnjson_c/jvalue/num_conversion.c
endef

LIBPBNJSON_CFLAGS += \
	-DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_54 \
	-DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_54

LIBPBNJSON_CXXFLAGS += \
	-DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_54 \
	-DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_54

LIBPBNJSON_CONF_OPTS += \
	-DCMAKE_MODULE_PATH=$(STAGING_DIR)/usr/local/webos/Modules \
	-DCMAKE_C_FLAGS="$(LIBPBNJSON_CFLAGS)" \
	-DCMAKE_CXX_FLAGS="$(LIBPBNJSON_CXXFLAGS)" \
	-DWEBOS_INSTALL_ROOT=/

LIBPBNJSON_POST_PATCH_HOOKS += LIBPBNJSON_LOCAL_BUILD_FIXES
LIBPBNJSON_PRE_CONFIGURE_HOOKS += LIBPBNJSON_LINK_CMAKE_MODULES

$(eval $(cmake-package))
