//
//  Route.m
//  ticket4fly
//
//  Created by Igor on 10.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "Route.h"

#define kRouteKey_aTime @"aTime"
#define kRouteKey_dTime @"dTime"


@interface Route ()

@property (nonatomic, strong, readwrite) NSNumber* aTime;
@property (nonatomic, strong, readwrite) NSNumber* dTime;

@end


@implementation Route

+ (nullable Route*) createWithDictionary: (NSDictionary*) dictionary {
    NSNumber* aTime = [dictionary objectForKey: kRouteKey_aTime];
    if (NO == [aTime isKindOfClass: [NSNumber class]]) {
        NSLog(@"Route wrong aTime %@", aTime);
        return nil;
    }
    
    NSNumber* dTime = [dictionary objectForKey: kRouteKey_dTime];
    if (NO == [dTime isKindOfClass: [NSNumber class]]) {
        NSLog(@"Route wrong dTime %@", dTime);
        return nil;
    }
    
    Route* route = [Route new];
    route.aTime = aTime;
    route.dTime = dTime;
    return route;
}

- (NSDictionary*) dictionary {
    NSMutableDictionary* dictionary = [NSMutableDictionary new];
    
    [dictionary setObject: self.aTime forKey: kRouteKey_aTime];
    [dictionary setObject: self.dTime forKey: kRouteKey_dTime];
    
    return dictionary;
}
@end
