//
//  ConfirmationController.h
//  CardWolf
//
//  Created by Neil Sheppard on 16/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"
#import "PayPal.h"

typedef enum PaymentStatuses {
	PAYMENTSTATUS_SUCCESS,
	PAYMENTSTATUS_FAILED,
	PAYMENTSTATUS_CANCELED,
} PaymentStatus;

@interface ConfirmationController : UIViewController <PayPalPaymentDelegate> {
    Card *card;
    IBOutlet UITextView *cardDetails;
    UIButton *payPalButton;
    CGFloat y;
    PaymentStatus status;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard;
- (void)payWithPayPal;

@end
