################################################################################
#
# webos-gmp
#
################################################################################

WEBOS_GMP_VERSION = 4.2.1
WEBOS_GMP_SITE = $(BR2_GNU_MIRROR)/gmp
WEBOS_GMP_SOURCE = gmp-$(WEBOS_GMP_VERSION).tar.bz2
WEBOS_GMP_INSTALL_STAGING = YES
WEBOS_GMP_LICENSE = LGPL-2.1+ or GPL-2.0+
WEBOS_GMP_LICENSE_FILES = COPYING.LIB COPYING
WEBOS_GMP_CPE_ID_VENDOR = gmplib
WEBOS_GMP_DEPENDENCIES = host-m4

# 0001-mpz-inp_raw.c-Avoid-bit-size-overflows.patch
WEBOS_GMP_IGNORE_CVES += CVE-2021-43618

ifeq ($(BR2_INSTALL_LIBSTDCPP),y)
WEBOS_GMP_CONF_OPTS += --enable-cxx
else
WEBOS_GMP_CONF_OPTS += --disable-cxx
endif

$(eval $(autotools-package))
