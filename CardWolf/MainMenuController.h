//
//  MainMenuController.h
//  CardWolf
//
//  Created by Neil Sheppard on 05/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainMenuController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *menuDetailArray;
    IBOutlet UITableView *tableViewOutlet;
}

@property (nonatomic, retain) NSMutableArray *menuDetailArray;

@end
