//
//  SearchViewController.m
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "SearchViewController.h"
#import "ApiManager.h"

#import "Route.h"
#import "RouteCellModel.h"

#import "DataBaseManager.h"

#import "TableControllerView.h"

@interface SearchViewController () <RouteCellModelDelegate>

@property (nonatomic, strong) APIManager* apiManager;

@property (nonatomic, weak, readwrite) DataBaseManager* dataBaseManager;

@property (nonatomic, weak) TableControllerView* tableControllerView;

@end

@implementation SearchViewController

- (APIManager *)apiManager {
    if (nil == _apiManager) {
        _apiManager = [APIManager new];
    }
    return _apiManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Search";

    __weak typeof(self) weakSelf = self;
    [self.apiManager getTicketsFrom: self.fromIATA to: self.toIATA completion:^(NSArray<Route *> * _Nonnull routes) {
        [weakSelf reloadWith: routes];
    }];
    
    self.dataBaseManager = [DataBaseManager shared];
    
}


#pragma mark - Reload Data

- (void) reloadWith: (NSArray<Route *> * _Nonnull) routes {
    NSMutableArray<CellModel*>* cellModels = [NSMutableArray new];
    
    for (Route* route in routes) {
        RouteCellModel* cellModel = [RouteCellModel createWith: route];
        [cellModels addObject: cellModel];
    }
    
    NSLog(@"Tikets count is %ld", cellModels.count);
    
    if (cellModels.count > 0) {
        [self.tableControllerView reload: cellModels];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Увы!" message:@"По данному направлению билетов не найдено" preferredStyle: UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Закрыть" style:(UIAlertActionStyleDefault) handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }

}

#pragma mark - Layout

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableControllerView.frame = self.view.bounds;
}

#pragma mark - Subview

- (void)addSubviews {
    [super addSubviews];
    [self addTableControllerView];
}

- (void)addTableControllerView {
    if (nil != self.tableControllerView) {
        return;
    }
    
    TableControllerView* tableControllerView = [TableControllerView new];
    [self.view addSubview: tableControllerView];
    self.tableControllerView = tableControllerView;
}

#pragma mark - RouteCellModelDelegate

/*- (void)didSelectTicket:(nonnull Ticket *)ticket {
    NSLog(@"didSelectRoute s vc %@", ticket);
//    [self.delegate didSelectTicket: ticket];
}*/

- (void)didSelectTicket:(nonnull Ticket *)ticket {
    [self.delegate saveToDataBase: ticket];
    NSLog(@"didSelectTicket s vc %@", ticket);
}

- (void)saveToDataBase:(nonnull Ticket *)ticket {
    NSLog(@"saveToDataBase s vc %@", ticket);
    
//    NSMutableArray<Ticket*>* tickets = [NSMutableArray new];
//    [tickets addObject: ticket];
//    
//    [self.dataBaseManager saveTickets: tickets];
}


@end
