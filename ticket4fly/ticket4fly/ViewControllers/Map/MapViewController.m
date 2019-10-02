//
//  MapViewController.m
//  ticket4fly
//
//  Created by Igor on 22/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "MapViewController.h"


@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) CLGeocoder *place;

@property (nonatomic, strong) MKMarkerAnnotationView *annotationView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Price map";
    //Map View
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview: _mapView];
    _mapView.delegate = self;
    
    //Location Manager
    
    _locationManager = [CLLocationManager new];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    [self updateCurrentLocation];
}


#pragma mark - Add To Favorites

- (void) addToFavorites {
#warning Save to Core Data
    
//    MKAnnotationView* view =  (MKAnnotationView *) self.mapView.selectedAnnotations.lastObject;
    
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
    
    NSLog(@"Action ADD!");

}


#pragma mark - Update Location

- (void)updateCurrentLocation {
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *currentLocation = self.currentLocation;
    
    if (currentLocation != [locations firstObject]) {
        self.currentLocation = [locations firstObject];
        currentLocation = [locations firstObject];
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 100000, 100000);
        [_mapView setRegion: region animated: YES];
        _mapView.showsUserLocation = NO;
        [self addPin: currentLocation];
        [self.locationManager stopUpdatingLocation];
    }
}


#pragma mark - Annotation

- (void) addPin: (CLLocation *) currentLocation {
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
       [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
        {
            if (!placemarks) {
                NSLog(@"Error");
            }

            if(placemarks && placemarks.count > 0)
            {
                CLPlacemark *placemark= [placemarks objectAtIndex:0];
                NSString *address = [NSString stringWithFormat:@"%@, %@ %@",[placemark thoroughfare],[placemark locality], [placemark administrativeArea]];
                annotation.subtitle = address;
            }
        }];
    
    annotation.title = @"My Place";
    annotation.coordinate = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    [_mapView addAnnotation:annotation];
}

#pragma mark - Annotation View

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    mapView = _mapView;

    NSString *identifier = @"Map View";
//    MKMarkerAnnotationView *annotationView = (MKMarkerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    _annotationView = (MKMarkerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];

    _annotationView = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    _annotationView.canShowCallout = YES;
    _annotationView.calloutOffset = CGPointMake(-5.0, 5.0);
    
    UIButton *addToFavoriteButoon = [UIButton buttonWithType: UIButtonTypeContactAdd];
    _annotationView.rightCalloutAccessoryView = addToFavoriteButoon;
    [addToFavoriteButoon addTarget: self action: @selector(addToFavorites) forControlEvents: UIControlEventTouchUpInside];
    
    _annotationView.annotation = annotation;
    return _annotationView;
    
}

@end
