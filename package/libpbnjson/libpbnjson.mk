################################################################################
#
# libpbnjson
#
################################################################################

LIBPBNJSON_VERSION = master
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
	gmp \
	libglib2 \
	liburiparser \
	yajl

LIBPBNJSON_SUPPORTS_IN_SOURCE_BUILD = NO

define LINK_CMAKE_MODULES
	ln -snf $(STAGING_DIR)/usr/local/webos/Modules/webOS $(@D)/webOS
endef

define LOCAL_BUILD_FIXES
	$(SED) 's|static_assert|_Static_assert|g' -i $(@D)/src/pbnjson_c/jvalue/num_conversion.c
endef

GLIB_CFLAGS += \
	-DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_54 \
	-DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_54

LIBPBNJSON_CFLAGS += $(GLIB_CFLAGS)
LIBPBNJSON_CXXFLAGS += $(GLIB_CFLAGS)

LIBPBNJSON_CONF_OPTS += \
	-DCMAKE_MODULE_PATH=$(STAGING_DIR)/usr/local/webos/Modules \
	-DCMAKE_C_FLAGS="$(LIBPBNJSON_CFLAGS)" \
	-DCMAKE_CXX_FLAGS="$(LIBPBNJSON_CXXFLAGS)" \
	-DWEBOS_INSTALL_ROOT=/

LIBPBNJSON_POST_PATCH_HOOKS += LOCAL_BUILD_FIXES
LIBPBNJSON_PRE_CONFIGURE_HOOKS += LINK_CMAKE_MODULES

$(eval $(cmake-package))
