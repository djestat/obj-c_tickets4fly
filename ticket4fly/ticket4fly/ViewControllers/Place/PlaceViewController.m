//
//  PlaceViewController.m
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "PlaceViewController.h"
#import "TableControllerView.h"
#import "DataManager.h"
#import "PlaceCellModel.h"


@interface PlaceViewController ()

@property (nonatomic, weak, readwrite) DataManager* dataManager;
@property (nonatomic, weak) TableControllerView* tableControllerView;

@end

@implementation PlaceViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    switch (self.reason) {
        case PlaceReasonFrom:
            self.title = @"From 🛫";
            break;
        case PlaceReasonTo:
            self.title = @"To 🛬";
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataManager = [DataManager shared];
}

#pragma mark - ReloadData

- (void) reloadData {
    NSMutableArray<CellModel*>* cellModels = [NSMutableArray new];
    
    for (Airport* airport in self.dataManager.airports) {
        PlaceCellModel* placeCellModel = [PlaceCellModel createWithAirport: airport];
        [cellModels addObject: placeCellModel];
    }
    
    for (City* city in self.dataManager.cities) {
        PlaceCellModel* placeCellModel = [PlaceCellModel createWithCity: city];
        [cellModels addObject: placeCellModel];
    }
    
    [self.tableControllerView reload: cellModels];
}

#pragma mark - Layout

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableControllerView.frame = self.view.bounds;
}

#pragma mark - Subviews

- (void) addSubviews {
    [super addSubviews];
    [self addTableControllerView];
}

- (void) addTableControllerView {
    if (nil != self.tableControllerView) {
        return;
    }
    
    TableControllerView* tableControllerView = [TableControllerView new];
    [self.view addSubview: tableControllerView];
    self.tableControllerView = tableControllerView;
}

#pragma mark - Notifications

- (void) addNotifications {
    [super addNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(didReceiveCities)
                                                 name: [self.dataManager didLoadCitiesNotificationName]
                                               object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(didReceiveAirports)
                                                 name: [self.dataManager didLoadAirportsNotificationName]
                                               object: nil];
}

- (void) removeNotifications {
    [super removeNotifications];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: [self.dataManager didLoadCitiesNotificationName]
                                                  object: nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: [self.dataManager didLoadAirportsNotificationName]
                                                  object: nil];
}

- (void) didReceiveCities {
    //NSLog(@"%@", [NSThread callStackSymbols]);
    
    //NSLog(@"didReceiveCities %@", self.dataManager.cities);
    [self reloadData];
}

- (void) didReceiveAirports {
    //NSLog(@"%@", [NSThread callStackSymbols]);
    
    //    NSLog(@"didReceiveAirports %@", self.dataManager.airports);
    [self reloadData];
}

@end
