//
//  DetailViewController.m
//  algorithms
//
//  Created by Piper Chester on 4/21/13.
//  Copyright (c) 2013 Piper Chester. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController{
    UITextView* averageText;
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

/**
 * Updates the user interface for the detail item.
 */
- (void)configureView
{
    if (self.detailItem) {
        self.title = [self.detailItem description];
    }
    
    averageText = [[UITextView alloc] initWithFrame:CGRectMake(100, 165, 140, 50)];
    [averageText setBackgroundColor:[UIColor clearColor]];
    [averageText setFont:[UIFont boldSystemFontOfSize:60]];
    averageText.editable = NO;
    averageText.scrollEnabled = NO;
    averageText.allowsEditingTextAttributes = NO;
    
    NSString *averagePlistPath = [[NSBundle mainBundle] pathForResource:@"average" ofType:@"plist"];
    NSDictionary *averageDictionary = [NSDictionary dictionaryWithContentsOfFile:averagePlistPath];
    averageText.text = [averageDictionary objectForKey:@"bubble"];
    [[self view] addSubview:averageText];
    
    CGRect frame = averageText.frame;
    frame.size.height = averageText.contentSize.height;
    frame.size.width = averageText.contentSize.width;
    averageText.frame = frame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"algorithms", @"algorithms");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
