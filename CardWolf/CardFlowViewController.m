//
//  CardFlowViewController.m
//  CardWolf
//
//  Created by Neil Sheppard on 14/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CardFlowViewController.h"
#import "CardDetailController.h"
#import "CardViewController.h"

#define ITEM_SPACING 210
#define USE_BUTTONS YES

@interface CardFlowViewController () <UIActionSheetDelegate>

@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, retain) NSMutableArray *items;

@end

@implementation CardFlowViewController

@synthesize carousel;
@synthesize wrap;
@synthesize items;
@synthesize pictureArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        card = userCard;
        // Custom initialization
        self.title = @"Choose Card";
        
        NSString *Path = [[NSBundle mainBundle] bundlePath];
        NSString *DataPath = [Path stringByAppendingPathComponent:@"CardPictures.plist"];
        
        NSDictionary *dictionary;
        dictionary = [NSDictionary dictionaryWithContentsOfFile:DataPath];
        pictureArray = [[dictionary objectForKey: card.cardType] retain];
        
        //set up data
        self.items = [NSMutableArray array];

        for (int i = 0; i < [pictureArray count]; i++)
        {
            [items addObject:[NSNumber numberWithInt:i]];
        }
        
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [pictureArray release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark UIActionSheet methods

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //restore view opacities to normal
    for (UIView *view in carousel.visibleItemViews)
    {
        view.alpha = 1.0;
    }
    
    carousel.type = iCarouselTypeCoverFlow;
}

#pragma mark -

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    carousel.type = iCarouselTypeCoverFlow;
    carousel.bounces = NO;
    
    if ([pictureArray count] > 1) 
        wrap = YES;
    else {
        wrap = YES;
        carousel.scrollEnabled = NO;
    }
    
    UIColor *color = [UIColor groupTableViewBackgroundColor];
	if (CGColorGetPattern(color.CGColor) == NULL) {
		color = [UIColor lightGrayColor];
	}
	self.view.backgroundColor = color; 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.carousel = nil;
}

#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    if (USE_BUTTONS)
    {
        UIImage *image = [UIImage imageNamed:[pictureArray objectAtIndex:index]];
        
        UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)] autorelease];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = index;
        return button;
    }
    else
    {
        UIView *view = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:[pictureArray objectAtIndex:index]]] autorelease];
        return view;
    }
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
	//note: placeholder views are only displayed if wrapping is disabled
    if ([items count] == 1)
        return 1;
    else
        return 2;
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index
{
    UIView *view = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:[pictureArray objectAtIndex:index]]] autorelease];
	return view;
}

- (float)carouselItemWidth:(iCarousel *)carousel
{
    //slightly wider than item view
    return ITEM_SPACING;
}

- (CATransform3D)carousel:(iCarousel *)_carousel transformForItemView:(UIView *)view withOffset:(float)offset
{
    //implement 'flip3D' style carousel
    
    //set opacity based on distance from camera
    view.alpha = 1.0 - fminf(fmaxf(offset, 0.0), 1.0);
    
    //do 3d transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = self.carousel.perspective;
    transform = CATransform3DRotate(transform, M_PI / 8.0, 0, 1.0, 0);
    return CATransform3DTranslate(transform, 0.0, 0.0, offset * carousel.itemWidth);
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    //wrap all carousels
    return wrap;
}

- (void)carouselWillBeginDragging:(iCarousel *)carousel
{
	//NSLog(@"Carousel will begin dragging");
}

- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate
{
	//NSLog(@"Carousel did end dragging and %@ decelerate", decelerate? @"will": @"won't");
}

- (void)carouselWillBeginDecelerating:(iCarousel *)carousel
{
	//NSLog(@"Carousel will begin decelerating");
}

- (void)carouselDidEndDecelerating:(iCarousel *)carousel
{
	//NSLog(@"Carousel did end decelerating");
}

- (void)carouselWillBeginScrollingAnimation:(iCarousel *)carousel
{
	//NSLog(@"Carousel will begin scrolling");
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
	//NSLog(@"Carousel did end scrolling");
}

- (void)carousel:(iCarousel *)_carousel didSelectItemAtIndex:(NSInteger)index
{
	if (index == carousel.currentItemIndex)
	{
		//note, this will only ever happen if USE_BUTTONS == NO
		//otherwise the button intercepts the tap event
		//NSLog(@"Selected current item");
        
        card.cardImage = [pictureArray objectAtIndex:index];
        
//        NSLog(@"%@", card.cardImage);
//        
//        CardDetailController *detailController = [[CardDetailController alloc] initWithNibName:@"CardDetailController" bundle:nil card:card];
//        
//        [self.navigationController pushViewController:detailController animated:YES];
//        
//        [detailController release];
        
	}
	else
	{
        
        card.cardImage = [pictureArray objectAtIndex:index];
//        
//		//NSLog(@"Selected item number %i", index);
//        CardDetailController *detailController = [[CardDetailController alloc] initWithNibName:@"CardDetailController" bundle:nil card:card];
//            
//        [self.navigationController pushViewController:detailController animated:YES];
//            
//        [detailController release];
        
        [self showActionSheet];
        
	}
}

#pragma mark -

#pragma mark Button tap event

- (void)buttonTapped:(UIButton *)sender
{
    card.cardImage = [pictureArray objectAtIndex:sender.tag];

    [self showActionSheet];
}

#pragma mark UIActionSheet stuff

-(IBAction)showActionSheet {
    UIActionSheet *popupQuery = [[UIActionSheet alloc] 
                                 initWithTitle:@"Recipient" 
                                 delegate:self 
                                 cancelButtonTitle:@"Cancel" 
                                 destructiveButtonTitle:nil
                                 otherButtonTitles:@"Send to self", @"Send to other", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [popupQuery showInView:self.view];
    [popupQuery release];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        CardViewController *detailController = [[CardViewController alloc] initWithNibName:@"CardViewController" bundle:nil card:card];
        
        [self.navigationController pushViewController:detailController animated:YES];
        
        [detailController release];
    } else if (buttonIndex == 1) {
        CardDetailController *detailController = [[CardDetailController alloc] initWithNibName:@"CardDetailController" bundle:nil card:card];
        
        [self.navigationController pushViewController:detailController animated:YES];
    } else if (buttonIndex == 2) {
        NSLog(@"Cancel button");
    }
}

@end





