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

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Мое местоположение!";
    //Map View
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_mapView];
    [_mapView.delegate self];
    
    //Location Manager
    
    _locationManager = [CLLocationManager new];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    [self updateCurrentLocation];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    static NSString *identifier = @"My Place";
    MKMarkerAnnotationView *annotationView = (MKMarkerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    annotationView = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    annotationView.canShowCallout = YES;
    annotationView.calloutOffset = CGPointMake(-5.0, 5.0);
    annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [(UIImageView *)annotationView.leftCalloutAccessoryView setImage: [UIImage imageNamed:@"satellite"]];
    annotationView.annotation = annotation;
    return annotationView;
}


/*
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {

    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];

    static NSString *identifier = @"My Place";
    MKMarkerAnnotationView *annotationView = (MKMarkerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView) {
        annotationView = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.canShowCallout = YES;
        annotationView.calloutOffset = CGPointMake(-5.0, 5.0);
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [(UIImageView *)annotationView.leftCalloutAccessoryView setImage: [UIImage imageNamed:@"satellite"]];
        
    }
    annotationView.annotation = annotation;
    
}*/

@end
