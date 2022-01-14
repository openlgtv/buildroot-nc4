################################################################################
#
# lemon
#
################################################################################

LEMON_VERSION = 3.7.9
LEMON_TAR_VERSION = 3070900
LEMON_SOURCE = sqlite-src-$(LEMON_TAR_VERSION).zip
LEMON_SITE = https://sqlite.org/
LEMON_LICENSE = Public domain
LEMON_LICENSE_FILES = tea/license.terms
LEMON_CPE_ID_VENDOR = sqlite

define HOST_LEMON_EXTRACT_CMDS
	$(UNZIP) -d $(@D) $(HOST_LEMON_DL_DIR)/$(LEMON_SOURCE)
	find $(@D)/sqlite-src-$(LEMON_TAR_VERSION) -maxdepth 1 \
		-exec mv {} $(@D)/ \;
	rmdir $(@D)/sqlite-src-$(LEMON_TAR_VERSION)
endef

define HOST_LEMON_BUILD_CMDS
	$(MAKE) lemon -C $(@D)
endef

define HOST_LEMON_INSTALL_CMDS
	$(INSTALL) -m 0775 $(@D)/lemon $(HOST_DIR)/usr/bin/
	$(INSTALL) -d $(HOST_DIR)/usr/share/lemon
	# FIXME: this is a ugly hack! lemon should fix this!
	$(INSTALL) -m 0664 $(@D)/tool/lempar.c $(HOST_DIR)/usr/bin/
endef

$(eval $(host-autotools-package))
