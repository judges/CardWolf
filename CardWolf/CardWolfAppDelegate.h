//
//  CardWolfAppDelegate.h
//  CardWolf
//
//  Created by Neil Sheppard on 03/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardWolfAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow* window;
    IBOutlet UINavigationController* cardWolfController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
