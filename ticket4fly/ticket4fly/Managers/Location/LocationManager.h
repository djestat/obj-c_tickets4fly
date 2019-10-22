//
//  LocationManager.h
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@class City;

@interface LocationManager : NSObject

+ (LocationManager*) shared;

- (NSNotificationName) didUpdatedCurrentLocationNotificationName;

- (void) requestCurrentLocation;

- (CLLocation *) getCurrentLocation;

- (nullable City*) nearestCityToCurrentLocation: (NSArray<City*>*) cities;

@end

NS_ASSUME_NONNULL_END
