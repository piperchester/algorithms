//
//  SearchDetailViewController.h
//  algorithms
//
//  Created by Piper Chester on 7/7/13.
//  Copyright (c) 2013 Piper Chester. All rights reserved.
//

#import "SearchMasterViewController.h"
#import <UIKit/UIKit.h>

@interface SearchDetailViewController : UIViewController<UISplitViewControllerDelegate> {
    UITextView  *descriptionText;
    NSDictionary *descriptionDictionary;
}

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *searchImageView;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end
