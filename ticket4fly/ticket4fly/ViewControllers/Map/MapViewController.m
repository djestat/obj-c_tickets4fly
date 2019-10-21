//
//  MapViewController.m
//  ticket4fly
//
//  Created by Igor on 20.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "MapViewController.h"
#import "MapPriceAnnotationView.h"

#import "City.h"
#import "MapPrice.h"
#import "Ticket.h"

#import "ApiManager.h"
#import "DataManager.h"
#import "LocationManager.h"

#import "DataBaseManager.h"

@interface MapViewController () <MKMapViewDelegate>

@property (nonatomic, weak) MKMapView *mapView;

@property (nonatomic, strong) City *currentCity;

@property (nonatomic, strong) APIManager* apiManager;
@property (nonatomic, weak, readwrite) LocationManager* locationManager;
@property (nonatomic, weak, readwrite) DataManager* dataManager;

@property (nonatomic, strong) NSMutableArray<MapPrice*>* prices;

@property (nonatomic, weak, readwrite) NSNumber* indexSelectedMapPrice;

@end

@implementation MapViewController

- (APIManager *)apiManager {
    if (nil == _apiManager) {
        _apiManager = [APIManager new];
    }
    return _apiManager;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self reload];
    [self centeredMyLocation];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Map";
    self.prices = [NSMutableArray new];
    self.locationManager = [LocationManager shared];
    self.dataManager = [DataManager shared];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.mapView.frame = self.view.bounds;
}

#pragma mark - Add Subviews

- (void)addSubviews {
    [super addSubviews];
    
    [self addMapView];
    [self addRefreshView];
}

- (void) addMapView {
    if (nil != self.mapView) { return; }
    
    MKMapView* mapView = [[MKMapView alloc] initWithFrame: CGRectZero];
    mapView.delegate = self;
    if (@available(iOS 11.0, *)) {
        [mapView registerClass: [MapPriceAnnotationView class] forAnnotationViewWithReuseIdentifier: NSStringFromClass([MapPriceAnnotationView class])];
    } else {
        
    }
    [self.view addSubview: mapView];
    self.mapView = mapView;
}

- (void) addRefreshView {

    CGRect refreshViewRect = CGRectMake(self.view.bounds.size.width - 65, self.view.bounds.size.height - 150, 50, 50);
    UIImageView *refreshView = [[UIImageView alloc] initWithFrame: refreshViewRect];
    refreshView.image = [UIImage imageNamed: @"refresh"];
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAction:)];
    [refreshView addGestureRecognizer:singleFingerTap];
    [refreshView setUserInteractionEnabled: YES];
    [self.view insertSubview: refreshView aboveSubview: self.mapView];
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    if (nil != self.currentCity) {
        [self reload];
    }
    [self centeredMyLocation];
    NSLog(@"! tapAction Refresh");
}

#pragma mark - Reload

- (void) reload {
    if (nil != self.currentCity) { return; }
    
    NSArray<City*>* cities = self.dataManager.cities;
    self.currentCity = [self.locationManager nearestCityToCurrentLocation: cities];
    
    if (nil != self.currentCity) {
        __weak typeof(self) weakSelf = self;
        [self.apiManager getMapPricesNear: self.currentCity.code completion:^(NSArray<MapPrice *> * _Nonnull prices) {
            [weakSelf reloadWith: prices];
        }];
    }
    NSLog(@"! reload");
}

- (void) reloadWith: (NSArray<MapPrice*>*) mapPrices {
    [self.prices removeAllObjects];
    [self.prices addObjectsFromArray: mapPrices];
    [self.mapView removeAnnotations: self.mapView.annotations];
    
    NSArray* cities = DataManager.shared.cities;
    
    for (MapPrice* price in mapPrices) {
        [price fillWithCities: cities];
    }
    
    [self reloadVisibleAnnotation];
}

- (void) reloadVisibleAnnotation {
    [self.mapView removeAnnotations: self.mapView.annotations];
    
    for (MapPrice* price in self.prices) {
        City* city = price.destinationCity;
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([city.lat doubleValue], [city.lon doubleValue]);
        
        if(MKMapRectContainsPoint(self.mapView.visibleMapRect, MKMapPointForCoordinate(coordinate))) {
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.subtitle = [NSString stringWithFormat:@"%@ руб.", price.value];
            annotation.title = city.name;
            annotation.coordinate = coordinate;
            [self.mapView addAnnotation: annotation];
        }
    }
}


#pragma mark - MKMapViewDelegate

- (void)mapViewDidChangeVisibleRegion:(MKMapView *)mapView {
    [self reloadVisibleAnnotation];
}

//- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
//    MapPriceAnnotationView* view = (MapPriceAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier: NSStringFromClass([MapPriceAnnotationView class])];
//
//    [view configure];
//
//    return view;
//}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
        
    NSLog(@"didSelectAnnotationView %@", view.annotation.description);
    
    NSUInteger index = [mapView.annotations indexOfObject:view.annotation];
    NSLog(@"index no %lu",(unsigned long)index);
    NSLog(@"City %@ - price %@", self.prices[index].destinationCity, self.prices[index].value);
    
    NSString * selectedTitle = [NSString stringWithFormat:@"%@",view.annotation.title];
    
    for (int i = 0; i < self.prices.count; i++) {
        MapPrice* price = self.prices[i];
        City* city = price.destinationCity;
        if ([city.name isEqualToString: selectedTitle]) {
            NSLog(@"You selected index: %d and City: %@", i , self.prices[i].destinationCity.name);
            self.indexSelectedMapPrice = [NSNumber numberWithInt: i];
        }
    }
    
//    NSInteger index = [[self.items valueForKey:@"name"] indexOfObject:selectedTitle]; //Considering self.items as NSDictionary consist of all annotation names.

}

#pragma mark - Notifications

- (void) addNotifications {
    [super addNotifications];
    
    NSLog(@"MainViewController addNotifications");
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(receiveLocation)
                                                 name: [self.locationManager didUpdatedCurrentLocationNotificationName]
                                               object: nil];
}

- (void) removeNotifications {
    [super removeNotifications];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: [self.locationManager didUpdatedCurrentLocationNotificationName]
                                                  object: nil];
}

- (void) receiveLocation {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
      NSLog(@"Do it once");
    });
    /*
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
     // Do you work over here
        if (nil == self.currentCity) {
            [self reload];
        }
        [self centeredMyLocation];
        NSLog(@"receiveLocation");
    });*/
//    NSLog(@"receiveLocation out block");
}

#pragma mark - My Current Place

- (void) centeredMyLocation {
    
    CLLocation *currentLocation = [self.locationManager getCurrentLocation];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 2000000, 2000000);
    [self.mapView setRegion: region animated: YES];
    self.mapView.showsUserLocation = NO;
    
    
    /*
    if (nil == self.currentCity) {
        double lat = [self.currentCity.lat doubleValue];
        double lon = [self.currentCity.lon doubleValue];
        CLLocationCoordinate2D currentLocation = CLLocationCoordinate2DMake(lat, lon);
        
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation, 5000000, 5000000);
        [self.mapView setRegion: region animated: YES];
        
    }
     */

    
    NSLog(@"Centered MyLocation");

}

- (void) addMyLocation2 {
    
    double lat = [self.currentCity.lat doubleValue];
    double lon = [self.currentCity.lon doubleValue];
    CLLocationCoordinate2D currentLocation = CLLocationCoordinate2DMake(lat, lon);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation, 5000000, 5000000);
    [_mapView setRegion: region animated: YES];
    _mapView.showsUserLocation = YES;
    
    CLLocation *location = [[CLLocation alloc]initWithCoordinate: currentLocation
                                                        altitude: CLLocationDistanceMax
                                              horizontalAccuracy: kCLLocationAccuracyBest
                                                verticalAccuracy: kCLLocationAccuracyBest
                                                       timestamp: [NSDate date]];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation: location completionHandler:^(NSArray *placemarks, NSError *error)
     {
        if (!placemarks) {
            NSLog(@" addPin currentLocation Error");
        }
        
        if(placemarks && placemarks.count > 0)
        {
            CLPlacemark *placemark= [placemarks objectAtIndex:0];
            NSString *address = [NSString stringWithFormat:@"%@, %@ %@",[placemark thoroughfare],[placemark locality], [placemark administrativeArea]];
            annotation.subtitle = address;
        }
    }];
    
    annotation.title = @"Current City";
    annotation.coordinate = currentLocation;
    [self.mapView addAnnotation: annotation];
}

#pragma mark - Annotation View

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    //    mapView = _mapView;
    
    NSString *identifier = @"Map View";
    MKMarkerAnnotationView *annotationView = (MKMarkerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    annotationView = (MKMarkerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    annotationView = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    annotationView.canShowCallout = YES;
    annotationView.calloutOffset = CGPointMake(-5.0, 5.0);
    
    UIButton *addToFavoriteButoon = [UIButton buttonWithType: UIButtonTypeContactAdd];
    annotationView.rightCalloutAccessoryView = addToFavoriteButoon;
    [addToFavoriteButoon addTarget: self action: @selector(addToFavorites) forControlEvents: UIControlEventTouchUpInside];
    
    annotationView.annotation = annotation;
    return annotationView;
    
}

#pragma mark - Add To Favorites

- (void) addToFavorites {
    
    //    MKAnnotationView* view =  (MKAnnotationView *) self.mapView.selectedAnnotations.firstObject;
    
    //    UIView* animationView = [_annotationView copy];
    
    //    view.backgroundColor = [UIColor blueColor];
    /*
     CABasicAnimation *theAnimation;
     
     theAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
     theAnimation.duration = 3.0;
     theAnimation.repeatCount = 2;
     theAnimation.autoreverses = NO;
     theAnimation.fromValue= [NSValue valueWithCGPoint:CGPointMake(_annotationView.frame.origin.x
     , _annotationView.frame.origin.y)];
     theAnimation.toValue= [NSValue valueWithCGPoint:CGPointMake(100, 100)];
     [_annotationView.layer addAnimation:theAnimation forKey:@"animatePosition"];
     */
    
    //    [_mapView.layer removeAllAnimations];
    
    NSInteger indexSelectedMapPrice = [self.indexSelectedMapPrice integerValue];
    MapPrice* selectedPrice = self.prices[indexSelectedMapPrice];
    Ticket* ticket = [Ticket new];
    
    ticket.airline = @"mapTicket";
    ticket.departure = selectedPrice.departDate;
    ticket.flightNumber = selectedPrice.flightNumber;
    ticket.from = selectedPrice.originIATA;
    ticket.to = selectedPrice.destinationCity.name;
    ticket.price = selectedPrice.value;
    ticket.returnDate = selectedPrice.returnDate;
    ticket.type = @"map";
    
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

    NSLog(@"Action ADD!");
    
}

@end
