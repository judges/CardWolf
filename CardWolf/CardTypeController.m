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
#import "CardFlowViewController.h"

@implementation CardTypeController

@synthesize cardTypeArray;
@synthesize data;
@synthesize CurrentLevel;
@synthesize CurrentTitle;
@synthesize cardType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        card = userCard;
        self.title = @"Card Type";
    }
    return self;
}

- (void)dealloc
{
    [cardTypeArray release];
    //[data release];
    [self.cardType release];
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
    NSString *Path = [[NSBundle mainBundle] bundlePath];
	NSString *DataPath = [Path stringByAppendingPathComponent:@"CardType_v2.plist"];
	
	NSDictionary *tempDict = [[NSDictionary alloc] initWithContentsOfFile:DataPath];
	self.data = tempDict;
	[tempDict release];
    
    if(CurrentLevel == 0) {
		//Initialize our table data source
        NSMutableArray *arrayToLoadPicker = [[NSArray alloc] init];
		arrayToLoadPicker = [data objectForKey:@"Rows"];
		
        self.cardTypeArray = arrayToLoadPicker;
        
        [arrayToLoadPicker release];
	}
	else 
		self.navigationItem.title = CurrentTitle;

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
    // Set up the cell...
	NSDictionary *dictionary = [cardTypeArray objectAtIndex:indexPath.row];
	cell.textLabel.text = [dictionary objectForKey:@"Title"];
    
    //cell.textLabel.text = [cardTypeArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{    
	//Get the dictionary of the selected data source.
	NSDictionary *dictionary = [cardTypeArray objectAtIndex:indexPath.row];
	
	//Get the children of the present item.
	NSMutableArray *Children = [dictionary objectForKey:@"Children"];
	
	if([Children count] == 0) {  
        self.cardType = [[NSMutableString alloc] initWithString:card.cardSubCat];
        
        [self.cardType appendString:[dictionary objectForKey:@"Title"]];

        card.cardType = self.cardType;
        
        CardFlowViewController *flowController = [[CardFlowViewController alloc] initWithNibName:@"CardFlowViewController" bundle:nil card:card];
            
        [self.navigationController pushViewController:flowController animated:YES];
            
        [flowController release];
	}
	else {
        self.cardType = [[NSMutableString alloc] initWithString:[dictionary objectForKey:@"Title"]];
        [self.cardType appendString:@" - "];
        card.cardSubCat = self.cardType;
        
        CardTypeController *cardTypeController = [[CardTypeController alloc] initWithNibName:@"CardTypeController" bundle:nil card:card];         		
		//Increment the Current View
		cardTypeController.CurrentLevel += 1;
		
		//Set the title;
		cardTypeController.CurrentTitle = [dictionary objectForKey:@"Title"];
		
		//Push the new table view on the stack
		[self.navigationController pushViewController:cardTypeController animated:YES];
		
		cardTypeController.cardTypeArray = Children;
		
		[cardTypeController release];
	}
}

@end
