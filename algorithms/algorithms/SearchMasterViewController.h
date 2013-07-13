//
//  SearchMasterViewController.h
//  algorithms
//
//  Created by Piper Chester on 7/7/13.
//  Copyright (c) 2013 Piper Chester. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchDetailViewController; // Used to break circular depedencies. 

@interface SearchMasterViewController : UITableViewController {
    NSMutableArray *searches;
}

@property (strong, nonatomic) SearchDetailViewController *searchDetailViewController;

@end
