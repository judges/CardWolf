//
//  MessageController.h
//  CardWolf
//
//  Created by Neil Sheppard on 05/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"


@interface MessageController : UIViewController <UITableViewDataSource, UITableViewDataSource, UITextFieldDelegate> {
    Card *card;
    NSMutableArray *messageDetails;
    UITextField *messageField;
} 

@property (nonatomic, retain) NSMutableArray *messageDetails;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard;
- (IBAction) doneButtonTapped:(id) sender;

@end
