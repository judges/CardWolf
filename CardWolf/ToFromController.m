//
//  ToFromController.m
//  CardWolf
//
//  Created by Neil Sheppard on 18/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ToFromController.h"


@implementation ToFromController

@synthesize toFromDetails;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        card = userCard;
        self.title = card.cardType;
        
        toField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
        toField.delegate = self;
        toField.delegate = self;
        toField.adjustsFontSizeToFitWidth = YES;
        toField.textColor = [UIColor blackColor];
        toField.placeholder = @"To";
        toField.keyboardType = UIKeyboardTypeDefault;
        toField.returnKeyType = UIReturnKeyDone;
        toField.backgroundColor = [UIColor whiteColor];
        toField.autocorrectionType = UITextAutocorrectionTypeYes; // no auto correction support
        toField.autocapitalizationType = UITextAutocapitalizationTypeSentences; // no auto capitalization support
        toField.textAlignment = UITextAlignmentLeft;
        toField.enablesReturnKeyAutomatically = YES;
        toField.tag = 0;  
        toField.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
        toField.enabled =  YES;
        
        fromField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
        fromField.delegate = self;
        fromField.delegate = self;
        fromField.adjustsFontSizeToFitWidth = YES;
        fromField.textColor = [UIColor blackColor];
        fromField.placeholder = @"From";
        fromField.keyboardType = UIKeyboardTypeDefault;
        fromField.returnKeyType = UIReturnKeyDone;
        fromField.backgroundColor = [UIColor whiteColor];
        fromField.autocorrectionType = UITextAutocorrectionTypeYes; // no auto correction support
        fromField.autocapitalizationType = UITextAutocapitalizationTypeSentences; // no auto capitalization support
        fromField.textAlignment = UITextAlignmentLeft;
        fromField.enablesReturnKeyAutomatically = YES;
        fromField.tag = 0;  
        fromField.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
        fromField.enabled =  YES;

        if (card.cardTo.length > 0)
            toField.text = card.cardTo;
        
        if (card.cardFrom.length > 0)
            fromField.text = card.cardFrom;

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
    
    [toField becomeFirstResponder];
    
    toFromDetails = [[NSMutableArray alloc] initWithObjects:@"To", @"From", nil];
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
    
    card.cardTo = toField.text;
    card.cardFrom = fromField.text;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [toFromDetails count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageIdentifier"];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MessageIdentifier"] autorelease];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([toFromDetails objectAtIndex:indexPath.row] == @"To")
            [cell addSubview:toField];
        else
            [cell addSubview:fromField];
    }
    
    cell.textLabel.textColor = [UIColor grayColor];
    //cell.textLabel.font = [UIFont systemFontOfSize:10];
    cell.textLabel.text = [toFromDetails objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Get Selected Row and display the correct ViewController
}

@end
