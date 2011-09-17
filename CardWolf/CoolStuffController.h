//
//  CoolStuffController.h
//  CardWolf
//
//  Created by Neil Sheppard on 17/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"


@interface CoolStuffController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate> {
    
    UITextView *textView;
    Card *card;
    NSString *requestType;
}

@property (nonatomic, retain) IBOutlet UITextView *textView;
- (IBAction)showActionSheet;

@end
