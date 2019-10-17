//
//  PlaceViewController.m
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "PlaceViewController.h"
#import "TableControllerView.h"
#import "SegmentedControl.h"

#import "DataManager.h"
#import "DataBaseManager.h"

#import "PlaceCellModel.h"


@interface PlaceViewController ()  <PlaceCellModelDelegate, UISearchControllerDelegate, UISearchBarDelegate>

@property (nonatomic, weak, readwrite) DataManager* dataManager;
@property (nonatomic, weak, readwrite) DataBaseManager* dataBaseManager;

@property (nonatomic, weak) TableControllerView* tableControllerView;
@property (nonatomic, weak) SegmentedControl* placeTypeSegment;

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
    self.dataBaseManager = [DataBaseManager shared];

    [self reloadData];

}

#pragma mark - ReloadData

- (void) reloadData {
    
    NSString* text = self.navigationItem.searchController.searchBar.text;
    /*
    [self.dataBaseManager loadCitiesWithQuery: text completiom:^(NSArray<City *> * cities) {
        NSMutableArray<CellModel*>* cellModels = [NSMutableArray new];
        for (City* city in cities) {
            PlaceCellModel* placeCellModel = [PlaceCellModel createWithCity: city];
            placeCellModel.delegate = self;
            [cellModels addObject: placeCellModel];
        }
        [self.tableControllerView reload: cellModels];
    }];*/
    
    ////New Realisation
    
    switch (self.placeTypeSegment.selectedSegmentIndex) {
        case 0: {
            [self.dataBaseManager loadCitiesWithQuery: text completiom:^(NSArray<City *> * cities) {
                NSMutableArray<CellModel*>* cellModels = [NSMutableArray new];
                for (City* city in cities) {
                    PlaceCellModel* placeCellModel = [PlaceCellModel createWithCity: city];
                    placeCellModel.delegate = self;
                    [cellModels addObject: placeCellModel];
                }
                [self.tableControllerView reload: cellModels];
            }];
            break;
        }
        case 1: {
            [self.dataBaseManager loadAirportsWithQuery: text completiom:^(NSArray<Airport *> * airports) {
                NSMutableArray<CellModel*>* cellModels = [NSMutableArray new];
                for (Airport* airport in airports) {
                    PlaceCellModel* placeCellModel = [PlaceCellModel createWithAirport: airport];
                    placeCellModel.delegate = self;
                    [cellModels addObject: placeCellModel];
                }
                [self.tableControllerView reload: cellModels];
            }];
            break;
        }
    }
}

- (void) _reloadData {
    NSMutableArray<CellModel*>* cellModels = [NSMutableArray new];

    switch (self.placeTypeSegment.selectedSegmentIndex) {
        case 0:
            for (City* city in self.dataManager.cities) {
                PlaceCellModel* placeCellModel = [PlaceCellModel createWithCity: city];
                placeCellModel.delegate = self;
                [cellModels addObject: placeCellModel];
            }
            break;
            
        case 1:
            for (Airport* airport in self.dataManager.airports) {
                PlaceCellModel* placeCellModel = [PlaceCellModel createWithAirport: airport];
                placeCellModel.delegate = self;
                [cellModels addObject: placeCellModel];
            }
            break;
    }
    
    NSString* text = self.navigationItem.searchController.searchBar.text;
    if (nil == text || text.length <= 0) {
        [self.tableControllerView reload: cellModels];
    } else {
        NSMutableArray<CellModel*>* filteredCellModels = [NSMutableArray new];
        
        for (CellModel* cellModel in cellModels) {
            PlaceCellModel* placeCellModel = (PlaceCellModel*) cellModel;
            if (NO == [placeCellModel isKindOfClass: [PlaceCellModel class]]) { continue; }
            if (NO == [[placeCellModel placeName] containsString: text]) { continue; }
            [filteredCellModels addObject: cellModel];
        }
        
        [self.tableControllerView reload: filteredCellModels];
    }
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
    
    [self addPlaceTypeSegment];
    
    UISearchController* searchController = [[UISearchController alloc] initWithSearchResultsController: nil];
    searchController.obscuresBackgroundDuringPresentation = NO;
    searchController.searchBar.delegate = self;
    
    self.navigationItem.searchController = searchController;
}

- (void) addTableControllerView {
    if (nil != self.tableControllerView) {
        return;
    }
    
    TableControllerView* tableControllerView = [TableControllerView new];
    [self.view addSubview: tableControllerView];
    self.tableControllerView = tableControllerView;
}

- (void) addPlaceTypeSegment {
    if (nil != self.placeTypeSegment) { return; }
    
    SegmentedControl* placeTypeSegment = [[SegmentedControl alloc] initWithFrame: CGRectMake(0, 0, 100, 50)];
    //[self.view addSubview: placeTypeSegment];
    self.placeTypeSegment = placeTypeSegment;
    self.navigationItem.titleView = placeTypeSegment;
    
    
    [placeTypeSegment addTarget: self
                               action: @selector(placeTypeSegmentAction)
                     forControlEvents: UIControlEventValueChanged];
    
    [placeTypeSegment insertSegmentWithTitle: @"Cities" atIndex: 0 animated: NO];
    [placeTypeSegment insertSegmentWithTitle: @"Airports" atIndex: 1 animated: NO];

    placeTypeSegment.selectedSegmentIndex = 0;
}

#pragma mark - Notifications

- (void) didReceiveCities {
    //NSLog(@"%@", [NSThread callStackSymbols]);
    
//    NSLog(@"didReceiveCities %@", self.dataManager.cities);
    [self reloadData];
}

- (void) didReceiveAirports {
    //NSLog(@"%@", [NSThread callStackSymbols]);
    
//        NSLog(@"didReceiveAirports %@", self.dataManager.airports);
    [self reloadData];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self reloadData];
}

#pragma mark - PlaceCellModelDelegate

- (void) didSelectCity: (nonnull City*) city {
    NSLog(@"didSelectCity %@", city);
    [self.delegate didSelectCity: city reason: self.reason];
}

- (void) didSelectAirport: (nonnull Airport*) airport {
    NSLog(@"didSelectAirport %@", airport);
    [self.delegate didSelectAirport: airport reason: self.reason];
}

#pragma mark - Actions

- (void) placeTypeSegmentAction {
    [self reloadData];
}

@end
