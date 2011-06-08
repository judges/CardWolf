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
}

@property (nonatomic, retain) NSMutableArray *cardTypeArray;


@end
