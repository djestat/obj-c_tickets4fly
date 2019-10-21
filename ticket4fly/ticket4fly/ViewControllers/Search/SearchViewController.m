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
#import "Ticket.h"

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
#warning delegate cell
        cellModel.delegate = self;
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


#warning принял из ячейки билет
- (void)didSelectTicket:(nonnull Ticket *)ticket {
    NSLog(@"didSelectTicket s vc %@", ticket.price);
    
    NSString* message = [NSString stringWithFormat: @"Do you want add to favorites ticket: %@ - %@ price: %@ ", ticket.from, ticket.to, ticket.price];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add to favorites?" message: message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //button click event
        NSLog(@"YES Add");
        [[DataBaseManager shared] saveTickets: ticket];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
