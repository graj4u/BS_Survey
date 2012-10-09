//
//  FirstViewController.h
//  BullShiftQuiz
//
//  Created by GAURAV RAJ on 06/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Survey;

@interface FirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
	Survey *_quiz;
	UITableView *mainTableView;

}

- (void)startQuiz:(id)sender;
- (void) deselect;

@property (nonatomic, retain) IBOutlet UITableView *mainTableView;

@end
