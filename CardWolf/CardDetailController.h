//
//  CardDetailController.h
//  CardWolf
//
//  Created by Neil Sheppard on 18/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"
#import "AddNoteViewController.h"


@interface CardDetailController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    AddNoteViewController *expandingMessageController;
    NSMutableArray *cardDetailArray;
    Card *card;
    IBOutlet UITableView *tableViewOutlet;
}

@property (nonatomic, retain) NSMutableArray *cardDetailArray;
@property (nonatomic, retain) AddNoteViewController *expandingMessageController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard;

@end
