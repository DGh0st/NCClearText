include theos/makefiles/common.mk

BUNDLE_NAME = nccleartext
nccleartext_FILES = nccleartext.mm
nccleartext_INSTALL_PATH = /Library/PreferenceBundles
nccleartext_FRAMEWORKS = UIKit
nccleartext_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/nccleartext.plist$(ECHO_END)
