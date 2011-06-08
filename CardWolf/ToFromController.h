//
//  ToFromController.h
//  CardWolf
//
//  Created by Neil Sheppard on 18/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface ToFromController : UIViewController <UITableViewDataSource, UITableViewDataSource, UITextFieldDelegate> {
    Card *card;
    NSMutableArray *toFromDetails;
    UITextField *toField;
    UITextField *fromField;
}

@property (nonatomic, retain) NSMutableArray *toFromDetails;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard;
- (IBAction) doneButtonTapped:(id) sender;

@end
