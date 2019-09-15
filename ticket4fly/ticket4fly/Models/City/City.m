//
//  City.m
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "City.h"

@interface City ()

@property (nonatomic, strong, nonnull, readwrite) NSString* code;
@property (nonatomic, strong, nonnull, readwrite) NSString* name;

@property (nonatomic, strong, nonnull, readwrite) NSString* timeZone;
@property (nonatomic, strong, nonnull, readwrite) NSString* countryCode;

@property (nonatomic, strong, nonnull, readwrite) NSDictionary* translations;

@property (nonatomic, strong, nonnull, readwrite) NSNumber* lon;
@property (nonatomic, strong, nonnull, readwrite) NSNumber* lat;

@end

@implementation City

+ (nullable City*) createWithDictionary: (NSDictionary*) dictionary {
    if (NO == [dictionary isKindOfClass: [NSDictionary class]]) {
        NSLog(@"City wrong dictionary %@", dictionary);
        return nil;
    }
    
    
    NSString* name = [dictionary objectForKey: @"name"];
    if (NO == [name isKindOfClass: [NSString class]]) {
        NSLog(@"City wrong name %@", name);
        return nil;
    }
    
    NSString* code = [dictionary objectForKey: @"code"];
    if (NO == [code isKindOfClass: [NSString class]]) {
        NSLog(@"City wrong code %@", code);
        return nil;
    }
    
    NSDictionary* translations = [dictionary objectForKey: @"name_translations"];
    if (NO == [translations isKindOfClass: [NSDictionary class]]) {
        NSLog(@"City wrong translations %@", translations);
        return nil;
    }
    
    NSDictionary* coordinates = [dictionary objectForKey: @"coordinates"];
    if (NO == [coordinates isKindOfClass: [NSDictionary class]]) {
        NSLog(@"City wrong coordinates %@", coordinates);
        return nil;
    }
    
    NSNumber* lon = [coordinates objectForKey: @"lon"];
    if (NO == [lon isKindOfClass: [NSNumber class]]) {
        NSLog(@"City wrong lon %@", lon);
        return nil;
    }
    
    NSNumber* lat = [coordinates objectForKey: @"lat"];
    if (NO == [lat isKindOfClass: [NSNumber class]]) {
        NSLog(@"City wrong lat %@", lat);
        return nil;
    }
    
    NSString* timeZone = [dictionary objectForKey: @"time_zone"];
    if (NO == [timeZone isKindOfClass: [NSString class]]) {
        NSLog(@"City wrong timeZone %@", timeZone);
        return nil;
    }
    
    NSString* countryCode = [dictionary objectForKey: @"country_code"];
    if (NO == [countryCode isKindOfClass: [NSString class]]) {
        NSLog(@"City wrong countryCode %@", countryCode);
        return nil;
    }
    
    City* city = [City new];
    city.name = name;
    city.code = code;
    
    city.timeZone = timeZone;
    city.countryCode = countryCode;
    
    city.lon = lon;
    city.lat = lat;
    
    city.translations = translations;
    
    return city;
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
    
    [description appendFormat: @"\n translations = %@", self.translations];
    
    return description;
}

@end
