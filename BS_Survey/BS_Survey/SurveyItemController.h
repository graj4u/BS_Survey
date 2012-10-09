

#import <Foundation/Foundation.h>

@interface SurveyItemController : NSObject
{
    NSString *_question;
    NSString *_rightAnswer;
    NSArray *_choicesArray;
}

@property (retain, nonatomic) NSString *question;
@property (retain, nonatomic) NSString *rightAnswer;
@property (retain, nonatomic) NSArray *choicesArray;
@property (readonly, nonatomic) NSArray *randomChoicesArray;

- (BOOL)checkIsRightAnswer:(NSString *)answer;

@end
