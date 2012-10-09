
#import <UIKit/UIKit.h>


@interface PopupView : UIView {
	UIButton *_closeButton;
	
	UIView *_contentView;
	
	UIWindow *_window;
}

- (void)show;
- (void)dismiss:(BOOL)animated;

@end
