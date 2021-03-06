################################################################################
#
# xcb-proto
#
################################################################################

XCB_PROTO_VERSION = 1.14.1
XCB_PROTO_SOURCE = xcb-proto-$(XCB_PROTO_VERSION).tar.xz
XCB_PROTO_SITE = https://xorg.freedesktop.org/archive/individual/proto
XCB_PROTO_LICENSE = MIT
XCB_PROTO_LICENSE_FILES = COPYING

XCB_PROTO_INSTALL_STAGING = YES

XCB_PROTO_DEPENDENCIES = host-python
HOST_XCB_PROTO_DEPENDENCIES = host-python

$(eval $(autotools-package))
$(eval $(host-autotools-package))
