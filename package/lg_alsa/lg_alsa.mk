################################################################################
#
# lg_alsa
#
################################################################################

LG_ALSA_SOURCE = alsa.tar.gz
LG_ALSA_SITE = $(TOPDIR)/package/lg_alsa
LG_ALSA_SITE_METHOD = file

LG_ALSA_DEPENDENCIES = linux
LG_ALSA_LICENCE = Proprietary/LGPL

define LG_ALSA_EXTRACT_CMDS
	tar -C $(@D) -xf $(DL_DIR)/$(LG_ALSA_SOURCE)
endef

define LG_ALSA_BUILD_CMDS
endef

define LG_ALSA_INSTALL_TARGET_CMDS
	cp -R $(@D)/* $(STAGING_DIR)/usr/include/
endef

$(eval $(generic-package))