//
//  MainViewController.m
//  ticket4fly
//
//  Created by Igor on 11/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "MainViewController.h"
#import "SettingsViewController.h"
#import "DataManager.h"
#import "TravelDirectionsView.h"


@interface MainViewController () <TravelDirectionsViewDelegate>

@property (nonatomic, weak, readwrite) DataManager* dataManager;
@property (nonatomic, weak, readwrite) UIBarButtonItem* settingsButton;
@property (nonatomic, weak, readwrite) TravelDirectionsView* travelDirectionsView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle: @"Search tickets!"];
    
    self.dataManager = [DataManager shared];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self.dataManager loadData];
}

#pragma mark - Layout

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    BaseTheme* activeTheme = [ThemeManager.shared activeTheme];
    CGSize travelDirectionsViewSize = [activeTheme travelDirectionsViewSize];
    CGFloat travelDirectionsViewX = (width - travelDirectionsViewSize.width) / 2;
    CGFloat travelDirectionsViewY = (height - travelDirectionsViewSize.height) / 3;
    self.travelDirectionsView.frame = CGRectMake(travelDirectionsViewX, travelDirectionsViewY, travelDirectionsViewSize.width, travelDirectionsViewSize.height);
            

}

#pragma mark - Subviews

- (void) addSubviews {
    [super addSubviews];
    
    [self addSettingsButton];
    
    [self addTravelDirectionsView];
    
}

- (void) addTravelDirectionsView {
    if (nil != self.travelDirectionsView) {
        return;
    }
    
    TravelDirectionsView* view = [TravelDirectionsView new];
    [self.view addSubview: view];
    self.travelDirectionsView = view;
    
    view.delegate = self;
}


- (void) addSettingsButton {
    if (nil != self.settingsButton) {
        return;
    }
    
    UIBarButtonItem* settingsButton = [[UIBarButtonItem alloc] initWithTitle: @"Settings"
                                                                       style: UIBarButtonItemStyleDone
                                                                      target: self
                                                                      action: @selector(openSettings)];
    
    self.navigationItem.rightBarButtonItem = settingsButton;
    self.settingsButton = settingsButton;
}

#pragma mark - TravelDirectionsView


- (void) fromButtonAction {
    [self openPlaceViewControllerWith: PlaceReasonFrom];
}

- (void) toButtonAction {
    [self openPlaceViewControllerWith: PlaceReasonTo];
}

- (void) departureDate {
    NSLog(@"flyDate");
}

- (void) arrivalDate {
    NSLog(@"comebackDate");
}

- (void) searchButtonAction {
    NSLog(@"searchButtonAction");
}


#pragma mark - Actions

- (void) openSettings {
    SettingsViewController* settingsViewController = [SettingsViewController new];
    [self.navigationController pushViewController: settingsViewController animated: YES];
}

#pragma mark - Notifications

- (void) addNotifications {
    [super addNotifications];
    
    NSLog(@"MainViewController addNotifications");
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(didReceiveCountries)
                                                 name: [self.dataManager didLoadCountriesNotificationName]
                                               object: nil];
    
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
                                                    name: [self.dataManager didLoadCountriesNotificationName]
                                                  object: nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: [self.dataManager didLoadCitiesNotificationName]
                                                  object: nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: [self.dataManager didLoadAirportsNotificationName]
                                                  object: nil];
}

- (void) didReceiveCountries {
    //NSLog(@"%@", [NSThread callStackSymbols]);
    
//    NSLog(@"didReceiveCountries %@", self.dataManager.countries);
}

- (void) didReceiveCities {
    //NSLog(@"%@", [NSThread callStackSymbols]);
    
//    NSLog(@"didReceiveCities %@", self.dataManager.cities);
}

- (void) didReceiveAirports {
    //NSLog(@"%@", [NSThread callStackSymbols]);
    
//    NSLog(@"didReceiveAirports %@", self.dataManager.airports);
}

@end
