################################################################################
#
# moonlight-tv
#
################################################################################

MOONLIGHT_TV_VERSION = v1.3.0-1
MOONLIGHT_TV_SITE = https://github.com/mariotaku/moonlight-tv.git
MOONLIGHT_TV_SITE_METHOD = git
MOONLIGHT_TV_GIT_SUBMODULES = YES

MOONLIGHT_TV_DEPENDENCIES = \
	host-pkgconf \
	libglib2 \
	libpbnjson \
	libwebosi18n \
	pmloglib \
	sdl2 \
	sdl2_image \
	libcurl \
	expat \
	freetype fontconfig \
	json-c pulseaudio \
	libegl \
	umediaserver
	
MOONLIGHT_TV_CONF_OPTS += \
	-DTARGET_WEBOS=ON

$(eval $(cmake-package))
