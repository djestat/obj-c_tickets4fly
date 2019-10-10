//
//  MapPrice.m
//  ticket4fly
//
//  Created by Igor on 10.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "MapPrice.h"
#import "City.h"

@implementation MapPrice

+ (nullable MapPrice*) createWithDictionary: (NSDictionary*) dictionary {
    NSString* destinationIATA = [dictionary objectForKey: @"destination"];
    if (NO == [destinationIATA isKindOfClass: [NSString class]]) {
        return nil;
    }
    
    NSString* origin = [dictionary objectForKey: @"origin"];
    if (NO == [origin isKindOfClass: [NSString class]]) {
        return nil;
    }
    
    NSNumber* value = [dictionary objectForKey: @"value"];
    if (NO == [value isKindOfClass: [NSNumber class]]) {
        return nil;
    }
    
    MapPrice* price = [MapPrice new];
    price.destinationIATA = destinationIATA;
    price.value = [value integerValue];
    price.originIATA = origin;
    return price;
}

- (void) fillWithCities: (NSArray<City*>*) cities {
    for (City* city in cities) {
        if ([city.code isEqualToString: self.destinationIATA]) {
            self.destinationCity = city;
            break;
        }
    }
}


@end
