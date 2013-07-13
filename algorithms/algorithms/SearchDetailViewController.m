//
//  SearchDetailViewController.m
//  algorithms
//
//  Created by Piper Chester on 7/7/13.
//  Copyright (c) 2013 Piper Chester. All rights reserved.
//

#import "SearchDetailViewController.h"

@interface SearchDetailViewController ()

@end

@implementation SearchDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self configureView];
    }
    
    if (_masterPopoverController != nil) {
        [_masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)configureView
{
    if (_detailItem) {
        self.title = [_detailItem description];
    }
    
    NSString *descriptionPlistPath = [[NSBundle mainBundle] pathForResource:@"description" ofType:@"plist"];
    descriptionDictionary = [NSDictionary dictionaryWithContentsOfFile:descriptionPlistPath];
    
    descriptionText = [[UITextView alloc] initWithFrame:CGRectMake(0, 20, 320, 50)];
    [descriptionText setBackgroundColor:[UIColor clearColor]];
    [descriptionText setFont:[UIFont systemFontOfSize:20]];
    descriptionText.editable = NO;
    descriptionText.scrollEnabled = NO;
    descriptionText.allowsEditingTextAttributes = NO;
    descriptionText.text = [descriptionDictionary objectForKey:[self.detailItem description]];
    descriptionText.hidden = false;
    descriptionText.textAlignment = NSTextAlignmentCenter;
    descriptionText.text = [descriptionDictionary objectForKey:[self.detailItem description]];
    [[self view] addSubview:descriptionText];
    
    CGRect descriptionFrame = descriptionText.frame;
    descriptionFrame.size.height = descriptionText.contentSize.height;
    descriptionFrame.size.width = descriptionText.contentSize.width;
    descriptionText.frame = descriptionFrame;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    
    [super setHidesBottomBarWhenPushed:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController
                           :(UIViewController *)viewController withBarButtonItem
                           :(UIBarButtonItem *)barButtonItem forPopoverController
                           :(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"algorithms", @"algorithms");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    _masterPopoverController = popoverController;
}

// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController:(UISplitViewController *)splitController willShowViewController
                           :(UIViewController *)viewController invalidatingBarButtonItem
                           :(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
