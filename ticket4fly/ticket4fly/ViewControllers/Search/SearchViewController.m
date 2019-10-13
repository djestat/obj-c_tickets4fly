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

#import "TableControllerView.h"

@interface SearchViewController ()

@property (nonatomic, strong) APIManager* apiManager;

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
}


#pragma mark - Reload Data

- (void) reloadWith: (NSArray<Route *> * _Nonnull) routes {
    NSMutableArray<CellModel*>* cellModels = [NSMutableArray new];
    
    for (Route* route in routes) {
        RouteCellModel* cellModel = [RouteCellModel createWith: route];
        [cellModels addObject: cellModel];
    }
    
    [self.tableControllerView reload: cellModels];
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

@end
