//
//  MainMenuController.m
//  CardWolf
//
//  Created by Neil Sheppard on 05/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenuController.h"
#import "CardTypeController.h"

@implementation MainMenuController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"CardWolf Menu";
        UIBarButtonItem *backButton =
        [[UIBarButtonItem alloc]
         initWithTitle:@"Menu"
         style:UIBarButtonItemStyleBordered
         target:nil
         action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        [backButton release];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
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

- (IBAction)gotoCardScreen:(id)sender 
{
    CardTypeController *cardTypeController = [[CardTypeController alloc] initWithNibName:@"CardTypeController" bundle:nil]; 
    
    [self.navigationController pushViewController:cardTypeController animated:YES];
    
    [cardTypeController release];
}

@end
