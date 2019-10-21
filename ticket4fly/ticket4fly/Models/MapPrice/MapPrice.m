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
    
    NSNumber* ttl = [dictionary objectForKey: @"ttl"];
    if (NO == [ttl isKindOfClass: [NSNumber class]]) {
        return nil;
    }
    
    NSDate* departDate = convertDateToString([dictionary objectForKey: @"depart_date"]);
    if (NO == [departDate isKindOfClass: [NSDate class]]) {
        NSLog(@"MapPrice wrong departDate %@", departDate);
        return nil;
    }
    NSDate* returnDate = convertDateToString([dictionary objectForKey: @"return_date"]);
    if (NO == [returnDate isKindOfClass: [NSDate class]]) {
        NSLog(@"MapPrice wrong returnDate %@", returnDate);
        return nil;
    }

    MapPrice* price = [MapPrice new];
    price.destinationIATA = destinationIATA;
    price.flightNumber =ttl;
    price.value = value;
    price.originIATA = origin;
    price.returnDate = returnDate;
    price.departDate = departDate;
    return price;
}

NSDate *convertDateToString(NSString *dateFromStringMapPrice) {
    if (!dateFromStringMapPrice) { return  nil; }
    NSDateFormatter *dateFormatterMapPrice = [[NSDateFormatter alloc] init];
    NSString *correctSrtingDateMapPrice = [dateFromStringMapPrice stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    correctSrtingDateMapPrice = [correctSrtingDateMapPrice stringByReplacingOccurrencesOfString:@"Z" withString:@" "];
    dateFormatterMapPrice.dateFormat = @"yyyy-MM-dd";
    return [dateFormatterMapPrice dateFromString: correctSrtingDateMapPrice];
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
