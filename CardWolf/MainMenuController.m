//
//  MainMenuController.m
//  CardWolf
//
//  Created by Neil Sheppard on 05/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenuController.h"
#import "CardTypeController.h"
#import "CoolStuffController.h"

@implementation MainMenuController

@synthesize menuDetailArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"CardWolf";
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
    UIColor *color = [UIColor groupTableViewBackgroundColor];
	if (CGColorGetPattern(color.CGColor) == NULL) {
		color = [UIColor lightGrayColor];
	}
	self.view.backgroundColor = color;   

    
    // Hard coded list of details for card component screen
    menuDetailArray = [[NSMutableArray alloc] init];
    
    // First Section
    NSArray *cardArray = [NSArray arrayWithObject:@"Buy Card"];
    NSDictionary *cardDict = [NSDictionary dictionaryWithObject:cardArray forKey:@"Menu"];
    
    NSArray *calendarArray = [NSArray arrayWithObject:@"Calendar"];
    NSDictionary *calendarDict = [NSDictionary dictionaryWithObject:calendarArray forKey:@"Menu"];
    
    NSArray *costArray = [NSArray arrayWithObject:@"Costs & Conditions"];
    NSDictionary *costDict = [NSDictionary dictionaryWithObject:costArray forKey:@"Menu"];
    
    NSArray *contactArray = [NSArray arrayWithObject:@"Contact Us"];
    NSDictionary *contactDict = [NSDictionary dictionaryWithObject:contactArray forKey:@"Menu"];
    
    NSArray *coolArray = [NSArray arrayWithObject:@"Cool Stuff"];
    NSDictionary *coolDict = [NSDictionary dictionaryWithObject:coolArray forKey:@"Menu"];
    
    [menuDetailArray addObject:cardDict];
    [menuDetailArray addObject:calendarDict];
    [menuDetailArray addObject:costDict];
    [menuDetailArray addObject:contactDict];
    [menuDetailArray addObject:coolDict];
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
    return [menuDetailArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dictionary = [menuDetailArray objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"Menu"];
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuDetailIdentifier"];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MenuDetailIdentifier"] autorelease];
    }
    
    NSDictionary *dictionary = [menuDetailArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"Menu"];
    
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (cell.textLabel.text == @"Buy Card")
        cell.imageView.image = [UIImage imageNamed:@"card32.png"];
    else if (cell.textLabel.text == @"Calendar")
        cell.imageView.image = [UIImage imageNamed:@"calendar32.png"];
    else if (cell.textLabel.text == @"Contact Us")
        cell.imageView.image = [UIImage imageNamed:@"mailbox32.png"];
    else if (cell.textLabel.text == @"Costs & Conditions")
        cell.imageView.image = [UIImage imageNamed:@"creditcards32.png"];
    else
        cell.imageView.image = [UIImage imageNamed:@"sunglasses32.png"];



    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Get Selected Row and display the correct ViewController
    NSDictionary *dictionary = [menuDetailArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"Menu"];
    NSString *selectedMenu = [array objectAtIndex:indexPath.row];
    
    if (selectedMenu == @"Buy Card")
    {
        card = [Card alloc];
        CardTypeController *cardTypeController = [[CardTypeController alloc] initWithNibName:@"CardTypeController" bundle:nil card:card]; 
        
        [self.navigationController pushViewController:cardTypeController animated:YES];
        
        [cardTypeController release];
    }
    if (selectedMenu == @"Contact Us")
    {                                                  
    }
    if (selectedMenu == @"Cool Stuff")
    {
        CoolStuffController *coolStuffController = [[CoolStuffController alloc] initWithNibName:@"CoolStuffController" bundle:nil]; 
        
        [self.navigationController pushViewController:coolStuffController animated:YES];
        
        [coolStuffController release];
    }
}


@end
