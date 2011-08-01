//
//  AddressController.m
//  CardWolf
//
//  Created by Neil Sheppard on 16/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressController.h"
#import "ConfirmationController.h"
#import "regex.h"

@implementation AddressController

@synthesize addressDetails;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        card = userCard;
        self.title = @"Address";
        
        //Manual Field Setup
        numberField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
        numberField.delegate = self;
        numberField.adjustsFontSizeToFitWidth = YES;
        numberField.textColor = [UIColor blackColor];
        numberField.placeholder = @"Property Number";
        numberField.keyboardType = UIKeyboardTypeDefault;
        numberField.returnKeyType = UIReturnKeyDone;
        numberField.backgroundColor = [UIColor whiteColor];
        numberField.autocorrectionType = UITextAutocorrectionTypeYes; // no auto correction support
        numberField.autocapitalizationType = UITextAutocapitalizationTypeSentences; // no auto capitalization support
        numberField.textAlignment = UITextAlignmentLeft;
        numberField.enablesReturnKeyAutomatically = YES;
        numberField.tag = 0;  
        numberField.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
        numberField.enabled =  YES;
        
        address1Field = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
        address1Field.delegate = self;
        address1Field.adjustsFontSizeToFitWidth = YES;
        address1Field.textColor = [UIColor blackColor];
        address1Field.placeholder = @"Address Line";
        address1Field.keyboardType = UIKeyboardTypeDefault;
        address1Field.returnKeyType = UIReturnKeyDone;
        address1Field.backgroundColor = [UIColor whiteColor];
        address1Field.autocorrectionType = UITextAutocorrectionTypeYes; // no auto correction support
        address1Field.autocapitalizationType = UITextAutocapitalizationTypeSentences; // no auto capitalization support
        address1Field.textAlignment = UITextAlignmentLeft;
        address1Field.enablesReturnKeyAutomatically = YES;
        address1Field.tag = 0;  
        address1Field.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
        address1Field.enabled =  YES;

        address2Field = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
        address2Field.delegate = self;
        address2Field.adjustsFontSizeToFitWidth = YES;
        address2Field.textColor = [UIColor blackColor];
        address2Field.placeholder = @"Address Line 2";
        address2Field.keyboardType = UIKeyboardTypeDefault;
        address2Field.returnKeyType = UIReturnKeyDone;
        address2Field.backgroundColor = [UIColor whiteColor];
        address2Field.autocorrectionType = UITextAutocorrectionTypeYes; // no auto correction support
        address2Field.autocapitalizationType = UITextAutocapitalizationTypeSentences; // no auto capitalization support
        address2Field.textAlignment = UITextAlignmentLeft;
        address2Field.enablesReturnKeyAutomatically = YES;
        address2Field.tag = 0;  
        address2Field.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
        address2Field.enabled =  YES;

        cityField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
        cityField.delegate = self;
        cityField.adjustsFontSizeToFitWidth = YES;
        cityField.textColor = [UIColor blackColor];
        cityField.placeholder = @"City";
        cityField.keyboardType = UIKeyboardTypeDefault;
        cityField.returnKeyType = UIReturnKeyDone;
        cityField.backgroundColor = [UIColor whiteColor];
        cityField.autocorrectionType = UITextAutocorrectionTypeYes; // no auto correction support
        cityField.autocapitalizationType = UITextAutocapitalizationTypeSentences; // no auto capitalization support
        cityField.textAlignment = UITextAlignmentLeft;
        cityField.enablesReturnKeyAutomatically = YES;
        cityField.tag = 0;  
        cityField.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
        cityField.enabled =  YES;

        postcodeField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
        postcodeField.delegate = self;
        postcodeField.adjustsFontSizeToFitWidth = YES;
        postcodeField.textColor = [UIColor blackColor];
        postcodeField.placeholder = @"Postcode";
        postcodeField.keyboardType = UIKeyboardTypeDefault;
        postcodeField.returnKeyType = UIReturnKeyDone;
        postcodeField.backgroundColor = [UIColor whiteColor];
        postcodeField.autocorrectionType = UITextAutocorrectionTypeYes; // no auto correction support
        postcodeField.autocapitalizationType = UITextAutocapitalizationTypeSentences; // no auto capitalization support
        postcodeField.textAlignment = UITextAlignmentLeft;
        postcodeField.enablesReturnKeyAutomatically = YES;
        postcodeField.tag = 0;  
        postcodeField.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
        postcodeField.enabled =  YES;
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
    
    [numberField becomeFirstResponder];
    
    addressDetails = [[NSMutableArray alloc] initWithObjects:@"Number", @"Address", @"", @"City", @"Postcode", nil];
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
    
    NSString *message = @"You have failed to complete the following fields";
    
    NSMutableArray *chunks = [[NSMutableArray alloc] initWithCapacity:4];
    NSMutableArray *messageArray = [[NSMutableArray alloc] initWithCapacity:2];
    NSString *numberMessage = @"Number";
    NSString *add1Message = @"Address 1";
    NSString *cityMessage = @"City";
    NSString *postcodeMessage = @"Postcode";
    
    bool error = false;
    
    bool validPostcode = [self checkPostcode:postcodeField.text];
    
    if (!(validPostcode)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Invalid Postcode, please use a valid one" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    if (validPostcode)
    {
        [messageArray addObject:message];
    
        if ([numberField.text isEqualToString:@""] && numberField.text.length == 0) {
            [chunks addObject:numberMessage];
            error = true;
        }
        if ([address1Field.text isEqualToString:@""] && address1Field.text.length == 0) {
            [chunks addObject:add1Message];
            error = true;
        }
        if ([cityField.text isEqualToString:@""] && cityField.text.length == 0) {
            [chunks addObject:cityMessage];
            error = true;
        }
        if ([postcodeField.text isEqualToString:@""] && postcodeField.text.length == 0) {
            [chunks addObject:postcodeMessage];
            error = true;
        }
    
        if (error == true) 
        {
            NSString *alertMessage = [chunks componentsJoinedByString:@","];
            [messageArray addObject:alertMessage];
            NSString *fullMessage = [messageArray componentsJoinedByString:@":"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:fullMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            [chunks release];
            [message release];
            [numberMessage release];
            [add1Message release];
            [cityMessage release];
            [postcodeMessage release];
        }
        else 
        {
            [chunks release];
            [message release];
            [numberMessage release];
            [add1Message release];
            [cityMessage release]; 
            [postcodeMessage release];
    
            NSMutableString *address = [[NSMutableString alloc] initWithString:numberField.text];            
        
            [address appendString:@" "];
            [address appendString:address1Field.text];
        
            if (address2Field.text.length > 0) {
                [address appendString:@","];
                [address appendString:address2Field.text];
            }
        
            [address appendString:@","];
            [address appendString:cityField.text];
        
            [address appendString:@","];
            [address appendString:postcodeField.text];
        
            NSLog(@"%@", address);
        
            card.cardAddress = address;
        
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (bool) checkPostcode:(NSString *)postCode {
    NSString *regex = @"^([A-PR-UWYZ](([0-9](([0-9]|[A-HJKSTUW])?)?)|([A-HK-Y][0-9]([0-9]|[ABEHMNPRVWXY])?)) [0-9][ABD-HJLNP-UW-Z]{2})|GIR 0AA$";
    
    NSPredicate *regextest = [NSPredicate
                              predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([regextest evaluateWithObject:postCode] == YES) {
        NSLog(@"Match!");
        return true;
    } else {
        NSLog(@"No match!");
        return false;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:cityField])
    {
        if (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    } else if (!([textField isEqual:postcodeField])) 
    {
        [self setViewMovedUp:NO];
    }
        
}

- (void)setViewMovedUp:(BOOL)movedUp {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    CGRect rect = self.view.frame;
    
    if (movedUp)
    {
        rect.origin.y -= 60;
        rect.size.height += 60;
    } else {
        if (rect.origin.y != 0) {
            rect.origin.y += 60;
            rect.size.height -= 60;
        }
    }
    self.view.frame = rect;
    
    [UIView setAnimationDuration:0.0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [addressDetails count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageIdentifier"];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MessageIdentifier"] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([addressDetails objectAtIndex:indexPath.row] == @"Number")
            [cell addSubview:numberField];
        else if ([addressDetails objectAtIndex:indexPath.row] == @"Address")
            [cell addSubview:address1Field];
        else if ([addressDetails objectAtIndex:indexPath.row] == @"")
            [cell addSubview:address2Field];
        else if([addressDetails objectAtIndex:indexPath.row] == @"City")
            [cell addSubview:cityField];
        else
            [cell addSubview:postcodeField];
    }
    
    cell.textLabel.textColor = [UIColor grayColor];
    //cell.textLabel.font = [UIFont systemFontOfSize:10];
    cell.textLabel.text = [addressDetails objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Get Selected Row and display the correct ViewController
}

@end
