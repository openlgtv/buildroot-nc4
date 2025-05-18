################################################################################
#
# libfrida-gum
#
################################################################################

LIBFRIDA_GUM_VERSION = 0c8df6742d2c7a08c32fc3c3b691779b062fb34a
LIBFRIDA_GUM_SITE = https://github.com/frida/frida-gum
LIBFRIDA_GUM_SITE_METHOD = git
LIBFRIDA_GUM_GIT_SUBMODULES = NO

LIBFRIDA_GUM_DEPENDENCIES = host-libglib2 libglib2 \
	libunwind libffi libcapstone \
	libdwarf

ifeq ($(BR2_PACKAGE_LIBFRIDA_GUM_DIET),y)
LIBFRIDA_GUM_CONF_OPTS += -Ddiet=true -Db_ndebug=true
endif

LIBFRIDA_GUM_CFLAGS = $(TARGET_CFLAGS)
LIBFRIDA_GUM_LDFLAGS = $(TARGET_LDFLAGS) $(TARGET_NLS_LIBS)

LIBFRIDA_GUM_CFLAGS += \
	-ffunction-sections \
	-fdata-sections \
	-fPIC

LIBFRIDA_GUM_LDFLAGS += -Wl,--gc-sections

LIBFRIDA_GUM_CONF_OPTS += \
	-Dgumpp=disabled \
	-Dgumjs=disabled \
	-Dtests=disabled

LIBFRIDA_GUM_INSTALL_STAGING = YES
LIBFRIDA_GUM_INSTALL_TARGET = NO

$(eval $(meson-package))
