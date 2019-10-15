//
//  Airport.m
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "Airport.h"

@interface Airport ()

@property (nonatomic, strong, nonnull, readwrite) NSString* code;
@property (nonatomic, strong, nonnull, readwrite) NSString* name;

@property (nonatomic, strong, nonnull, readwrite) NSString* timeZone;
@property (nonatomic, strong, nonnull, readwrite) NSString* countryCode;
@property (nonatomic, strong, nonnull, readwrite) NSString* cityCode;

@property (nonatomic, strong, nonnull, readwrite) NSDictionary* translations;

@property (nonatomic, strong, nonnull, readwrite) NSNumber* lon;
@property (nonatomic, strong, nonnull, readwrite) NSNumber* lat;

@end

@implementation Airport

+ (nullable Airport*) createWithDictionary: (NSDictionary*) dictionary {
    if (NO == [dictionary isKindOfClass: [NSDictionary class]]) {
//        NSLog(@"Airport wrong dictionary %@", dictionary);
        return nil;
    }
    
    
    NSString* name = [dictionary objectForKey: @"name"];
    if (NO == [name isKindOfClass: [NSString class]]) {
//        NSLog(@"Airport wrong name %@", name);
        return nil;
    }
    
    NSString* code = [dictionary objectForKey: @"code"];
    if (NO == [code isKindOfClass: [NSString class]]) {
//        NSLog(@"Airport wrong code %@", code);
        return nil;
    }
    
    NSDictionary* translations = [dictionary objectForKey: @"name_translations"];
    if (NO == [translations isKindOfClass: [NSDictionary class]]) {
//        NSLog(@"Airport wrong translations %@", translations);
        return nil;
    }
    
    NSDictionary* coordinates = [dictionary objectForKey: @"coordinates"];
    if (NO == [coordinates isKindOfClass: [NSDictionary class]]) {
//        NSLog(@"Airport wrong coordinates %@", coordinates);
        return nil;
    }
    
    NSNumber* lon = [coordinates objectForKey: @"lon"];
    if (NO == [lon isKindOfClass: [NSNumber class]]) {
//        NSLog(@"Airport wrong lon %@", lon);
        return nil;
    }
    
    NSNumber* lat = [coordinates objectForKey: @"lat"];
    if (NO == [lat isKindOfClass: [NSNumber class]]) {
//        NSLog(@"Airport wrong lat %@", lat);
        return nil;
    }
    
    NSString* timeZone = [dictionary objectForKey: @"time_zone"];
    if (NO == [timeZone isKindOfClass: [NSString class]]) {
//        NSLog(@"Airport wrong timeZone %@", timeZone);
        return nil;
    }
    
    NSString* countryCode = [dictionary objectForKey: @"country_code"];
    if (NO == [countryCode isKindOfClass: [NSString class]]) {
//        NSLog(@"Airport wrong countryCode %@", countryCode);
        return nil;
    }
    
    NSString* cityCode = [dictionary objectForKey: @"city_code"];
    if (NO == [cityCode isKindOfClass: [NSString class]]) {
//        NSLog(@"Airport wrong cityCode %@", cityCode);
        return nil;
    }
    
    Airport* airport = [Airport new];
    airport.name = name;
    airport.code = code;
    
    airport.timeZone = timeZone;
    airport.countryCode = countryCode;
    airport.cityCode = cityCode;
    
    airport.lon = lon;
    airport.lat = lat;
    
    airport.translations = translations;
    
    return airport;
}

- (NSString *)description {
    NSMutableString* description = [NSMutableString new];
    [description appendString: [super description]];
    
    [description appendFormat: @"\n name = %@", self.name];
    [description appendFormat: @"\n code = %@", self.code];
    
    [description appendFormat: @"\n lon = %@", self.lon];
    [description appendFormat: @"\n lat = %@", self.lat];
    
    [description appendFormat: @"\n timeZone = %@", self.timeZone];
    [description appendFormat: @"\n countryCode = %@", self.countryCode];
    [description appendFormat: @"\n cityCode = %@", self.cityCode];
    
    [description appendFormat: @"\n translations = %@", self.translations];
    
    return description;
}

@end
