//
//  CardFlowViewController.h
//  CardWolf
//
//  Created by Neil Sheppard on 14/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"
#import "iCarousel.h"

@interface CardFlowViewController : UIViewController <iCarouselDataSource, iCarouselDelegate> {
	Card *card;	
    NSArray *pictureArray;
}

@property (nonatomic, retain) IBOutlet iCarousel *carousel;
@property (nonatomic, retain) NSArray *pictureArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard;

@end
