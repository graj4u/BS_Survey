

#import "SurveyViewController.h"
#import "Survey.h"
#import "SurveyItemController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "PopupView.h"


static const NSInteger kSurveyCount = 17; //Number of question displayed
static const NSTimeInterval kNextQuizInterval = 2.0;

@implementation SurveyViewController

@synthesize survey = _quiz;
@synthesize questionTextView = _questionTextView;
@synthesize answerButton1 = _answerButton1;
@synthesize answerButton2 = _answerButton2;
@synthesize answerButton3 = _answerButton3;
@synthesize answerButton4 = _answerButton4;
@synthesize answerButton5 = _answerButton5;


- (id)init
{
    self = [super initWithNibName:@"SurveyViewController" bundle:nil];
    if (self) 
	{
        _quiz = nil;
		
		count=1;
		
		answeredArr = [[NSMutableArray alloc]init];
		oneArr = [[NSMutableArray alloc]init];
		twoArr = [[NSMutableArray alloc]init];
		threeArr = [[NSMutableArray alloc]init];
		fourArr = [[NSMutableArray alloc]init];
		fiveArr = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)dealloc
{
    AudioServicesDisposeSystemSoundID(_rightSound);
    AudioServicesDisposeSystemSoundID(_notRightSound);
    [_quiz release];
    [_questionTextView release];
    [_answerButton1 release];
    [_answerButton2 release];
    [_answerButton3 release];
    [_answerButton4 release];
	[_answerButton5 release];
    [super dealloc];

}

-(void)loadAboutQuiz
{
	/*PopupView *popupView = [[PopupView alloc] init];
	
	UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 280, 50)];
	imgView.image=[UIImage imageNamed:@"bullshift.png"];
	[popupView addSubview:imgView];
	
	
	UIWebView *webView1 = [[UIWebView alloc] initWithFrame:CGRectMake(10, 50, 280, 50)];
	[popupView addSubview:webView1];
	[webView1 loadHTMLString:scoreTitle baseURL:nil];
	
	
	UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, 300, 440)];
	[popupView addSubview:webView];
	[webView scalesPageToFit];
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Help" ofType:@"html"];  
    NSData *htmlData = [NSData dataWithContentsOfFile:filePath];  
    if (htmlData) 
	{  
		
        [webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@"http://google.com"]];  
    } 
	
	[webView release];
	[popupView show];
	[popupView release];*/
	
	CustomAlertView *alert = [[CustomAlertView alloc] init];
    alert.delegate = self;
    [alert show:scoreTitle];
    [alert release];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
        // Custom initialization
		
    }
    return self;
}



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}




#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showNextQuiz];
}




- (void)showNextQuiz
{
	
    SurveyItemController *item = [self.survey nextQuiz];
	
	//NSLog(@"Question is:-->%@",item.question);
	NSString *question = item.question;
	NSString *qStr = [NSString stringWithFormat:@"(%d/17) %@",count,question];
	self.questionTextView.text = qStr;
	
    NSArray *choices = item.randomChoicesArray;
    
    NSArray *buttons = [NSArray arrayWithObjects:self.answerButton1,
                        self.answerButton2,
                        self.answerButton3,
                        self.answerButton4,self.answerButton5, nil];
    NSUInteger i;
    
    for (i = 0; i < [choices count] && i < [buttons count]; i++) 
	{
        NSString *str = [choices objectAtIndex:i];
		NSString *sNo = [NSString stringWithFormat:@"%d",i+1];
		NSString *space = @"   ";
		NSString *btnTitle = [space stringByAppendingString:sNo];
		NSString *btnTitle1 = [btnTitle stringByAppendingString:@". "];
		NSString *btnTitle2 = [btnTitle1 stringByAppendingString:str];
		
        UIButton *button = [buttons objectAtIndex:i];
        [button setTitle:btnTitle2 forState:UIControlStateNormal];
		button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    }
    [self.view setNeedsLayout];
}




- (IBAction)answer:(id)sender
{
	
    self.answerButton1.enabled = NO;
    self.answerButton2.enabled = NO;
    self.answerButton3.enabled = NO;
    self.answerButton4.enabled = NO;
	self.answerButton5.enabled = NO;
    
    NSString *str = [[sender titleLabel] text];
    SurveyItemController *item = [self.survey.usedQuizItems lastObject];
    
    if ([item checkIsRightAnswer:str]) 
	{
        [sender setTitle:[NSString stringWithFormat:@"%@				✘", str]
                forState:UIControlStateNormal];
        //AudioServicesPlaySystemSound(_notRightSound);
    }
    else
    {
        [sender setTitle:[NSString stringWithFormat:@"%@				✔", str]
                forState:UIControlStateNormal];
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
		
		NSString *currSelectedBtnTitle = [sender currentTitle];
		NSArray *ansArr = [currSelectedBtnTitle componentsSeparatedByString:@"."];
		
		NSInteger scorePoint = [[ansArr objectAtIndex:0] intValue];
		[answeredArr addObject:[NSNumber numberWithInt:scorePoint]];
		
		 NSLog(@"answered arr:-->%@",answeredArr);
		if (scorePoint==1)
		{
			[oneArr addObject:[NSNumber numberWithInt:scorePoint]];
		}
		else if (scorePoint==2)
		{
			[twoArr addObject:[NSNumber numberWithInt:scorePoint]];
		}
		else if (scorePoint==3)
		{
			[threeArr addObject:[NSNumber numberWithInt:scorePoint]];
		}
		else if (scorePoint==4)
		{
			[fourArr addObject:[NSNumber numberWithInt:scorePoint]];
		}
		else if (scorePoint==5)
		{
			[fiveArr addObject:[NSNumber numberWithInt:scorePoint]];
		}

    }
    count++;
    [self.view setNeedsLayout];
    
    [self performSelector:@selector(nextQuiz:)
               withObject:nil
               afterDelay:kNextQuizInterval];
}



-(void)scoring
{
	NSInteger total=0;
	for (int i=0; i<answeredArr.count; i++) 
	{
		NSLog(@"elements are:-->%@",[answeredArr objectAtIndex:i]);
		total = total+[[answeredArr objectAtIndex:i] intValue];
	}
	
	NSLog(@"Total score is:-->%d",total);
	scoreTitle = [NSString stringWithFormat:@"Your Score is: %d",total];
	
	
     NSLog(@"1......%d",oneArr.count);
	 NSLog(@"2......%d",twoArr.count);
	 NSLog(@"3......%d",threeArr.count);
	 NSLog(@"4......%d",fourArr.count);
	 NSLog(@"5......%d",fiveArr.count);

	
	[self loadAboutQuiz];
	
}



- (void)nextQuiz:(id)sender
{
    if ([self.survey.usedQuizItems count] == kSurveyCount) 
	{
		[self scoring];
        [self dismissModalViewControllerAnimated:YES];
    }
    else
    {
        self.answerButton1.enabled = YES;
        self.answerButton2.enabled = YES;
        self.answerButton3.enabled = YES;
        self.answerButton4.enabled = YES;
        self.answerButton5.enabled = YES;  
        [self showNextQuiz];
    }
}


#pragma mark -
#pragma mark Custom alert view delegate method

- (void) CustomAlertView:(CustomAlertView *)alert wasDismissedWithValue:(NSString *)value
{
    //feedbackLabel.text = [NSString stringWithFormat:@"'%@' was entered", value];
}
- (void) customAlertViewWasCancelled:(CustomAlertView *)alert
{
    //feedbackLabel.text = NSLocalizedString(@"User cancelled alert", @"User cancelled alert");
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
