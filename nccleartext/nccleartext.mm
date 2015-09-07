#import <Preferences/Preferences.h>

@interface nccleartextListController: PSListController {
}
@end

@implementation nccleartextListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"nccleartext" target:self] retain];
	}
	return _specifiers;
}
-(void)save
{
    [self.view endEditing:YES];
}
@end

@protocol PreferencesTableCustomView
-(id)initWithSpecifier:(id)arg1;
@optional
-(CGFloat)preferredHeightForWidth:(CGFloat)arg1;
@end

@interface PSTableCell : UITableView
-(id)initWithStyle:(int)style reuseIdentifier:(id)arg2;
@end

@interface NCClearTextCustomCell : PSTableCell <PreferencesTableCustomView> {

	UILabel *label;
	UILabel *underLabel;
}
@end

@implementation NCClearTextCustomCell
-(id)initWithSpecifier:(id)specifier {

	self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
	if (self) {

		CGRect frame = CGRectMake(0, 2, [[UIScreen mainScreen] bounds].size.width, 60);
		CGRect underFrame = CGRectMake(0, 35, [[UIScreen mainScreen] bounds].size.width, 60);
 
		label = [[UILabel alloc] initWithFrame:frame];
		[label setNumberOfLines:1];
		label.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:42];
		[label setText:@"NCClearText"];
		[label setBackgroundColor:[UIColor clearColor]];
		label.textColor = [UIColor blackColor];
		label.textAlignment = NSTextAlignmentCenter;

		underLabel = [[UILabel alloc] initWithFrame:underFrame];
		[underLabel setNumberOfLines:1];
		underLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
		[underLabel setText:@"By DGh0st"];
		[underLabel setBackgroundColor:[UIColor clearColor]];
		underLabel.textColor = [UIColor grayColor];
		underLabel.textAlignment = NSTextAlignmentCenter;

		[self addSubview:label];
		[self addSubview:underLabel];
	}
	return self;
}
 
-(CGFloat)preferredHeightForWidth:(CGFloat)arg1 {

	CGFloat prefHeight = 80.0;
	return prefHeight;
}
@end

// vim:ft=objc
