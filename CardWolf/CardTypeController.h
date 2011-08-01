//
//  CardTypeController.h
//  CardWolf
//
//  Created by Neil Sheppard on 05/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"


@interface CardTypeController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *cardTypeArray;
    NSDictionary *data;
	NSString *CurrentTitle;
	NSInteger CurrentLevel;
    Card *card;
    NSMutableString *cardType;
}

@property (nonatomic, retain) NSMutableArray *cardTypeArray;
@property (nonatomic, retain) NSDictionary *data;
@property (nonatomic, retain) NSString *CurrentTitle;
@property (nonatomic, readwrite) NSInteger CurrentLevel;
@property (nonatomic, retain) NSMutableString *cardType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard;

@end
