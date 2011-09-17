//
//  CoolStuff2Controller.m
//  CardWolf
//
//  Created by Neil Sheppard on 15/09/2011.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import "CoolStuff2Controller.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "MBProgressHUD.h"

@implementation CoolStuff2Controller

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        card = userCard;
        self.title = @"Cool Stuff 2";
        
    }
    return self;
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
    [self completeOrder:[card.orderID intValue]];
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

- (void)completeOrder:(NSInteger)rowID {
    NSURL *url = [NSURL URLWithString:@"http://www.cardwolf.co.uk/completeorder/"];
    //NSURL *url = [NSURL URLWithString:@"http://localhost:8888/cardwolf.co.uk/completeorder/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[NSNumber numberWithInteger:rowID] forKey:@"order_id"];
    [request setPostValue:@"PAYPALXXXX" forKey:@"paypal_id"];
    [request setDelegate:self];
    [request startAsynchronous];
    
    textView.text = @"";
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Completing Order...";
    
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (request.responseStatusCode == 400) {
        textView.text = @"Error";
    } else if (request.responseStatusCode == 200) {
        textView.text = [[NSString alloc] initWithFormat:@"Hello Hello %@", request.responseString];
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
