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
    UITextView* bestText;
    UITextView* worstText;
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
    
    NSString *averagePlistPath = [[NSBundle mainBundle] pathForResource:@"average" ofType:@"plist"];
    NSDictionary *averageDictionary = [NSDictionary dictionaryWithContentsOfFile:averagePlistPath];
    
    NSString *bestPlistPath = [[NSBundle mainBundle] pathForResource:@"best" ofType:@"plist"];
    NSDictionary *bestDictionary = [NSDictionary dictionaryWithContentsOfFile:bestPlistPath];
    
    NSString *worstPlistPath = [[NSBundle mainBundle] pathForResource:@"worst" ofType:@"plist"];
    NSDictionary *worstDictionary = [NSDictionary dictionaryWithContentsOfFile:worstPlistPath];
    
   
    bestText = [[UITextView alloc] initWithFrame:CGRectMake(10, 50, 350, 50)];
    [bestText setBackgroundColor:[UIColor clearColor]];
    [bestText setFont:[UIFont boldSystemFontOfSize:55]];
    bestText.editable = NO;
    bestText.scrollEnabled = NO;
    bestText.allowsEditingTextAttributes = NO;
    bestText.text = [bestDictionary objectForKey:[self.detailItem description]];
    [[self view] addSubview:bestText];
    
    
    averageText = [[UITextView alloc] initWithFrame:CGRectMake(10, 165, 350, 50)];
    [averageText setBackgroundColor:[UIColor clearColor]];
    [averageText setFont:[UIFont boldSystemFontOfSize:55]];
    averageText.editable = NO;
    averageText.scrollEnabled = NO;
    averageText.allowsEditingTextAttributes = NO;
    averageText.text = [averageDictionary objectForKey:[self.detailItem description]];
    [[self view] addSubview:averageText];
    
    worstText = [[UITextView alloc] initWithFrame:CGRectMake(10, 300, 350, 0)];
    [worstText setBackgroundColor:[UIColor clearColor]];
    [worstText setFont:[UIFont boldSystemFontOfSize:55]];
    worstText.editable = NO;
    worstText.scrollEnabled = NO;
    worstText.allowsEditingTextAttributes = NO;
    worstText.text = [worstDictionary objectForKey:[self.detailItem description]];
    [[self view] addSubview:worstText];
    
    CGRect frame = bestText.frame;
    frame.size.height = bestText.contentSize.height;
    frame.size.width = bestText.contentSize.width;
    bestText.frame = frame;
    
    frame = averageText.frame;
    frame.size.height = averageText.contentSize.height;
    frame.size.width = averageText.contentSize.width;
    averageText.frame = frame;
    
    
    frame = worstText.frame;
    frame.size.height = worstText.contentSize.height;
    frame.size.width = worstText.contentSize.width;
    worstText.frame = frame;
    

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
