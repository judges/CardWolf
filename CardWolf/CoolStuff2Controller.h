//
//  CoolStuff2Controller.h
//  CardWolf
//
//  Created by Neil Sheppard on 15/09/2011.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface CoolStuff2Controller : UIViewController {
    IBOutlet UITextView *textView;
    Card *card;
}

-(void)completeOrder:(NSInteger)rowID;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard;

@end
