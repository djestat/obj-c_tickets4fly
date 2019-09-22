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

#import "NewsButton.h"
#import "NewsTableViewController.h"

#import "MapButton.h"
#import "MapViewController.h"


@interface MainViewController () <TravelDirectionsViewDelegate>

@property (nonatomic, weak, readwrite) DataManager* dataManager;
@property (nonatomic, weak, readwrite) UIBarButtonItem* settingsButton;
@property (nonatomic, weak, readwrite) TravelDirectionsView* travelDirectionsView;

@property (nonatomic, weak, readwrite) NewsButton* newsButton;
@property (nonatomic, weak, readwrite) NewsTableViewController* newsTableViewController;

@property (nonatomic, weak, readwrite) MapButton* mapButton;
@property (nonatomic, weak, readwrite) MapViewController* mapViewController;


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
    CGFloat travelDirectionsViewY = (height - travelDirectionsViewSize.height) / 2;
    self.travelDirectionsView.frame = CGRectMake(travelDirectionsViewX, travelDirectionsViewY, travelDirectionsViewSize.width, travelDirectionsViewSize.height);
    
    //News Button
    CGFloat widthNewsButton = 70;
    CGFloat heightNewsButton = 70;
    CGFloat newsButtonX = ((width - widthNewsButton) / 2);
    CGFloat newsButtonY = (height * 0.1);
    self.newsButton.frame = CGRectMake(newsButtonX - 40, newsButtonY, widthNewsButton, heightNewsButton);
    
    //Map Button
    CGFloat widthMapButton = 70;
    CGFloat heightMapButton = 70;
    CGFloat mapButtonX = ((width - widthMapButton) / 2);
    CGFloat mapButtonY = (height * 0.1);
    self.mapButton.frame = CGRectMake(mapButtonX + 40, mapButtonY, widthMapButton, heightMapButton);
    

}

#pragma mark - Subviews

- (void) addSubviews {
    [super addSubviews];
    
    [self addSettingsButton];
    
    [self addTravelDirectionsView];
    
    //News Button - Custon Work
    [self addNewsButton];
    
    //Map Button - Custon Work
    [self addMapButton];
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

- (void) addNewsButton {
    if (nil != self.newsButton) {
        return;
    }
    
    NewsButton* button = [NewsButton buttonWithType: UIButtonTypeCustom];
    [self.view addSubview: button];
    self.newsButton = button;
    
    [button setTitle: @"" forState: UIControlStateNormal];
    [button setBackgroundImage: [UIImage imageNamed:@"NewsIcon"] forState: UIControlStateNormal];
    button.showsTouchWhenHighlighted = YES;
    [button addTarget: self action: @selector(openNewsController) forControlEvents: UIControlEventTouchUpInside];
}

- (void) addMapButton {
    if (nil != self.mapButton) {
        return;
    }
    
    MapButton* button = [MapButton buttonWithType: UIButtonTypeCustom];
    [self.view addSubview: button];
    self.mapButton = button;
    
    [button setTitle: @"" forState: UIControlStateNormal];
    [button setBackgroundImage: [UIImage imageNamed:@"location"] forState: UIControlStateNormal];
    button.showsTouchWhenHighlighted = YES;
    [button addTarget: self action: @selector(openMapController) forControlEvents: UIControlEventTouchUpInside];
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

#pragma mark - News Button Action

- (void) openNewsController {
    NewsTableViewController* tableViewController = [NewsTableViewController new];
    [self.navigationController pushViewController: tableViewController animated:YES];
}

#pragma mark - Map Button Action

- (void) openMapController {
    MapViewController* mapViewController = [MapViewController new];
    [self.navigationController pushViewController: mapViewController animated:YES];
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
