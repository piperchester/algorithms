//
//  SearchDetailViewController.h
//  algorithms
//
//  Created by Piper Chester on 7/7/13.
//  Copyright (c) 2013 Piper Chester. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchDetailViewController : UIViewController<UISplitViewControllerDelegate> {
    UITextView* runtimeText;
    UITextView* descriptionText;
    NSDictionary* averageDictionary;
    NSDictionary* bestDictionary;
    NSDictionary* worstDictionary;
    NSDictionary* spaceDictionary;
    NSDictionary* descriptionDictionary;
}

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
- (IBAction)changeRuntime:(id)sender;

@end
