//
//  FirstViewController.m
//  BullShiftQuiz
//
//  Created by GAURAV RAJ on 06/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "SurveyViewController.h"
#import "Survey.h"
#import "PopupView.h"
#import "AboutSurveyController.h"

@implementation FirstViewController 
@synthesize mainTableView;

- (void)startQuiz:(id)sender
{
    if (!_quiz) 
	{
        _quiz = [[Survey alloc] init];
        
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *path;
        
        path = [bundle pathForResource:@"testpaper" ofType:@"txt"];
        [_quiz readFromFile:path];
    }
    
    [_quiz clear];
    
    SurveyViewController *viewController;
    viewController = [[SurveyViewController alloc] init];
    
    [viewController setSurvey:_quiz];
    
    [self presentModalViewController:viewController animated:YES];
    //[viewController release];
}



-(void)loadAboutQuiz
{
    
	PopupView *popupView = [[PopupView alloc] init];
	
	UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 300, 440)];
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
	[popupView release];
}


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	NSInteger rows = [indexPath row];
    // Configure the cell...
	if (rows==0) 
	{
		cell.textLabel.text = @"Start Survey";
		cell.imageView.image =[UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"todo" ofType:@"png"]];
	}
	if (rows==1) 
	{
		cell.textLabel.text = @"About Survey";
		cell.imageView.image =[UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"cup" ofType:@"png"]];
	}
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
	 AboutSurveyController *detailViewController = [[AboutSurveyController alloc] initWithNibName:@"AboutSurveyController" bundle:nil];
	 // ...
	 // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
	if (indexPath.row==0) 
	{
		[self startQuiz:nil];
	}
	if (indexPath.row==1) 
	{
		//[self loadAboutQuiz];
		AboutSurveyController *detailViewController = [[AboutSurveyController alloc] initWithNibName:@"AboutSurveyController" bundle:nil];
		
		[self.navigationController pushViewController:detailViewController animated:YES];
		[detailViewController release];
		
	}
	
	[self performSelector:@selector(deselect) withObject:nil afterDelay:0.15f];
	
}


- (void) deselect
{
	[self.mainTableView deselectRowAtIndexPath:[self.mainTableView indexPathForSelectedRow] animated:YES];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[mainTableView release];
	[_quiz release];
    [super dealloc];
}

@end
