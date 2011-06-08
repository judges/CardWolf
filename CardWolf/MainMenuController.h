//
//  MainMenuController.h
//  CardWolf
//
//  Created by Neil Sheppard on 05/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainMenuController : UIViewController {
    IBOutlet UIButton *cardButton;
    IBOutlet UIButton *calendarButton;
    IBOutlet UIButton *costButton;
    IBOutlet UIButton *contactButton;
    IBOutlet UIButton *stuffButton;
}

-(IBAction)gotoCardScreen:(id)sender;

@end
