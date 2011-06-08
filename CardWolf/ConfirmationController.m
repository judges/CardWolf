//
//  ConfirmationController.m
//  CardWolf
//
//  Created by Neil Sheppard on 16/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ConfirmationController.h"
#import "PayPalPayment.h"
#import "PayPalAdvancedPayment.h"
#import "PayPalAmounts.h"
#import "PayPalReceiverAmounts.h"
#import "PayPalAddress.h"
#import "PayPalInvoiceItem.h"

#define SPACING 3.

@implementation ConfirmationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        card = userCard;
        self.title = @"Confirmation Details";
        
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
    
    
//    UIBarButtonItem *confirmButton = [[UIBarButtonItem alloc] 
//                                      initWithTitle:@"Confirm"
//                                      style:UIBarButtonItemStyleBordered 
//                                      target:self 
//                                      action:@selector(confirmButtonTapped:)];
//                                      
//    self.navigationItem.rightBarButtonItem = confirmButton;
//    
//    [confirmButton release];
    
    UIColor *color = [UIColor groupTableViewBackgroundColor];
	if (CGColorGetPattern(color.CGColor) == NULL) {
		color = [UIColor lightGrayColor];
	}
	self.view.backgroundColor = color;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    
    // Do any additional setup after loading the view from its nib.
    cardDetails.text = [[NSString alloc] initWithFormat:@"Please check details of your order prior to confirming.\n\nCard Details:\nType:%@\nFrom:%@\nTo:%@\nMessage:%@\nDelivery Date:%@\nDelivery Address:%@\n\nwww.cardwolf.co.uk", card.cardType, card.cardFrom, card.cardTo, card.cardMessage, [df stringFromDate:card.cardDate], card.cardAddress];
    
    [df release];
    
    // PayPal shizzle
    //PayPalPaymentType paymentType = ;
    //Get the PayPal Library button. 
    //We will be handling the callback, 
    //so we declare 'self' as the target. 
    //We want a large button, so we use BUTTON_278x43. 
    //Our checkout method is 'payWithPayPal', 
    //and we pass through our payment type.
    //We can move the button afterward if desired. 
    
    status = PAYMENTSTATUS_CANCELED;
    
    UIButton *button = [[PayPal getInstance] getPayButtonWithTarget:self andAction:@selector(payWithPayPal) andButtonType:BUTTON_278x43 andButtonText:BUTTON_TEXT_PAY];
	
    button.frame = CGRectMake(21.0, 350.0, 278.0, 43.0);
                         
    [self.view addSubview:button];
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

- (IBAction)confirmButtonTapped:(id)sender {
    //NSString *message = [NSString stringWithFormat:@"Thanks for your order!"];
    //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //[alert show];
    //[alert release];
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)payWithPayPal {
    //dismiss any native keyboards
	//[preapprovalField resignFirstResponder];
	
	//optional, set shippingEnabled to TRUE if you want to display shipping
	//options to the user, default: TRUE
	[PayPal getInstance].shippingEnabled = TRUE;
	
	//optional, set dynamicAmountUpdateEnabled to TRUE if you want to compute
	//shipping and tax based on the user's address choice, default: FALSE
	//[PayPal getInstance].dynamicAmountUpdateEnabled = TRUE;
	
	//optional, choose who pays the fee, default: FEEPAYER_EACHRECEIVER
	[PayPal getInstance].feePayer = FEEPAYER_EACHRECEIVER;
	
	//for a payment with a single recipient, use a PayPalPayment object
	PayPalPayment *payment = [[[PayPalPayment alloc] init] autorelease];
	payment.recipient = @"seller_1307017992_biz@neilsheppard.com";
	payment.paymentCurrency = @"GBP";
	//payment.description = card.cardType;
    payment.description = @"Test Descriptions\brWith line breaks\brDoes it work?";
    //payment.memo = @"Test Descriptions\brWith line breaks\brDoes it work?";
	payment.merchantName = @"CardWolf";
	
    //subtotal of all items, without tax and shipping
	payment.subTotal = [NSDecimalNumber decimalNumberWithString:@"1.99"];
    
	//invoiceData is a PayPalInvoiceData object which contains tax, shipping, and a list of PayPalInvoiceItem objects
	payment.invoiceData = [[[PayPalInvoiceData alloc] init] autorelease];
	payment.invoiceData.totalShipping = [NSDecimalNumber decimalNumberWithString:@"0.20"];
	//payment.invoiceData.totalTax = [NSDecimalNumber decimalNumberWithString:@"0.00"];
	
	//invoiceItems is a list of PayPalInvoiceItem objects
	//NOTE: sum of totalPrice for all items must equal payment.subTotal
	//NOTE: example only shows a single item, but you can have more than one
	payment.invoiceData.invoiceItems = [NSMutableArray array];

	PayPalInvoiceItem *item = [[[PayPalInvoiceItem alloc] init] autorelease];
	item.totalPrice = payment.subTotal;
    item.itemCount = [NSNumber numberWithInt:1];
    item.itemPrice = [NSDecimalNumber decimalNumberWithString:@"1.99"];
	item.name = card.cardType;
	[payment.invoiceData.invoiceItems addObject:item];
    
	[[PayPal getInstance] checkoutWithPayment:payment];
    
}

#pragma mark -
#pragma mark PayPalPaymentDelegate methods

//paymentSuccessWithKey:andStatus: is a required method. in it, you should record that the payment
//was successful and perform any desired bookkeeping. you should not do any user interface updates.
//payKey is a string which uniquely identifies the transaction.
//paymentStatus is an enum value which can be STATUS_COMPLETED, STATUS_CREATED, or STATUS_OTHER
- (void)paymentSuccessWithKey:(NSString *)payKey andStatus:(PayPalPaymentStatus)paymentStatus {
	status = PAYMENTSTATUS_SUCCESS;
    
}

//paymentFailedWithCorrelationID:andErrorCode:andErrorMessage: is a required method. in it, you should
//record that the payment failed and perform any desired bookkeeping. you should not do any user interface updates.
//correlationID is a string which uniquely identifies the failed transaction, should you need to contact PayPal.
//errorCode is generally (but not always) a numerical code associated with the error.
//errorMessage is a human-readable string describing the error that occurred.
- (void)paymentFailedWithCorrelationID:(NSString *)correlationID andErrorCode:(NSString *)errorCode andErrorMessage:(NSString *)errorMessage {
	status = PAYMENTSTATUS_FAILED;
}

//paymentCanceled is a required method. in it, you should record that the payment was canceled by
//the user and perform any desired bookkeeping. you should not do any user interface updates.
- (void)paymentCanceled {
	status = PAYMENTSTATUS_CANCELED;
}

//paymentLibraryExit is a required method. this is called when the library is finished with the display
//and is returning control back to your app. you should now do any user interface updates such as
//displaying a success/failure/canceled message.
- (void)paymentLibraryExit {
	UIAlertView *alert = nil;
	switch (status) {
		case PAYMENTSTATUS_SUCCESS:
            [self.navigationController popToRootViewControllerAnimated:YES];
			break;
		case PAYMENTSTATUS_FAILED:
			alert = [[UIAlertView alloc] initWithTitle:@"Order failed" 
											   message:@"Your order failed. Touch \"Pay with PayPal\" to try again." 
											  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			break;
		case PAYMENTSTATUS_CANCELED:
			alert = [[UIAlertView alloc] initWithTitle:@"Order canceled" 
											   message:@"You canceled your order. Touch \"Pay with PayPal\" to try again." 
											  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			break;
	}
	[alert show];
	[alert release];
}

@end
