################################################################################
#
# hyperion-webos
#
################################################################################

HYPERION_WEBOS_VERSION = main
HYPERION_WEBOS_SITE = https://github.com/webosbrew/hyperion-webos.git
HYPERION_WEBOS_SITE_METHOD = git
HYPERION_WEBOS_GIT_SUBMODULES = YES

HYPERION_WEBOS_DEPENDENCIES = \
	host-pkgconf \
	libpbnjson \
	libglib2 \
	luna-service2 \
	pmloglib \
	libegl

$(eval $(cmake-package))
