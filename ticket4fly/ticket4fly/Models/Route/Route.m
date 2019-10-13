//
//  Route.m
//  ticket4fly
//
//  Created by Igor on 10.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "Route.h"

#define kRouteKey_airline @"airline"
#define kRouteKey_expiresAt @"expires_at"
#define kRouteKey_departureAt @"departure_at"
#define kRouteKey_flightNumber @"flight_number"
#define kRouteKey_price @"price"
#define kRouteKey_return_at @"return_at"


@interface Route ()

@property (nonatomic, strong, readwrite) NSNumber *price;
@property (nonatomic, strong, readwrite) NSString *airline;
@property (nonatomic, strong, readwrite) NSDate *departure;
@property (nonatomic, strong, readwrite) NSDate *expires;
@property (nonatomic, strong, readwrite) NSNumber *flightNumber;
@property (nonatomic, strong, readwrite) NSDate *returnDate;

@end


@implementation Route

+ (nullable Route*) createWithDictionary: (NSDictionary*) dictionary {
    
    NSNumber* price = [dictionary objectForKey: kRouteKey_price];
    if (NO == [price isKindOfClass: [NSNumber class]]) {
        NSLog(@"Route wrong price %@", price);
        return nil;
    }
    
    NSString* airline = [dictionary objectForKey: kRouteKey_airline];
    if (NO == [airline isKindOfClass: [NSString class]]) {
        NSLog(@"Route wrong airline %@", airline);
        return nil;
    }
    
    NSDate* departure = dateFromStrings([dictionary objectForKey: kRouteKey_departureAt]);
    if (NO == [departure isKindOfClass: [NSDate class]]) {
        NSLog(@"Route wrong departure %@", departure);
        return nil;
    }
    
    NSDate* expires = dateFromStrings([dictionary objectForKey: kRouteKey_expiresAt]);
    if (NO == [expires isKindOfClass: [NSNumber class]]) {
        NSLog(@"Route wrong expires %@", expires);
        return nil;
    }
    
    NSNumber* flightNumber = [dictionary objectForKey: kRouteKey_flightNumber];
    if (NO == [flightNumber isKindOfClass: [NSNumber class]]) {
        NSLog(@"Route wrong flightNumber %@", flightNumber);
        return nil;
    }
    
    NSDate* returnDate = dateFromStrings([dictionary objectForKey: kRouteKey_return_at]);
    if (NO == [returnDate isKindOfClass: [NSDate class]]) {
        NSLog(@"Route wrong returnDate %@", returnDate);
        return nil;
    }
    
    Route* route = [Route new];
    route.price = price;
    route.airline = airline;
    route.departure = departure;
    route.expires = expires;
    route.flightNumber = flightNumber;
    route.returnDate = returnDate;
    return route;
}

- (NSDictionary*) dictionary {
    NSMutableDictionary* dictionary = [NSMutableDictionary new];
        
    [dictionary setObject: self.price forKey: kRouteKey_price];
    [dictionary setObject: self.airline forKey: kRouteKey_airline];
    [dictionary setObject: self.departure forKey: kRouteKey_departureAt];
    [dictionary setObject: self.expires forKey: kRouteKey_expiresAt];
    [dictionary setObject: self.flightNumber forKey: kRouteKey_flightNumber];
    [dictionary setObject: self.returnDate forKey: kRouteKey_return_at];
    
    return dictionary;
}

#warning New release

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _airline = [dictionary valueForKey:@"airline"];
        _expires = dateFromStrings([dictionary valueForKey:@"expires_at"]);
        _departure = dateFromStrings([dictionary valueForKey:@"departure_at"]);
        _flightNumber = [dictionary valueForKey:@"flight_number"];
        _price = [dictionary valueForKey:@"price"];
        _returnDate = dateFromStrings([dictionary valueForKey:@"return_at"]);
    }
    return self;
}

NSDate *dateFromStrings(NSString *dateString) {
    if (!dateString) { return  nil; }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *correctSrtingDate = [dateString stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    correctSrtingDate = [correctSrtingDate stringByReplacingOccurrencesOfString:@"Z" withString:@" "];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [dateFormatter dateFromString: correctSrtingDate];
}

@end
