

#import "SurveyItemController.h"

@implementation SurveyItemController

@synthesize question = _question;
@synthesize rightAnswer = _rightAnswer;
@synthesize choicesArray = _choicesArray;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        _question = nil;
        _rightAnswer = nil;
        _choicesArray = nil;
    }
    
    return self;
}

- (void)dealloc
{
    [_question release];
    [_rightAnswer release];
    [_choicesArray release];
    [super dealloc];
}

- (NSArray *)randomChoicesArray
{
    
    
    NSMutableArray *remainArray;
    remainArray = [NSMutableArray arrayWithArray:self.choicesArray];
    
    
    return remainArray;
}

- (BOOL)checkIsRightAnswer:(NSString *)answer
{
    return [self.rightAnswer isEqualToString:answer];
}

@end
