################################################################################
#
# nettle
#
################################################################################

NETTLE_VERSION = 2.7.1
NETTLE_SITE = https://ftp.gnu.org/gnu/nettle
NETTLE_DEPENDENCIES = $(if $(BR2_PACKAGE_WEBOS_GMP),webos-gmp,gmp)
NETTLE_INSTALL_STAGING = YES
NETTLE_LICENSE = LGPLv2.1+
NETTLE_LICENSE_FILES = COPYING.LIB
# don't include openssl support for (unused) examples as it has problems
# with static linking
NETTLE_CONF_OPTS = --disable-openssl

HOST_NETTLE_DEPENDENCIES = host-m4 host-gmp

# ARM assembly requires v6+ ISA
ifeq ($(BR2_ARM_CPU_ARMV4)$(BR2_ARM_CPU_ARMV5)$(BR2_ARM_CPU_ARMV7M),y)
NETTLE_CONF_OPTS += --disable-assembler
endif

# ARM NEON, requires binutils 2.21+
ifeq ($(BR2_ARM_CPU_HAS_NEON)$(BR2_TOOLCHAIN_BUILDROOT)$(BR2_BINUTILS_VERSION_2_20_1),yy)
NETTLE_CONF_OPTS += --enable-arm-neon
else
NETTLE_CONF_OPTS += --disable-arm-neon
endif

define NETTLE_DITCH_DEBUGGING_CFLAGS
	$(SED) '/CFLAGS/ s/ -ggdb3//' $(@D)/configure
endef

NETTLE_POST_EXTRACT_HOOKS += NETTLE_DITCH_DEBUGGING_CFLAGS

$(eval $(autotools-package))
$(eval $(host-autotools-package))
