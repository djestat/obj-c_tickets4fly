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

#import "Ticket.h"

@interface FavoritesController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UISegmentedControl* segmentedControl;
@property (nonatomic, strong) NSMutableArray<Ticket *>* tickets;
@property (strong, nonatomic) UITableView* tableView;

@property (nonatomic, weak, readwrite) DataBaseManager* dataBaseManager;

@end

@implementation FavoritesController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

    [self sortingSegmentControl];

}

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
    _tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
     
    [self.view addSubview: _tableView];
    
    [self addSubviews];
}

#pragma mark - Subviews

-(void) addSubviews {
    [self addHeader];
}

-(void) addHeader {

    CGFloat statusBarSize = UIApplication.sharedApplication.statusBarFrame.size.height;    
    CGFloat headerHeight = statusBarSize + 44;

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
    NSLog(@"numberOfRowsInSection %ld", self.tickets.count);
    return self.tickets.count;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 140;
}

#pragma mark - Notification

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSString* route = @"Your ticket with row %ld", indexPath.row;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd MMMM yyyy hh:mm";
    
    Ticket* ticket = self.tickets[indexPath.row];
        
    NSString *title = [NSString stringWithFormat: @"Your fly №%@: %@ - %@", ticket.flightNumber, ticket.from, ticket.to];
    NSString *body = [dateFormatter stringFromDate: ticket.departure];

    NSTimeInterval time = 5;
    
    
    
    NSString* message = [NSString stringWithFormat: @"Do you want add notification info: %@ - %@ price: %@ ", ticket.from, ticket.to, ticket.price];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Send notification?" message: message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //button click event
        NSLog(@"YES Add");
        [[LocalNotificationManager shared] requestPermissionsWithText: title sendBody: body after: time];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    
    NSLog(@"Don't touch me");
}



@end
