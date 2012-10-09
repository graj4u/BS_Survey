

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "CustomAlertView.h"

@class Survey;

@interface SurveyViewController : UIViewController<UIAlertViewDelegate,CustomAlertViewDelegate>
{
    Survey *_quiz;
	int count;
    UITextView *_questionTextView;
    UIButton *_answerButton1;
    UIButton *_answerButton2;
    UIButton *_answerButton3;
    UIButton *_answerButton4;
	UIButton *_answerButton5;
    SystemSoundID _rightSound;
    SystemSoundID _notRightSound;
	NSMutableArray *answeredArr;
	NSMutableArray *oneArr;
	NSMutableArray *twoArr;
	NSMutableArray *threeArr;
	NSMutableArray *fourArr;
	NSMutableArray *fiveArr;
	NSString *scoreTitle ;
	
}

@property (retain, nonatomic) Survey *survey;
@property (retain, nonatomic) IBOutlet UITextView *questionTextView;
@property (retain, nonatomic) IBOutlet UIButton *answerButton1;
@property (retain, nonatomic) IBOutlet UIButton *answerButton2;
@property (retain, nonatomic) IBOutlet UIButton *answerButton3;
@property (retain, nonatomic) IBOutlet UIButton *answerButton4;
@property (retain, nonatomic) IBOutlet UIButton *answerButton5;

- (IBAction)answer:(id)sender;
- (void)showNextQuiz;

@end
