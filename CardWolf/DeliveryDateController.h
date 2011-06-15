//
//  DeliveryDateController.h
//  CardWolf
//
//  Created by Neil Sheppard on 16/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"


@interface DeliveryDateController : UIViewController <UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource> {
    Card *card;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UITableView *tableViewOutlet;
}

@property (nonatomic, retain) Card* card;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard;

- (IBAction)doneButtonTapped:(id)sender;
- (IBAction)dateChanged;

@end
