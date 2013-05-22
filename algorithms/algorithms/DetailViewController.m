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
    UITextView* runtimeText;
    NSDictionary* averageDictionary;
    NSDictionary* bestDictionary;
    NSDictionary* worstDictionary;
    NSDictionary* spaceDictionary;
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
    
    runtimeText = [[UITextView alloc] initWithFrame:CGRectMake(0, 140, 320, 50)];
    [runtimeText setBackgroundColor:[UIColor clearColor]];
   [runtimeText setFont:[UIFont boldSystemFontOfSize:75]];
    runtimeText.textColor = [UIColor colorWithRed:.2 green:.3 blue:0 alpha:1];
    runtimeText.editable = NO;
    runtimeText.scrollEnabled = NO;
    runtimeText.allowsEditingTextAttributes = NO;
    runtimeText.text = [averageDictionary objectForKey:[self.detailItem description]];
    runtimeText.hidden = true;

    runtimeText.textAlignment = NSTextAlignmentCenter;
    [[self view] addSubview:runtimeText];
    
    CGRect frame = runtimeText.frame;
    frame.size.height = runtimeText.contentSize.height;
    frame.size.width = runtimeText.contentSize.width;
    runtimeText.frame = frame;
    
    frame = runtimeText.frame;
    frame.size.height = runtimeText.contentSize.height;
    frame.size.width = runtimeText.contentSize.width;
    runtimeText.frame = frame;
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


- (IBAction)changeRuntime:(id)sender {
    runtimeText.hidden = false;
    if (((UISegmentedControl *)sender).selectedSegmentIndex == 0){
        runtimeText.text = [bestDictionary objectForKey:[self.detailItem description]];
        runtimeText.textColor = [UIColor colorWithRed:.2 green:.4 blue:0 alpha:1];
    }else if (((UISegmentedControl *)sender).selectedSegmentIndex == 1){
        runtimeText.text = [averageDictionary objectForKey:[self.detailItem description]];
        runtimeText.textColor = [UIColor colorWithRed:.4 green:.2 blue:0 alpha:1];
    }else if (((UISegmentedControl *)sender).selectedSegmentIndex == 2){
        runtimeText.text = [worstDictionary objectForKey:[self.detailItem description]];
        runtimeText.textColor = [UIColor colorWithRed:.6 green:0 blue:0 alpha:1];
    }else{
        runtimeText.text = [spaceDictionary objectForKey:[self.detailItem description]];
        runtimeText.textColor = [UIColor colorWithRed:.2 green:.4 blue:0 alpha:1];
    }
}
@end
