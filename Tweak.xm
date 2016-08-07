@interface _UIContentUnavailableView : UIView
@property(copy) NSString *title;
@end

#define dSettingsPath [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/com.dgh0st.nccleartext.plist"]
#define dIsEnabled [[[NSDictionary dictionaryWithContentsOfFile:dSettingsPath] objectForKey:@"isEnabled"] boolValue]
#define dIsClearEnabled [[[NSDictionary dictionaryWithContentsOfFile:dSettingsPath] objectForKey:@"isClearEnabled"] boolValue]
#define dCustomText [[NSDictionary dictionaryWithContentsOfFile:dSettingsPath] objectForKey:@"customText"]
#define dCustomNoNotificationsText [[NSDictionary dictionaryWithContentsOfFile:dSettingsPath] objectForKey:@"customNoNotificationsText"]

%hook SBNotificationsClearButton
- (id)initWithTitle:(id)arg1 graphicsQuality:(NSInteger)arg2{
	if(dIsEnabled){
		if([dCustomText isEqual:@""]){
			arg1 = @"clear that shit";
		} else {
			arg1 = dCustomText;
		}
	}
	return %orig(arg1, arg2);
}
-(void)setState:(NSInteger)arg1 animated:(BOOL)arg2 {
	if(dIsEnabled){
		if(dIsClearEnabled){
			%orig(1, NO);
		} else {
			%orig(arg1, arg2);
		}
	} else {
		%orig(arg1, arg2);
	}
}
-(NSInteger)clearButtonState {
	return (dIsEnabled && dIsClearEnabled) ? 1 : %orig;
}
%end

%hook SBNotificationsViewController
- (void)viewWillAppear:(_Bool)arg1 {
	_UIContentUnavailableView *view = MSHookIvar<_UIContentUnavailableView *>(self, "_contentUnavailableView");
	if(dIsEnabled){
		if([dCustomNoNotificationsText isEqual:@""]){
			view.title = @"Nothing Here";
		} else {
			view.title = dCustomNoNotificationsText;
		}
	}
	%orig;
}
%end

void loadPreferences() {
	NSMutableDictionary *prefs = [NSMutableDictionary dictionaryWithContentsOfFile:dSettingsPath];

	NSLog(@"NCClearText prefs = %@", prefs);
}

%ctor {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    (CFNotificationCallback)loadPreferences,
                                    CFSTR("com.dgh0st.lockcustomizer/settingschanged"),
                                    NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);
    loadPreferences();
}