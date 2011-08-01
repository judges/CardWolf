//
//  CardDetailController.h
//  CardWolf
//
//  Created by Neil Sheppard on 18/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"


@interface CardDetailController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *cardDetailArray;
    Card *card;
    IBOutlet UITableView *tableViewOutlet;
    IBOutlet UIImageView *cardImage;
    IBOutlet UILabel *cardTitle;
}

@property (nonatomic, retain) NSMutableArray *cardDetailArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard;

@end
