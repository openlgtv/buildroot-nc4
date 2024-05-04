################################################################################
#
# webos-gnutls
#
################################################################################

WEBOS_GNUTLS_VERSION_MAJOR = 3.3
WEBOS_GNUTLS_VERSION = $(WEBOS_GNUTLS_VERSION_MAJOR).30
WEBOS_GNUTLS_SOURCE = gnutls-$(WEBOS_GNUTLS_VERSION).tar.xz
WEBOS_GNUTLS_SITE = https://www.gnupg.org/ftp/gcrypt/gnutls/v$(WEBOS_GNUTLS_VERSION_MAJOR)
WEBOS_GNUTLS_LICENSE = LGPL-2.1+ (core library)
WEBOS_GNUTLS_LICENSE_FILES = COPYING.LESSER
WEBOS_GNUTLS_DEPENDENCIES = host-pkgconf nettle
WEBOS_GNUTLS_CPE_ID_VENDOR = gnu
# Yocto meta-gplv2 sets --disable-crywrap.
# libgnutls-openssl is not present on webOS (also GPLv3).
# libtasn1 is statically linked on at least webOS 4.0+ but not on webOS 1.
# libp11-kit is not present on webOS.
# There does not seem to be a default trust store.
WEBOS_GNUTLS_CONF_OPTS = \
	--disable-crywrap \
	--disable-openssl-compatibility \
	--with-included-libtasn1 \
	--without-p11-kit \
	--with-default-trust-store-file=no \
	--disable-doc \
	--disable-libdane \
	--disable-rpath \
	--disable-tests \
	--disable-guile \
	--with-libnettle-prefix=$(STAGING_DIR)/usr \
	--without-libdl-prefix \
	--without-libiconv-prefix \
	--without-libintl-prefix \
	--without-libnsl-prefix \
	--without-libpthread-prefix \
	--without-librt-prefix \
	--without-libz-prefix \
	--without-tpm
WEBOS_GNUTLS_CONF_ENV = gl_cv_socket_ipv6=yes \
	ac_cv_header_wchar_h=$(if $(BR2_USE_WCHAR),yes,no) \
	gt_cv_c_wchar_t=$(if $(BR2_USE_WCHAR),yes,no) \
	gt_cv_c_wint_t=$(if $(BR2_USE_WCHAR),yes,no) \
	gl_cv_func_gettimeofday_clobber=no
WEBOS_GNUTLS_INSTALL_STAGING = YES

# libidn support for nommu must exclude the crywrap wrapper (uses fork)
WEBOS_GNUTLS_CONF_OPTS += $(if $(BR2_USE_MMU),,--disable-crywrap)

ifeq ($(BR2_PACKAGE_CRYPTODEV_LINUX),y)
WEBOS_GNUTLS_CONF_OPTS += --enable-cryptodev
WEBOS_GNUTLS_DEPENDENCIES += cryptodev-linux
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
WEBOS_GNUTLS_CONF_OPTS += --with-zlib
WEBOS_GNUTLS_DEPENDENCIES += zlib
else
WEBOS_GNUTLS_CONF_OPTS += --without-zlib
endif

# Some examples in doc/examples use wchar
define WEBOS_GNUTLS_DISABLE_DOCS
	$(SED) 's/ doc / /' $(@D)/Makefile.in
endef

define WEBOS_GNUTLS_DISABLE_TOOLS
	$(SED) 's/\$$(PROGRAMS)//' $(@D)/src/Makefile.in
	$(SED) 's/) install-exec-am/)/' $(@D)/src/Makefile.in
endef

WEBOS_GNUTLS_POST_PATCH_HOOKS += WEBOS_GNUTLS_DISABLE_DOCS
WEBOS_GNUTLS_POST_PATCH_HOOKS += WEBOS_GNUTLS_DISABLE_TOOLS

$(eval $(autotools-package))
