export THEOS_PACKAGE_SCHEME = rootless
export ARCHS = arm64 arm64e
export TARGET = iphone:clang:14.5:14.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WeiJieTuVipUnlock

WeiJieTuVipUnlock_FILES = Tweak.x
WeiJieTuVipUnlock_CFLAGS = -fobjc-arc
WeiJieTuVipUnlock_FRAMEWORKS = Foundation UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
