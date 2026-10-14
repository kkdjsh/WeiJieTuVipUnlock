THEOS_PACKAGE_SCHEME = rootless
export THEOS=/opt/theos

TARGET := iphone:clang::14.0
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = com.wdd.wjt

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WeiJieTuVipUnlock

WeiJieTuVipUnlock_FILES = Tweak.x
WeiJieTuVipUnlock_CFLAGS = -fobjc-arc
WeiJieTuVipUnlock_FRAMEWORKS = UIKit Foundation

include $(THEOS_MAKE_PATH)/tweak.mk