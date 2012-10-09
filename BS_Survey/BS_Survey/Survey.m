
#import "Survey.h"
#import "SurveyItemController.h"

@implementation Survey

@synthesize quizItemsArray = _quizItemsArray;
@synthesize usedQuizItems = _usedQuizItems;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        _quizItemsArray = nil;
        _usedQuizItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)dealloc
{
    [_quizItemsArray release];
    [_usedQuizItems release];
    [super dealloc];
}

- (SurveyItemController *)nextQuiz
{
    NSMutableArray *tempArray;
    tempArray = [NSMutableArray arrayWithArray:self.quizItemsArray];
    [tempArray removeObjectsInArray:_usedQuizItems];
    
    if ([tempArray count] == 0)
	{
        return nil;
    }
    
    NSInteger ind = 0;
	
    SurveyItemController *item = [tempArray objectAtIndex:ind];
    
    [_usedQuizItems addObject:item];
    
    return item;
}

- (void)clear
{
    [_usedQuizItems removeAllObjects];
}

- (BOOL)readFromFile:(NSString *)filePath
{
    NSString *fileData;
    fileData = [NSString stringWithContentsOfFile:filePath
                                         encoding:NSUTF8StringEncoding
                                            error:NULL];
    if (!fileData) {
        return NO;
    }
    
    NSArray *lineArray = [fileData componentsSeparatedByString:@"\n"];
    
    if (!lineArray || [lineArray count] ==0) 
	{
        return NO;
    }
    
    NSMutableArray *newItemsArray = [NSMutableArray array];
    SurveyItemController *curItem = nil;
    NSMutableArray *curChoices = nil;
    
    for (NSString *line in lineArray)
	{
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
        if ([line length] == 0) 
		{
            if (curItem && curChoices) 
			{
                [curItem setChoicesArray:curChoices];
                [newItemsArray addObject:curItem];
            }
            [curItem release];
            [curChoices release];
            curItem = nil;
            curChoices = nil;
        }
        else
        {
            if (!curItem) 
			{
                curItem = [[SurveyItemController alloc] init];
                curChoices = [[NSMutableArray alloc] init];
            }
            
            if (!curItem.question) 
			{
                [curItem setQuestion:line];
            }
            else
            {
                if (!curItem.rightAnswer) 
				{
                    [curItem setRightAnswer:line];
                }
                
                [curChoices addObject:line];
            }
        }
        [pool release];
    }
    
    if (curItem && curChoices) 
	{
        [curItem setChoicesArray:curChoices];
        [newItemsArray addObject:curItem];
    }
    
    [self setQuizItemsArray:newItemsArray];
    
    [curItem release];
    [curChoices release];
    
    return YES;
    
}

@end
