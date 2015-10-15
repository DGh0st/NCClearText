export ARCHS = armv7 arm64
export TARGET = iphone:clang:8.1:7.0

PACKAGE_VERSION = 1.1

include theos/makefiles/common.mk

TWEAK_NAME = NCClearText
NCClearText_FILES = Tweak.xm
NCClearText_LDFLAGS += -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

SUBPROJECTS += nccleartext
include $(THEOS_MAKE_PATH)/aggregate.mk