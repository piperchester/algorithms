//
//  SearchMasterViewController.m
//  algorithms
//
//  Created by Piper Chester on 7/7/13.
//  Copyright (c) 2013 Piper Chester. All rights reserved.
//

#import "SearchDetailViewController.h"

@interface SearchMasterViewController ()

@end

@implementation SearchMasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *sortsPlistPath = [[NSBundle mainBundle] pathForResource:@"searches" ofType:@"plist"];
    NSArray *sortsArray = [NSArray arrayWithContentsOfFile:sortsPlistPath];
    
    if (!searches) {
        searches = [[NSMutableArray alloc] init];
        for (int i = 0; i < sortsArray.count; i++){
            [searches insertObject:sortsArray[i] atIndex:i];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return searches.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDate *object = searches[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle
                 :(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath
                 :(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [searches removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath
                 :(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = searches[indexPath.row];
        _searchDetailViewController.detailItem = object;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showSearchDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = searches[indexPath.row];
        [[segue destinationViewController] setDetailItem:object]; // Displays the next menu
    }
}

@end
