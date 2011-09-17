//
//  CardViewController.h
//  CardWolf
//
//  Created by Neil Sheppard on 13/09/2011.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface CardViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    Card *card;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard;

@end
