//
//  MapPrice.h
//  ticket4fly
//
//  Created by Igor on 10.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class City;

@interface MapPrice : NSObject

@property (nonatomic, strong) NSString* destinationIATA;
@property (nonatomic, strong) NSString* originIATA;

@property (nonatomic, assign) NSInteger value;

@property (nonatomic, strong) City* destinationCity;

+ (nullable MapPrice*) createWithDictionary: (NSDictionary*) dictionary;

- (void) fillWithCities: (NSArray<City*>*) cities;

@end

NS_ASSUME_NONNULL_END
