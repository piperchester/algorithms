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

- (NSString *)configurePath:(NSString *)filename
{
    NSString *pathString = [NSString new];
    return pathString = [[NSBundle mainBundle]pathForResource:filename ofType:@"plist"];
}

- (void)configureView
{
    if (self.detailItem) {
        self.title = [self.detailItem description];
    }
    
    runtimeText = [[UITextView alloc] initWithFrame:CGRectMake(0, 140, 320, 50)];
    [runtimeText setBackgroundColor:[UIColor clearColor]];
    [runtimeText setFont:[UIFont boldSystemFontOfSize:75]];
    runtimeText.userInteractionEnabled = NO;
    runtimeText.text = [averageDictionary objectForKey:[self.detailItem description]];
    runtimeText.hidden = YES;
    runtimeText.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:runtimeText];
    
    descriptionText = [[UITextView alloc] initWithFrame:CGRectMake(0, 20, 320, 50)];
    descriptionText.backgroundColor = [UIColor clearColor];
    descriptionText.font = [UIFont systemFontOfSize:20];
    descriptionText.userInteractionEnabled = NO;
    descriptionText.text = [descriptionDictionary objectForKey:[self.detailItem description]];
    descriptionText.hidden = NO;
    descriptionText.textAlignment = NSTextAlignmentCenter;
    descriptionText.text = [descriptionDictionary objectForKey:[self.detailItem description]];
    [self.view addSubview:descriptionText];
    
    CGRect runtimeFrame = runtimeText.frame;
    runtimeFrame.size.height = runtimeText.contentSize.height;
    runtimeFrame.size.width = runtimeText.contentSize.width;
    runtimeText.frame = runtimeFrame;
    
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
    
    averageDictionary = [NSDictionary dictionaryWithContentsOfFile:[self configurePath:@"average"]];
    bestDictionary = [NSDictionary dictionaryWithContentsOfFile:[self configurePath:@"best"]];
    worstDictionary = [NSDictionary dictionaryWithContentsOfFile:[self configurePath:@"worst"]];
    spaceDictionary = [NSDictionary dictionaryWithContentsOfFile:[self configurePath:@"space"]];
    descriptionDictionary = [NSDictionary dictionaryWithContentsOfFile:[self configurePath:@"description"]];
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
    runtimeText.hidden = NO;
    
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:
            runtimeText.text = [bestDictionary objectForKey:[self.detailItem description]];
            break;
        case 1:
            runtimeText.text = [averageDictionary objectForKey:[self.detailItem description]];
            break;
        case 2:
            runtimeText.text = [worstDictionary objectForKey:[self.detailItem description]];
            break;
        default:
            runtimeText.text = [spaceDictionary objectForKey:[self.detailItem description]];
            break;
    }
}
@end
