################################################################################
#
# php-openswoole
#
################################################################################

PHP_OPENSWOOLE_VERSION = 525c247b0d95b69adeec2f4d98ad8809ae45c6fb
PHP_OPENSWOOLE_SITE = $(call github,openswoole,ext-openswoole,$(PHP_OPENSWOOLE_VERSION))
PHP_OPENSWOOLE_INSTALL_STAGING = YES
PHP_OPENSWOOLE_LICENSE = Apache License 2.0
PHP_OPENSWOOLE_LICENSE_FILES = LICENSE
# phpize does the autoconf magic
PHP_OPENSWOOLE_DEPENDENCIES = php host-autoconf
PHP_OPENSWOOLE_CONF_OPTS = \
	--enable-openswoole \
	--with-php-config=$(STAGING_DIR)/usr/bin/php-config

define PHP_OPENSWOOLE_PHPIZE
	(cd $(@D); \
		PHP_AUTOCONF=$(HOST_DIR)/bin/autoconf \
		PHP_AUTOHEADER=$(HOST_DIR)/bin/autoheader \
		$(STAGING_DIR)/usr/bin/phpize)
endef

PHP_OPENSWOOLE_PRE_CONFIGURE_HOOKS += PHP_OPENSWOOLE_PHPIZE

$(eval $(autotools-package))
