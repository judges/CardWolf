//
//  AddNoteViewController.h
//  UITextView
//
//  Created by Ellen Miner on 3/7/09.
//  Copyright 2009 RaddOnline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextViewCell.h"
#import "Card.h"


@interface AddNoteViewController : UITableViewController <UITextViewDelegate> {
	IBOutlet UITableView *tbView;
	NSString *aNote;
    Card *card;
}
@property (nonatomic, retain) NSString *aNote;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil card:(Card *)userCard;
- (void)save:(id)sender;

@end
