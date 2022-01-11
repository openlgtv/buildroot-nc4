################################################################################
#
# cmake-modules-webos
#
################################################################################

CMAKE_MODULES_WEBOS_VERSION = master
CMAKE_MODULES_WEBOS_SITE = $(call github,webosose,cmake-modules-webos,$(CMAKE_MODULES_WEBOS_VERSION))
CMAKE_MODULES_WEBOS_SUPPORTS_IN_SOURCE_BUILD = NO
CMAKE_MODULES_WEBOS_INSTALL_TARGET = NO
CMAKE_MODULES_WEBOS_INSTALL_STAGING = YES

# this is relative to the CMake install prefix, aka $(STAGING_DIR)
CMAKE_MODULES_WEBOS_CONF_OPTS += \
	-DWEBOS_INSTALL_ROOT=/usr/local/webos

$(eval $(cmake-package))
