//
//  MessageController.m
//  CardWolf
//
//  Created by Neil Sheppard on 05/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MessageController.h"

@implementation MessageController

@synthesize messageDetails;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        card = userCard;
        self.title = card.cardType;
        
        messageField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
        messageField.delegate = self;
        messageField.delegate = self;
        messageField.adjustsFontSizeToFitWidth = YES;
        messageField.textColor = [UIColor blackColor];
        messageField.placeholder = @"Enter your message here";
        messageField.keyboardType = UIKeyboardTypeDefault;
        messageField.returnKeyType = UIReturnKeyDone;
        messageField.backgroundColor = [UIColor whiteColor];
        messageField.autocorrectionType = UITextAutocorrectionTypeYes; // no auto correction support
        messageField.autocapitalizationType = UITextAutocapitalizationTypeSentences; // no auto capitalization support
        messageField.textAlignment = UITextAlignmentLeft;
        messageField.enablesReturnKeyAutomatically = YES;
        messageField.tag = 0;  
        messageField.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
        messageField.enabled =  YES;
        
        if (card.cardMessage.length > 0)
            messageField.text = card.cardMessage;

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

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped:)];
    
    self.navigationItem.rightBarButtonItem = doneButton;
    
    [doneButton release];
    
    [messageField becomeFirstResponder];
    
    messageDetails = [[NSMutableArray alloc] initWithObjects:@"Message", nil];
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
    //Validate the fields! 
    
    card.cardMessage = messageField.text;
    
    [self.navigationController popViewControllerAnimated:YES];
}
 
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [messageDetails count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageIdentifier"];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MessageIdentifier"] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                   
        [cell addSubview:messageField];
    }
    
    cell.textLabel.textColor = [UIColor grayColor];
    //cell.textLabel.font = [UIFont systemFontOfSize:10];
    cell.textLabel.text = [messageDetails objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Get Selected Row and display the correct ViewController
}

@end
