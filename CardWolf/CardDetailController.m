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

@implementation CardDetailController

@synthesize cardDetailArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        card = userCard;
        self.navigationItem.title = @"Card Details";
        
        [self setUpFields];
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
    
    //self.navigationItem.rightBarButtonItem = doneButton;
    
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
    
    cardTitle.text = card.cardType;
    
    UIImage *image = [UIImage imageNamed:card.cardImage];
    cardImage.image = image;
    
    UIColor *color = [UIColor groupTableViewBackgroundColor];
	if (CGColorGetPattern(color.CGColor) == NULL) {
		color = [UIColor lightGrayColor];
	}
	self.view.backgroundColor = color; 
    
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CardDetailIdentifier"];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"CardDetailIdentifier"] autorelease];
    }
    
    NSDictionary *dictionary = [cardDetailArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"Menu"];
    
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    
    if (cell.textLabel.text == @"Message") {
        [cell addSubview:messageField];
        if (card.cardMessage.length > 0) 
            messageField.text = card.cardMessage;
    }
    if (cell.textLabel.text == @"To") {
        [cell addSubview:toField];
        if (card.cardTo.length > 0) 
            toField.text = card.cardTo;
    }
    if (cell.textLabel.text == @"From") {
        [cell addSubview:fromField];
        if (card.cardFrom.length > 0) 
            fromField.text = card.cardFrom;
    }
    if (cell.textLabel.text == @"Date" && card.cardDate != nil) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateStyle = NSDateFormatterMediumStyle;
        
        cell.detailTextLabel.text = [df stringFromDate:card.cardDate];
    }
    
    if (cell.textLabel.text == @"Address" && card.cardAddress.length > 0) {
        cell.detailTextLabel.text = card.cardAddress;
    }
    
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Get Selected Row and display the correct ViewController
    NSDictionary *dictionary = [cardDetailArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"Menu"];
    NSString *selectedMenu = [array objectAtIndex:indexPath.row];
    
    //    if (selectedMenu == @"Message")
    //    {
    //        MessageController *messageController = [[MessageController alloc] initWithNibName:@"MessageController" bundle:nil card:card]; 
    //            
    //        [self.navigationController pushViewController:messageController animated:YES];
    //            
    //        [messageController release];
    //    }
    //    if (selectedMenu == @"To" || selectedMenu == @"From") {
    //        ToFromController *toFromController = [[ToFromController alloc] initWithNibName:@"ToFromController" bundle:nil card:card]; 
    //        
    //        [self.navigationController pushViewController:toFromController animated:YES];
    //        
    //        [toFromController release];
    //    }
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

- (IBAction)doneButtonTapped:(id)sender {
    //Validate the fields! 
    ConfirmationController *confirmationController = [[ConfirmationController alloc] initWithNibName:@"ConfirmationController" bundle:nil card:card];
    
    [self.navigationController pushViewController:confirmationController animated:YES];
    
    [confirmationController release];
}

#pragma fieldSetup

- (void)setUpFields {
    //New bit
    toField = [[UITextField alloc] initWithFrame:CGRectMake(95, 12, 185, 30)];
    toField.delegate = self;
    toField.adjustsFontSizeToFitWidth = YES;
    toField.textColor = [UIColor blackColor];
    toField.keyboardType = UIKeyboardTypeDefault;
    toField.returnKeyType = UIReturnKeyDone;
    toField.backgroundColor = [UIColor whiteColor];
    toField.autocorrectionType = UITextAutocorrectionTypeYes;
    toField.autocapitalizationType = UITextAutocapitalizationTypeSentences; 
    toField.textAlignment = UITextAlignmentLeft;
    toField.enablesReturnKeyAutomatically = YES;
    toField.tag = 0;  
    toField.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
    toField.enabled = YES;
    toField.returnKeyType = UIReturnKeyDone;
    toField.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    [toField addTarget:self
                action:@selector(textFieldFinished:)
      forControlEvents:UIControlEventEditingDidEndOnExit];
    
    fromField = [[UITextField alloc] initWithFrame:CGRectMake(95, 12, 185, 30)];
    fromField.delegate = self;
    fromField.adjustsFontSizeToFitWidth = YES;
    fromField.textColor = [UIColor blackColor];
    fromField.keyboardType = UIKeyboardTypeDefault;
    fromField.returnKeyType = UIReturnKeyDone;
    fromField.backgroundColor = [UIColor whiteColor];
    fromField.autocorrectionType = UITextAutocorrectionTypeYes; 
    fromField.autocapitalizationType = UITextAutocapitalizationTypeSentences; 
    fromField.textAlignment = UITextAlignmentLeft;
    fromField.enablesReturnKeyAutomatically = YES;
    fromField.tag = 1;  
    fromField.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
    fromField.enabled =  YES;
    fromField.returnKeyType = UIReturnKeyDone;
    fromField.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    [fromField addTarget:self
                  action:@selector(textFieldFinished:)
        forControlEvents:UIControlEventEditingDidEndOnExit];
    
    messageField = [[UITextField alloc] initWithFrame:CGRectMake(95, 12, 185, 30)];
    messageField.delegate = self;
    messageField.adjustsFontSizeToFitWidth = YES;
    messageField.textColor = [UIColor blackColor];
    messageField.keyboardType = UIKeyboardTypeDefault;
    messageField.returnKeyType = UIReturnKeyDone;
    messageField.backgroundColor = [UIColor whiteColor];
    messageField.autocorrectionType = UITextAutocorrectionTypeYes; // no auto correction support
    messageField.autocapitalizationType = UITextAutocapitalizationTypeSentences; // no auto capitalization support
    messageField.textAlignment = UITextAlignmentLeft;
    messageField.enablesReturnKeyAutomatically = YES;
    messageField.tag = 2;  
    messageField.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
    messageField.enabled =  YES;
    messageField.returnKeyType = UIReturnKeyDone;
    messageField.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    [messageField addTarget:self
                     action:@selector(textFieldFinished:)
           forControlEvents:UIControlEventEditingDidEndOnExit];
}

#pragma textField Editing
- (IBAction)textFieldFinished:(id)sender {
    if ([toField isFirstResponder]) {
        card.cardTo = toField.text;
    }
    else if ([fromField isFirstResponder]) {
        card.cardFrom = fromField.text;
    }
    else if ([messageField isFirstResponder]) {
        card.cardMessage = messageField.text;
    }
    
    [sender resignFirstResponder];
}

@end

