//
//  DeliveryDateController.m
//  CardWolf
//
//  Created by Neil Sheppard on 16/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DeliveryDateController.h"
#import "AddressController.h"


@implementation DeliveryDateController

@synthesize card;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.card = userCard;
        self.title = @"Date";
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
    // Do any additional setup after loading the view from its nib.
    UIColor *color = [UIColor groupTableViewBackgroundColor];
	if (CGColorGetPattern(color.CGColor) == NULL) {
		color = [UIColor lightGrayColor];
	}
	self.view.backgroundColor = color;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped:)];
    
    [datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.rightBarButtonItem = doneButton;
    
    if (card.cardDate != nil)
        [datePicker setDate:card.cardDate];
    else
        [datePicker setDate:[NSDate date]];
    
    [doneButton release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [tableViewOutlet reloadData];
    
    [super viewWillAppear:animated];
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

- (IBAction)doneButtonTapped:(id)sender {
    card.cardDate = datePicker.date;
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)dateChanged
{
    [tableViewOutlet reloadData];
}

#pragma mark -
#pragma mark Table View Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *DateCellIdentifier = @"DateCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DateCellIdentifier];
    if (cell == nil) 
    {
        //cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:DateCellIdentifier] autorelease];
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:DateCellIdentifier] autorelease];
        
        [cell.textLabel setFont:[UIFont systemFontOfSize: 17.0]];
        [cell.textLabel setTextColor:[UIColor colorWithRed:0.243 green:0.306 blue:0.435 alpha:1.0]];
        [cell.textLabel setTextAlignment:UITextAlignmentCenter];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    
    [cell.textLabel setText:[formatter stringFromDate:[datePicker date]]];
    [formatter release];
        
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;   
}
@end
