//
//  FavoritesController.m
//  ticket4fly
//
//  Created by Igor on 29/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "FavoritesController.h"
#import "FavoriteTicketCell.h"


@interface FavoritesController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray* ticketsCollection;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FavoriteTicketCell *cell;


@end

@implementation FavoritesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Favorites";
    
    _tableView = [[UITableView alloc] initWithFrame: self.view.frame];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    
    [self.view addSubview: self.tableView];

    // Register Cell
//    [_tableView registerClass: [FavoriteTicketCell class] forCellReuseIdentifier: @"ReuseIdentifier"];
    NSString* baseCellID = NSStringFromClass([FavoriteTicketCell class]);
    [self.tableView registerClass: [FavoriteTicketCell class] forCellReuseIdentifier: baseCellID];
    
}

#pragma mark - Subviews


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableViewDelegate



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ticketsCollection.count + 5;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSString* baseCellID = NSStringFromClass([FavoriteTicketCell class]);
    [self.tableView registerClass: [FavoriteTicketCell class] forCellReuseIdentifier: baseCellID];
    FavoriteTicketCell* cell = [[tableView dequeueReusableCellWithIdentifier: baseCellID forIndexPath: indexPath] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: baseCellID];
    
    cell.textLabel.text = @"From _ - To _";
    cell.detailTextLabel.text = @"Date: ";
    cell.imageView.frame = CGRectMake(5, 5, 40, 40);
    cell.imageView.image = [UIImage imageNamed:@"logo-objectiveC"];
    
    return cell;
}

@end
