//
//  AddressController.h
//  CardWolf
//
//  Created by Neil Sheppard on 16/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"


@interface AddressController : UIViewController <UITableViewDataSource, UITableViewDataSource, UITextFieldDelegate> {
    Card *card;
    NSMutableArray *addressDetails;
    UITextField *numberField;
    UITextField *address1Field;
    UITextField *address2Field;
    UITextField *cityField;
    UITextField *postcodeField;
    BOOL viewHasMoved;
}

@property (nonatomic, retain) NSMutableArray *addressDetails;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard;
- (IBAction) doneButtonTapped:(id) sender;
- (void) setViewMovedUp:(BOOL)movedUp;
- (bool) checkPostcode:(NSString *)postCode;

@end
