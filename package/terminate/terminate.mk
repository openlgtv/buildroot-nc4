################################################################################
#
# terminate
#
################################################################################

TERMINATE_VERSION = master
TERMINATE_SITE = https://github.com/Zoomulator/Terminate.git
TERMINATE_SITE_METHOD = git
TERMINATE_DEPENDENCIES = sdl2 sdl2_ttf

$(eval $(cmake-package))
