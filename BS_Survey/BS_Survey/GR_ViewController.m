//
//  GR_ViewController.m
//  BS_Survey
//
//  Created by NxtSys on 09/10/12.
//  Copyright (c) 2012 GRaj. All rights reserved.
//

#import "GR_ViewController.h"
#import "FirstViewController.h"

@interface GR_ViewController ()

@end

@implementation GR_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    FirstViewController *fvc = [[FirstViewController alloc ] initWithNibName:@"FirstView" bundle:nil];
    [self.navigationController pushViewController:fvc animated:YES];
    [fvc release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
