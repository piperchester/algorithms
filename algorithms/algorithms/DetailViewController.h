//
//  DetailViewController.h
//  algorithms
//
//  Created by Piper Chester on 4/21/13.
//  Copyright (c) 2013 Piper Chester. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate> {
    UITextView *runtimeText, *descriptionText;
    NSDictionary *averageDictionary, *bestDictionary, *worstDictionary, *spaceDictionary, *descriptionDictionary;
}

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
- (IBAction)changeRuntime:(id)sender;

@end
