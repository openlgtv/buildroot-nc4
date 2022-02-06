################################################################################
#
# libfrida-gum
#
################################################################################

LIBFRIDA_GUM_VERSION = main
LIBFRIDA_GUM_SITE = $(call github,frida,frida-gum,$(LIBFRIDA_GUM_VERSION))

#LIBFRIDA_GUM_DEPENDENCIES =

ifeq ($(BR2_PACKAGE_LIBFRIDA_GUM_DIET),y)
LIBFRIDA_GUM_CONF_OPTS += -Ddiet=true -Db_ndebug=true
endif

# force frida dependency variants
LIBFRIDA_GUM_CONF_OPTS += --wrap-mode=forcefallback

LIBFRIDA_GUM_CFLAGS = $(TARGET_CFLAGS)
LIBFRIDA_GUM_LDFLAGS = $(TARGET_LDFLAGS) $(TARGET_NLS_LIBS)

LIBFRIDA_GUM_CFLAGS += \
	-ffunction-sections \
	-fdata-sections
LIBFRIDA_GUM_LDFLAGS += -Wl,--gc-sections

LIBFRIDA_GUM_CONF_OPTS += \
	-Dgumpp=disabled \
	-Dgumjs=disabled \
	-Dtests=disabled \
	-Db_staticpic=true

LIBFRIDA_GUM_INSTALL_STAGING = YES
LIBFRIDA_GUM_INSTALL_TARGET = NO

# HACK: force static build
ifeq ($(BR2_STATIC_LIBS),)
BR2_STATIC_LIBS=y
$(eval $(meson-package))
BR2_STATIC_LIBS=
else
$(eval $(meson-package))
endif