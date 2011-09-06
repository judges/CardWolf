//
//  CoolStuffController.m
//  CardWolf
//
//  Created by Neil Sheppard on 17/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CoolStuffController.h"
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
    NSString *code = textField.text;
    NSURL *url = [NSURL URLWithString:@"http://www.cardwolf.co.uk/promos/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"1" forKey:@"rw_app_id"];
    [request setPostValue:code forKey:@"code"];
    [request setPostValue:uniqueIdentifier forKey:@"device_id"];
    [request setDelegate:self];
    [request startAsynchronous];
    
    // Hide keyboard
    [textField resignFirstResponder];
    
    // Clear textfield
    textView.text = @"";
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Redeeming code...";
    
    return TRUE;
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (request.responseStatusCode == 400) {
        textView.text = @"Invalid Code";
    } else if (request.responseStatusCode == 403) {
        textView.text = @"Code already used";
    } else if (request.responseStatusCode == 200) {
        NSString *responseString = [request responseString];
        NSDictionary *responseDict = [responseString JSONValue];
        NSString *unlockCode = [responseDict objectForKey:@"unlock_code"];
        
        if ([unlockCode compare:@"cardwolf.iphone.unlock.promo1"] == NSOrderedSame) {
            textView.text = @"The cake is a lie!";
        } else {
            textView.text = [NSString stringWithFormat:@"Received unexpected unlock code: %@", unlockCode];
        }
    } else {
        textView.text = @"Unexpected error";
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSError *error = [request error];
    textView.text = error.localizedDescription;
}

@end
