//
//  CardDetailController.m
//  CardWolf
//
//  Created by Neil Sheppard on 18/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CardDetailController.h"
#import "MessageController.h"
#import "ToFromController.h"
#import "DeliveryDateController.h"
#import "AddressController.h"
#import "ConfirmationController.h"
#import <QuartzCore/QuartzCore.h>
#import "StringHelper.h"

#define kDefaultMessageLabel        @""
#define kDefaultRowHeight           44.0
#define FONT_SIZE                   17.0f
#define CELL_CONTENT_WIDTH          280.0f
#define CELL_CONTENT_MARGIN         40.0f


@implementation CardDetailController

@synthesize cardDetailArray;
@synthesize expandingMessageController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        card = userCard;
        self.navigationItem.title = card.cardType;

    }
    return self;
}

- (void)dealloc
{
    [cardDetailArray release];
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
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped:)];
    
    self.navigationItem.rightBarButtonItem = doneButton;
    
    [doneButton release];
    
    // Hard coded list of details for card component screen
    cardDetailArray = [[NSMutableArray alloc] init];
    
    // First Section
    
    NSArray *toFromArray = [NSArray arrayWithObjects:@"To", @"From", nil];
    NSDictionary *toFromDict = [NSDictionary dictionaryWithObject:toFromArray forKey:@"Menu"];
    
    NSArray *messageArray = [NSArray arrayWithObject:@"Message"];
    NSDictionary *messageDict = [NSDictionary dictionaryWithObject:messageArray forKey:@"Menu"];
    
    NSArray *dateArray = [NSArray arrayWithObject:@"Date"];
    NSDictionary *dateDict = [NSDictionary dictionaryWithObject:dateArray forKey:@"Menu"];
    
    NSArray *addressArray = [NSArray arrayWithObject:@"Address"];
    NSDictionary *addressDict = [NSDictionary dictionaryWithObject:addressArray forKey:@"Menu"];
    
    [cardDetailArray addObject:toFromDict];
    [cardDetailArray addObject:messageDict];
    [cardDetailArray addObject:dateDict];
    [cardDetailArray addObject:addressDict];
}

- (void)viewWillAppear:(BOOL)animated {
    [tableViewOutlet reloadData];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [cardDetailArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dictionary = [cardDetailArray objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"Menu"];
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictionary = [cardDetailArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"Menu"];

    NSString *cellIdentifier = [array objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    
    if (cell.textLabel.text == @"Message" && card.cardMessage.length > 0) {
        cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.detailTextLabel.numberOfLines = 0;
        //cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:FONT_SIZE];
        cell.detailTextLabel.text = card.cardMessage;
    }
    if (cell.textLabel.text == @"To" && card.cardTo.length > 0) {
        cell.detailTextLabel.text = card.cardTo;
    }
    if (cell.textLabel.text == @"From" && card.cardFrom.length > 0) {
        cell.detailTextLabel.text = card.cardFrom;
    }
    if (cell.textLabel.text == @"Date" && card.cardDate != nil) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateStyle = NSDateFormatterMediumStyle;
        
        cell.detailTextLabel.text = [df stringFromDate:card.cardDate];
    }
    if (cell.textLabel.text == @"Address" && card.cardAddress.length > 0) {
        cell.detailTextLabel.text = card.cardAddress;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Get Selected Row and display the correct ViewController
    NSDictionary *dictionary = [cardDetailArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"Menu"];
    NSString *selectedMenu = [array objectAtIndex:indexPath.row];
    
    if (selectedMenu == @"Message")
    {
        AddNoteViewController *messageController = [[AddNoteViewController alloc] initWithNibName:@"AddNoteViewController" bundle:nil card:card]; 
            
        [self.navigationController pushViewController:messageController animated:YES];
            
        [messageController release];
    }
    if (selectedMenu == @"To" || selectedMenu == @"From") {
        ToFromController *toFromController = [[ToFromController alloc] initWithNibName:@"ToFromController" bundle:nil card:card]; 
        
        [self.navigationController pushViewController:toFromController animated:YES];
        
        [toFromController release];
    }
    if (selectedMenu == @"Date") {
        DeliveryDateController *deliveryDateController = [[DeliveryDateController alloc] initWithNibName:@"DeliveryDateController" bundle:nil card:card];
        
        [self.navigationController pushViewController:deliveryDateController animated:YES];
        
        [deliveryDateController release];
    }
    if (selectedMenu == @"Address") {
        AddressController *addressController = [[AddressController alloc] initWithNibName:@"AddressController" bundle:nil card:card];
        
        [self.navigationController pushViewController:addressController animated:YES];
    }
}

//Manages the height of the cell.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {  
    if (indexPath.section == 1 && indexPath.row == 0 && card.cardMessage.length > 0) {
        NSString *cellText = card.cardMessage;
        UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:FONT_SIZE + 3.0f];
        CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
        CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
        return labelSize.height + 20 < kDefaultRowHeight ? kDefaultRowHeight : labelSize.height + 20;
    }
    
    return kDefaultRowHeight;
} 

- (IBAction)doneButtonTapped:(id)sender {
    //Validate the fields! 
    ConfirmationController *confirmationController = [[ConfirmationController alloc] initWithNibName:@"ConfirmationController" bundle:nil card:card];
    
    [self.navigationController pushViewController:confirmationController animated:YES];
    
    [confirmationController release];
}

@end

