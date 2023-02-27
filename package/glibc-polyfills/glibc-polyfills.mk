################################################################################
#
# glibc-polyfills
#
################################################################################

GLIBC_POLYFILLS_VERSION = 5a3fd3f732aa1899f736ff839215761e77d0f3e5
GLIBC_POLYFILLS_SITE = $(call github,smx-smx,glibc-polyfills,$(GLIBC_POLYFILLS_VERSION))

GLIBC_POLYFILLS_INSTALL_STAGING = YES
GLIBC_POLYFILLS_INSTALL_TARGET = NO

$(eval $(cmake-package))