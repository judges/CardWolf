//
//  CoolStuffController.h
//  CardWolf
//
//  Created by Neil Sheppard on 17/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CoolStuffController : UIViewController <UITextFieldDelegate> {
    
    UITextView *textView;
}

@property (nonatomic, retain) IBOutlet UITextView *textView;

@end
