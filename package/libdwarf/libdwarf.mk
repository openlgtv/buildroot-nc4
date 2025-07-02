################################################################################
#
# libdwarf
#
################################################################################

LIBDWARF_VERSION = v0.12.0
LIBDWARF_SITE = $(call github,davea42,libdwarf-code,$(LIBDWARF_VERSION))
LIBDWARF_INSTALL_STAGING = YES
LIBDWARF_INSTALL_TARGET = NO
LIBDWARF_CONF_OPTS += -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -fPIC"

$(eval $(cmake-package))
