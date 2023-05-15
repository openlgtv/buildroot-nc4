################################################################################
#
# glibc-polyfills
#
################################################################################

GLIBC_POLYFILLS_VERSION = e778cbd37d78dcbbc5808d6cd3e49611f9c57b77
GLIBC_POLYFILLS_SITE = $(call github,smx-smx,glibc-polyfills,$(GLIBC_POLYFILLS_VERSION))

GLIBC_POLYFILLS_INSTALL_STAGING = YES
GLIBC_POLYFILLS_INSTALL_TARGET = NO

# Don't use webOS compatibility hacks
ifeq ($(BR2_PACKAGE_LGTV),y)
GLIBC_POLYFILLS_CONF_OPTS = -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -tno-lgtv-compat"
endif

$(eval $(cmake-package))
