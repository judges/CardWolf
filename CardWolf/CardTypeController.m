//
//  CardTypeController.m
//  CardWolf
//
//  Created by Neil Sheppard on 05/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CardTypeController.h"
#import "MessageController.h"
#import "CardDetailController.h"

@implementation CardTypeController

@synthesize cardTypeArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Card Type";
    }
    return self;
}

- (void)dealloc
{
    [cardTypeArray release];
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
    //NSArray *arrayToLoadPicker = [[NSArray alloc] initWithObjects:@"Birthday", @"Christmas", @"Mother's Day", @"Father's Day", @"Sympathy", @"Congratulations", @"Good Luck", nil];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CardTypes" ofType:@"plist"];
    
    NSMutableArray *arrayToLoadPicker = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    self.cardTypeArray = arrayToLoadPicker;
    
    [arrayToLoadPicker release];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [cardTypeArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CardTypeIdentifier"];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CardTypeIdentifier"] autorelease];
    }
    
    cell.textLabel.text = [cardTypeArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSString *message = [NSString stringWithFormat:@"You selected: %@", [cardTypeArray objectAtIndex:indexPath.row]];
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //[alert show];
        //[alert release];
    
    Card *userCard = [Card alloc];
    
    userCard.cardType = [NSString stringWithFormat:@"%@", [cardTypeArray objectAtIndex:indexPath.row]];
//    MessageController *messageController = [[MessageController alloc] initWithNibName:@"MessageController" bundle:nil card:userCard]; 
//    
//    [self.navigationController pushViewController:messageController animated:YES];
//    
//    [messageController release];
//    [userCard release];
    
    CardDetailController *detailController = [[CardDetailController alloc] initWithNibName:@"CardDetailController" bundle:nil card:userCard];
    
    [self.navigationController pushViewController:detailController animated:YES];
    
    [detailController release];
}

@end
