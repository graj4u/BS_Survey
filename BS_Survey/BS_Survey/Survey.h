
#import <Foundation/Foundation.h>

@class SurveyItemController;

@interface Survey : NSObject
{
    NSArray *_quizItemsArray;
    NSMutableArray *_usedQuizItems;
}

@property (retain, nonatomic) NSArray *quizItemsArray;
@property (readonly, nonatomic) NSMutableArray *usedQuizItems;

- (SurveyItemController *)nextQuiz;
- (void)clear;
- (BOOL)readFromFile:(NSString *)filePath;

@end
