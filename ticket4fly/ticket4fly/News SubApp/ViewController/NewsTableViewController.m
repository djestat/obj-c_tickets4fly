//
//  NewsTableViewController.m
//  ticket4fly
//
//  Created by Igor on 17/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsCell.h"
#import "NetworkingService.h"
#import "News.h"

@interface NewsTableViewController ()

@property (nonatomic, strong) NSArray<News *> *newsArray;
@property (nonatomic, strong) NetworkingService* networkingService;

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"News";
    [self.tableView registerClass:[NewsCell class] forCellReuseIdentifier:@"NewsCell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    __weak typeof(self) weakSelf = self;
    [self.networkingService getNews:^(NSArray<News *> * _Nonnull newsArray) {
        weakSelf.newsArray = newsArray;
        [self.tableView reloadData];
    }];
}

- (NetworkingService *)networkingService {
    if (nil == _networkingService) {
        _networkingService = [NetworkingService new];
    }
    return _networkingService;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return _newsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    NewsCell* cell = [tableView dequeueReusableCellWithIdentifier: @"NewsCell" forIndexPath: indexPath];
    
    cell = [cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier: @"NewsCell"];

    cell.textLabel.text = [_newsArray objectAtIndex:indexPath.row].name;
    cell.detailTextLabel.text = [_newsArray objectAtIndex:indexPath.row].title;
    
    NSString* strPath = [_newsArray objectAtIndex:indexPath.row].urlToImage;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strPath]]];
        cell.imageView.image = img;
    });
    cell.imageView.frame = CGRectMake(0, 0, 70, 70);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


@end
