//
//  FavoritesController.m
//  ticket4fly
//
//  Created by Igor on 29/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "FavoritesController.h"
#import "FavoriteTicketCell.h"

#import "LocalNotificationManager.h"

#import "DataBaseManager.h"

@interface FavoritesController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UISegmentedControl* segmentedControl;
@property (nonatomic, strong) NSMutableArray<Ticket *>* tickets;
@property (strong, nonatomic) UITableView* tableView;

@property (nonatomic, weak, readwrite) DataBaseManager* dataBaseManager;

@end

@implementation FavoritesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Favorites";
    
    self.dataBaseManager = [DataBaseManager shared];
    
    _tableView = [UITableView new];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    NSString* favoriteTicketCellID = NSStringFromClass([FavoriteTicketCell class]);
    [self.tableView registerClass: [FavoriteTicketCell class] forCellReuseIdentifier: favoriteTicketCellID];
     
    [self.view addSubview: _tableView];
    
    [self addSubviews];
    
    [self sortingSegmentControl];
}

#pragma mark - Subviews

-(void) addSubviews {
    [self addHeader];
}

-(void) addHeader {

    CGFloat headerHeight = 90;
        
    UIView* headerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, headerHeight)];
    headerView.backgroundColor = [UIColor systemGreenColor];
    [self.view addSubview: headerView];

    _tableView.contentInset = UIEdgeInsetsMake(headerHeight / 2, 0, 0, 0);
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"All", @"Searched", @"MAP", nil]];
    CGFloat segmentedControlWidth = 240;
    CGFloat segmentedControlHeight = 30;
    CGFloat segmentedControlX = (self.view.frame.size.width - segmentedControlWidth) / 2;
    CGFloat segmentedControlY = headerHeight - segmentedControlHeight * 1.25;

    _segmentedControl.frame = CGRectMake(segmentedControlX, segmentedControlY, segmentedControlWidth, segmentedControlHeight);
    _segmentedControl.selectedSegmentIndex = 0;
    [_segmentedControl addTarget:self action:@selector(sortingSegmentControl) forControlEvents: UIControlEventValueChanged];
    [headerView addSubview: _segmentedControl];
}

#pragma mark - Segment controller

#warning segment controller sort All/Search/Map
-(void) sortingSegmentControl {
    
    NSString* text = NULL;
    
    switch (_segmentedControl.selectedSegmentIndex) {
        case 1:{
            NSLog(@"Filter by search");
            text = @"search";
            [self.dataBaseManager loadFavoritesTickets: text completiom:^(NSArray<Ticket *> * tickets) {
                self.tickets = [NSMutableArray arrayWithArray: tickets];
                NSLog(@"Filter by search Tickets count %ld", tickets.count);
                [self.tableView reloadData];
            }];
            break;
        }
        case 2: {
            NSLog(@"Filter by map");
            text = @"map";
            [self.dataBaseManager loadFavoritesTickets: text completiom:^(NSArray<Ticket *> * tickets) {
                self.tickets = [NSMutableArray arrayWithArray: tickets];
                NSLog(@"Filter by map Tickets count %ld", tickets.count);
                [self.tableView reloadData];
            }];
            
            break;
            
        }
        default: {
            NSLog(@"Not filtered");
            [self.dataBaseManager loadFavoritesTickets: text completiom:^(NSArray<Ticket *> * tickets) {
                self.tickets = [NSMutableArray arrayWithArray: tickets];
                NSLog(@"Not filtered Tickets count %ld", tickets.count);
                [self.tableView reloadData];
            }];
            break;
        }
    }

}


#pragma mark - Table View Data Source

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld", self.tickets.count);
    return self.tickets.count + 5;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSString* favoriteTicketCellID = NSStringFromClass([FavoriteTicketCell class]);
    
    // Configure the cell
    FavoriteTicketCell* cell = [tableView dequeueReusableCellWithIdentifier: favoriteTicketCellID forIndexPath: indexPath];
//    cell.layer.cornerRadius = 10;
//    cell.backgroundColor = [UIColor lightGrayColor];
    tableView.separatorColor = [UIColor clearColor];
    
    [cell configureWith: _tickets[indexPath.row]];

    return cell;
}


#pragma mark - Notification

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSString* route = @"Your ticket with row %ld", indexPath.row;
    NSString *text = [NSString stringWithFormat: @"Your ticket with row %ld", indexPath.row];
    NSTimeInterval time = 5;
    
    [[LocalNotificationManager shared] requestPermissionsWithText: text after: time];
    
    NSLog(@"Don't touch me");
}



@end
