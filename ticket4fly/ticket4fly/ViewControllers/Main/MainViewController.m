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

#import "SearchViewControllerContext.h"

#import "LocationManager.h"
#import "MapViewControllerContext.h"


@interface MainViewController () <TravelDirectionsViewDelegate, PlaceViewControllerDelegate, DataManagerDelegate>

@property (nonatomic, weak, readwrite) DataManager* dataManager;
@property (nonatomic, weak, readwrite) UIBarButtonItem* settingsButton;
@property (nonatomic, strong, readwrite) SearchViewControllerContext* searchViewControllerContext;
@property (nonatomic, weak, readwrite) TravelDirectionsView* travelDirectionView;

@property (nonatomic, weak, readwrite) LocationManager* locationManager;

@end

@implementation MainViewController

- (SearchViewControllerContext *)searchViewControllerContext {
    if (nil == _searchViewControllerContext) {
        _searchViewControllerContext = [SearchViewControllerContext new];
    }
    
    return _searchViewControllerContext;
}

#pragma mark - Laod ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle: @"Tickets"];
    
    self.dataManager = [DataManager shared];
    self.dataManager.delegate = self;
    [self.dataManager loadData];
    
    self.locationManager = [LocationManager shared];
    
}

#pragma mark - Layout

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    BaseTheme* activeTheme = [ThemeManager.shared activeTheme];
    CGSize travelDirectionsViewSize = [activeTheme travelDirectionsViewSize];
    CGFloat travelDirectionsViewX = (width - travelDirectionsViewSize.width) / 2;
    CGFloat travelDirectionsViewY = (height - travelDirectionsViewSize.height) / 4;
    self.travelDirectionView.frame = CGRectMake(travelDirectionsViewX, travelDirectionsViewY, travelDirectionsViewSize.width, travelDirectionsViewSize.height);
            

}

#pragma mark - Subviews

- (void) addSubviews {
    [super addSubviews];
    
    [self addSettingsButton];
    
    [self addTravelDirectionsView];
    
}

- (void) addTravelDirectionsView {
    if (nil != self.travelDirectionView) {
        return;
    }
    
    TravelDirectionsView* view = [TravelDirectionsView new];
    view.layer.cornerRadius = 6.0;
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowOffset = CGSizeZero;
    view.layer.shadowOpacity = 10.0;
    view.layer.shadowRadius = 10.0;
    [self.view addSubview: view];
    self.travelDirectionView = view;
    
    view.delegate = self;
    /*
    // Animation
    CGFloat width = view.frame.size.width;
    CGFloat height = view.frame.size.height;
    
    CGFloat positionX = view.frame.origin.x;
    CGFloat positionY = view.frame.origin.y;
    
    CGFloat newPositionX = self.view.frame.size.width;
    CGFloat newPositionY = self.view.frame.size.height;
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
        view.alpha = 0.0;
        view.frame = CGRectMake(newPositionX, newPositionY, width, height);
    } completion:^(BOOL finished) {
        view.alpha = 1.0;
        view.frame = CGRectMake(positionX, positionY, width, height);
    }];
    */
    
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

#warning Update here search
- (void) updateDirectionView {
    
    if (nil != self.searchViewControllerContext.fromCity.name) {
        [self.travelDirectionView setFromTitle: self.searchViewControllerContext.fromCity.name];
    } else if (nil != self.searchViewControllerContext.fromAirport.code) {
        [self.travelDirectionView setFromTitle: self.searchViewControllerContext.fromAirport.code];
    }
    
    if (nil != self.searchViewControllerContext.toCity.name) {
        [self.travelDirectionView setToTitle: self.searchViewControllerContext.toCity.name];
    } else if (nil != self.searchViewControllerContext.toAirport.code) {
        [self.travelDirectionView setToTitle: self.searchViewControllerContext.toAirport.code];
    }
        
    NSLog(@" fromCity.name %@", self.searchViewControllerContext.fromCity.name);
    NSLog(@" toCity.name %@", self.searchViewControllerContext.toCity.name);
    NSLog(@" fromAirport.code %@", self.searchViewControllerContext.fromAirport.code);
    NSLog(@" toAirport.code %@", self.searchViewControllerContext.toAirport.code);


    [self.travelDirectionView disableSearchButton];
    [self.travelDirectionView enableSearchButton];
}

#pragma mark - DataManagerDelegate

- (void)didReceivedCities {
    NSLog(@"didReceiveCities %lu", (unsigned long)[self.dataManager.cities count]);
    
    [self.locationManager requestCurrentLocation];
}

- (void)didReceivedAirports {
    NSLog(@"didReceiveAirports %lu", (unsigned long)[self.dataManager.airports count]);
    
    [self.locationManager requestCurrentLocation];
}

#pragma mark - PlaceViewControllerDelegate

- (void) didSelectCity: (nonnull City*) city reason: (PlaceReason) reason {
    NSLog(@"didSelectCity %@", city);
    
    switch (reason) {
        case PlaceReasonFrom:
            self.searchViewControllerContext.fromCity = city;
            self.searchViewControllerContext.fromAirport = nil;
            break;
            
        case PlaceReasonTo:
            self.searchViewControllerContext.toCity = city;
            self.searchViewControllerContext.toAirport = nil;
            break;
    }
    
    [self updateDirectionView];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) didSelectAirport: (nonnull Airport*) airport reason: (PlaceReason) reason {
    NSLog(@"didSelectAirport %@", airport);
    
    switch (reason) {
        case PlaceReasonFrom:
            self.searchViewControllerContext.fromCity = nil;
            self.searchViewControllerContext.fromAirport = airport;
            break;
            
        case PlaceReasonTo:
            self.searchViewControllerContext.toCity = nil;
            self.searchViewControllerContext.toAirport = airport;
            break;
    }
    
    [self updateDirectionView];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TravelDirectionsView


- (void) fromButtonAction {
    NSObject<ViewControllerContext>* context = [PlaceViewControllerContext create: PlaceReasonFrom delegate: self];
    [self push: context];
}

- (void) toButtonAction {
    NSObject<ViewControllerContext>* context = [PlaceViewControllerContext create: PlaceReasonTo delegate: self];
    [self push: context];
}

- (void) departureDate {
    NSLog(@"flyDate");
}

- (void) arrivalDate {
    NSLog(@"comebackDate");
}

- (void) searchButtonAction {
    NSLog(@"searchButtonAction");
    
    [self push: self.searchViewControllerContext];

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

- (void) receiveLocation {

}

@end
