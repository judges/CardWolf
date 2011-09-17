//
//  CoolStuffController.m
//  CardWolf
//
//  Created by Neil Sheppard on 17/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CoolStuffController.h"
#import "CoolStuff2Controller.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "MBProgressHUD.h"

@implementation CoolStuffController
@synthesize textView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         self.title = @"Cool Stuff";
    }
    return self;
}

- (void)dealloc
{
    [textView release];
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
    card = [Card alloc];
}

- (void)viewDidUnload
{
    [self setTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"Want to redeem: %@", textField.text);
    
    // Get device unique ID
    UIDevice *device = [UIDevice currentDevice];
    NSString *uniqueIdentifier = [device uniqueIdentifier];
    
    // Start request
    requestType = @"order";
    NSString *code = textField.text;
    //NSURL *url = [NSURL URLWithString:@"http://www.cardwolf.co.uk/promos/"];
    //NSURL *url = [NSURL URLWithString:@"http://localhost:8888/cardwolf.co.uk/order/"];
    NSURL *url = [NSURL URLWithString:@"http://www.cardwolf.co.uk/order/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"130B" forKey:@"addressnumber"];
    [request setPostValue:@"Landcoft Road" forKey:@"add_line1"];
    [request setPostValue:@"" forKey:@"add_line2"];
    [request setPostValue:@"London" forKey:@"add_city"];
    [request setPostValue:@"SE229JW" forKey:@"add_postcode"];
    [request setPostValue:@"2011-11-27" forKey:@"del_date"];
    [request setPostValue:@"Alex Clark" forKey:@"sender"];
    [request setPostValue:@"Neil Sheppard" forKey:@"recipient"];
    [request setPostValue:@"Happy Birthday!!" forKey:@"card_msg"];
    [request setPostValue:@"MC022.jpg" forKey:@"card_id"];
    [request setDelegate:self];
    [request startAsynchronous];
    
    // Hide keyboard
    [textField resignFirstResponder];
    
    // Clear textfield
    textView.text = @"";
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Processing Order...";
    
    return TRUE;
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (request.responseStatusCode == 400) {
        textView.text = @"Invalid Order";
    } else if (request.responseStatusCode == 200) {
        textView.text = [[NSString alloc] initWithFormat:@"Order processed, rowid: %@", request.responseString];
        card.orderID = request.responseString;
        [self showActionSheet];
    } else {
        textView.text = @"Unexpected error";
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSError *error = [request error];
    textView.text = error.localizedDescription;
}

-(IBAction)showActionSheet {
    UIActionSheet *popupQuery = [[UIActionSheet alloc] 
                                 initWithTitle:@"Order" 
                                 delegate:self 
                                 cancelButtonTitle:@"Cancel" 
                                 destructiveButtonTitle:nil
                                 otherButtonTitles:@"Complete", @"Do nothing", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [popupQuery showInView:self.view];
    [popupQuery release];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        CoolStuff2Controller *detailController = [[CoolStuff2Controller alloc] initWithNibName:@"CoolStuff2Controller" bundle:nil card:card];
        
        [self.navigationController pushViewController:detailController animated:YES];
        
        [detailController release];
    } else if (buttonIndex == 1) {
    } else if (buttonIndex == 2) {
    }
}


@end
