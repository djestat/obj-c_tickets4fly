//
//  LocationManager.m
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "City.h"

@interface LocationManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) CLLocation* currentLocation;

@end

@implementation LocationManager

+ (LocationManager*) shared {
    static LocationManager* shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (CLLocationManager *)locationManager {
    if (nil == _locationManager) {
        _locationManager = [CLLocationManager new];
        _locationManager.distanceFilter = 1000;
        _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (void) requestCurrentLocation {
    [self.locationManager requestAlwaysAuthorization];
}

- (nullable City*) nearestCityToCurrentLocation: (NSArray<City*>*) cities {
    double minDistance = 10000;
    City* currentCity = nil;
    for (City* city in cities) {
        CLLocation* cityLocation = [[CLLocation alloc] initWithLatitude: [city.lat doubleValue]
                                                             longitude: [city.lon doubleValue]];
        CLLocationDistance distance = [cityLocation distanceFromLocation: self.currentLocation];
        
        if (distance < minDistance) {
            currentCity = city;
            minDistance = distance;
        }
    }
    
    return currentCity;
}

- (NSNotificationName) didUpdatedCurrentLocationNotificationName {
    return @"didUpdatedCurremtLocationNotificationName";
}

#pragma mark -

- (void) postDidUpdatedCurremtLocation {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"postNotificationName %@", [self didUpdatedCurrentLocationNotificationName]);
        [[NSNotificationCenter defaultCenter] postNotificationName: [self didUpdatedCurrentLocationNotificationName] object: nil];
    });
}

- (void) wasAuth {
    [self.locationManager startUpdatingLocation];
}

- (void) wasNotAuth {
    [self postDidUpdatedCurremtLocation];
}

- (void)addressFromLocation:(CLLocation *)location {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if ([placemarks count] > 0) {
            for (MKPlacemark *placemark in placemarks) {
                NSLog(@"%@", placemark.name);
            }
        }
        
    }];
}

- (void)locationFromAddress:(NSString *)address {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if ([placemarks count] > 0) {
            for (MKPlacemark *placemark in placemarks) {
                NSLog(@"placemark %@", placemark);
            }
        }
        
    }];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"locationManager didChangeAuthorizationStatus");
    
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self wasAuth];
    } else {
        [self wasNotAuth];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    if (nil == self.currentLocation) {
        self.currentLocation = [locations firstObject];
        [manager stopUpdatingLocation];
        
        [self postDidUpdatedCurremtLocation];
        
        //[self addressFromLocation: self.currentLocation];
    }
}

@end
