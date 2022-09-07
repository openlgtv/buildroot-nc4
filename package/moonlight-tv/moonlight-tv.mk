################################################################################
#
# moonlight-tv
#
################################################################################

MOONLIGHT_TV_VERSION = v1.3.1
MOONLIGHT_TV_SITE = https://github.com/mariotaku/moonlight-tv.git
MOONLIGHT_TV_SITE_METHOD = git
MOONLIGHT_TV_GIT_SUBMODULES = YES

define MOONLIGHT_TV_PATCH_SUBMODULE
  git config --global url."https://github.com/GuillaumeSmaha/message_queue".insteadOf "https://github.com/LnxPrgr3/message_queue"
endef
MOONLIGHT_TV_PRE_DOWNLOAD_HOOKS += MOONLIGHT_TV_PATCH_SUBMODULE

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
	pulseaudio \
	libegl \
	umediaserver

MOONLIGHT_TV_CONF_OPTS += \
	-DTARGET_WEBOS=ON

$(eval $(cmake-package))
