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

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)configureView
{
    if (self.detailItem) {
        self.title = [self.detailItem description];
    }
    
    NSString *averagePlistPath = [[NSBundle mainBundle] pathForResource:@"average" ofType:@"plist"];
    averageDictionary = [NSDictionary dictionaryWithContentsOfFile:averagePlistPath];
    
    NSString *bestPlistPath = [[NSBundle mainBundle] pathForResource:@"best" ofType:@"plist"];
    bestDictionary = [NSDictionary dictionaryWithContentsOfFile:bestPlistPath];
    
    NSString *worstPlistPath = [[NSBundle mainBundle] pathForResource:@"worst" ofType:@"plist"];
    worstDictionary = [NSDictionary dictionaryWithContentsOfFile:worstPlistPath];
    
    NSString *spacePlistPath = [[NSBundle mainBundle] pathForResource:@"space" ofType:@"plist"];
    spaceDictionary = [NSDictionary dictionaryWithContentsOfFile:spacePlistPath];
    
    NSString *descriptionPlistPath = [[NSBundle mainBundle] pathForResource:@"description" ofType:@"plist"];
    descriptionDictionary = [NSDictionary dictionaryWithContentsOfFile:descriptionPlistPath];
    
    runtimeText = [[UITextView alloc] initWithFrame:CGRectMake(0, 140, 320, 50)];
    [runtimeText setBackgroundColor:[UIColor clearColor]];
    [runtimeText setFont:[UIFont boldSystemFontOfSize:75]];
    runtimeText.editable = NO;
    runtimeText.scrollEnabled = NO;
    runtimeText.allowsEditingTextAttributes = NO;
    runtimeText.text = [averageDictionary objectForKey:[self.detailItem description]];
    runtimeText.hidden = true;
    runtimeText.textAlignment = NSTextAlignmentCenter;
    [[self view] addSubview:runtimeText];
    
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
    
    CGRect runtimeFrame = runtimeText.frame;
    runtimeFrame.size.height = runtimeText.contentSize.height;
    runtimeFrame.size.width = runtimeText.contentSize.width;
    runtimeText.frame = runtimeFrame;
    
    CGRect descriptionFrame = descriptionText.frame;
    descriptionFrame.size.height = descriptionText.contentSize.height;
    descriptionFrame.size.width = descriptionText.contentSize.width;
    descriptionText.frame = descriptionFrame;}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    self.hidesBottomBarWhenPushed = NO;
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
    self.masterPopoverController = popoverController;
}

// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController:(UISplitViewController *)splitController willShowViewController
                           :(UIViewController *)viewController invalidatingBarButtonItem
                           :(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}


- (IBAction)changeRuntime:(id)sender
{
    runtimeText.hidden = false;
    if (((UISegmentedControl *)sender).selectedSegmentIndex == 0){
        runtimeText.text = [bestDictionary objectForKey:[self.detailItem description]];
    } else if (((UISegmentedControl *)sender).selectedSegmentIndex == 1){
        runtimeText.text = [averageDictionary objectForKey:[self.detailItem description]];
    } else if (((UISegmentedControl *)sender).selectedSegmentIndex == 2){
        runtimeText.text = [worstDictionary objectForKey:[self.detailItem description]];
    } else {
        runtimeText.text = [spaceDictionary objectForKey:[self.detailItem description]];
    }
}
@end
