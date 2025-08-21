################################################################################
#
# gnutls
#
################################################################################

# When bumping, make sure *all* --without-libfoo-prefix options are in GNUTLS_CONF_OPTS
GNUTLS_VERSION_MAJOR = 3.8
GNUTLS_VERSION = $(GNUTLS_VERSION_MAJOR).9
GNUTLS_SOURCE = gnutls-$(GNUTLS_VERSION).tar.xz
GNUTLS_SITE = https://www.gnupg.org/ftp/gcrypt/gnutls/v$(GNUTLS_VERSION_MAJOR)
GNUTLS_LICENSE = LGPL-2.1+ (core library)
GNUTLS_LICENSE_FILES = COPYING.LESSERv2 README.md

GNUTLS_DEPENDENCIES = host-pkgconf libtasn1 libunistring nettle
GNUTLS_CPE_ID_VENDOR = gnu
# Don't add an optional dependency on tpm2-tss as it creates a
# circular dependency: tpm2-tss -> libcurl -> gnutls -> tmp2-tss.
GNUTLS_CONF_OPTS = \
	--disable-doc \
	--disable-libdane \
	--disable-rpath \
	--disable-tests \
	--without-included-unistring \
	--without-libcrypto-prefix \
	--without-libdl-prefix \
	--without-libev-prefix \
	--without-libiconv-prefix \
	--without-libintl-prefix \
	--without-libpthread-prefix \
	--without-libseccomp-prefix \
	--without-librt-prefix \
	--without-libz-prefix \
	--without-tpm \
	--without-tpm2 \
	$(if $(BR2_PACKAGE_GNUTLS_TOOLS),--enable-tools,--disable-tools) \
	$(if $(BR2_PACKAGE_GNUTLS_ENABLE_SSL2),--enable,--disable)-ssl2-support \
	$(if $(BR2_PACKAGE_GNUTLS_ENABLE_GOST),--enable,--disable)-gost
GNUTLS_CONF_ENV = gl_cv_socket_ipv6=yes \
	ac_cv_header_wchar_h=$(if $(BR2_USE_WCHAR),yes,no) \
	gt_cv_c_wchar_t=$(if $(BR2_USE_WCHAR),yes,no) \
	gt_cv_c_wint_t=$(if $(BR2_USE_WCHAR),yes,no) \
	gl_cv_func_gettimeofday_clobber=no
GNUTLS_INSTALL_STAGING = YES

HOST_GNUTLS_DEPENDENCIES = host-pkgconf host-libtasn1 host-libunistring host-nettle
HOST_GNUTLS_CONF_OPTS = \
	--disable-doc \
	--disable-libdane \
	--disable-rpath \
	--disable-tests \
	--without-included-unistring \
	--without-libcrypto-prefix \
	--without-libdl-prefix \
	--without-libev-prefix \
	--without-libiconv-prefix \
	--without-libintl-prefix \
	--without-libpthread-prefix \
	--without-libseccomp-prefix \
	--without-librt-prefix \
	--without-libz-prefix \
	--without-tpm \
	--without-tpm2 \
	--disable-openssl-compatibility \
	--without-brotli \
	--without-idn \
	--without-p11-kit \
	--without-zlib \
	--without-zstd

ifeq ($(BR2_PACKAGE_GNUTLS_OPENSSL),y)
GNUTLS_LICENSE += , GPL-3.0+ (gnutls-openssl library)
GNUTLS_LICENSE_FILES += COPYING
GNUTLS_CONF_OPTS += --enable-openssl-compatibility
else
GNUTLS_CONF_OPTS += --disable-openssl-compatibility
endif

ifeq ($(BR2_PACKAGE_BROTLI),y)
GNUTLS_CONF_OPTS += --with-brotli
GNUTLS_DEPENDENCIES += brotli
else
GNUTLS_CONF_OPTS += --without-brotli
endif

ifeq ($(BR2_PACKAGE_CRYPTODEV_LINUX),y)
GNUTLS_CONF_OPTS += --enable-cryptodev
GNUTLS_DEPENDENCIES += cryptodev-linux
endif

ifeq ($(BR2_PACKAGE_LIBIDN2),y)
GNUTLS_CONF_OPTS += --with-idn
GNUTLS_DEPENDENCIES += libidn2
else
GNUTLS_CONF_OPTS += --without-idn
endif

ifeq ($(BR2_PACKAGE_P11_KIT),y)
GNUTLS_CONF_OPTS += --with-p11-kit
GNUTLS_DEPENDENCIES += p11-kit
else
GNUTLS_CONF_OPTS += --without-p11-kit
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
GNUTLS_CONF_OPTS += --with-zlib
GNUTLS_DEPENDENCIES += zlib
else
GNUTLS_CONF_OPTS += --without-zlib
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
GNUTLS_CONF_OPTS += --with-zstd
GNUTLS_DEPENDENCIES += zstd
else
GNUTLS_CONF_OPTS += --without-zstd
endif

# Provide a default CA cert location
ifeq ($(BR2_PACKAGE_P11_KIT),y)
GNUTLS_CONF_OPTS += --with-default-trust-store-pkcs11=pkcs11:model=p11-kit-trust
else ifeq ($(BR2_PACKAGE_CA_CERTIFICATES),y)
GNUTLS_CONF_OPTS += --with-default-trust-store-file=/etc/ssl/certs/ca-certificates.crt
endif

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
GNUTLS_LIBS += -latomic
endif

GNUTLS_CONF_ENV += LIBS="$(GNUTLS_LIBS)"

# Don't build for target if using webOS package instead
ifneq ($(BR2_PACKAGE_WEBOS_GNUTLS),y)
$(eval $(autotools-package))
endif
$(eval $(host-autotools-package))
