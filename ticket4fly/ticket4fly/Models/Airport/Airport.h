//
//  Airport.h
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <Foundation/Foundation.h>

// http://api.travelpayouts.com/data/ru/airports.json

NS_ASSUME_NONNULL_BEGIN

@interface Airport : NSObject

@property (nonatomic, strong, nonnull, readwrite) NSString* code;
@property (nonatomic, strong, nonnull, readwrite) NSString* name;

@property (nonatomic, strong, nonnull, readwrite) NSString* timeZone;
@property (nonatomic, strong, nonnull, readwrite) NSString* countryCode;
@property (nonatomic, strong, nonnull, readwrite) NSString* cityCode;

@property (nonatomic, strong, nonnull, readwrite) NSDictionary* translations;

@property (nonatomic, strong, nonnull, readwrite) NSNumber* lon;
@property (nonatomic, strong, nonnull, readwrite) NSNumber* lat;

+ (nullable Airport*) createWithDictionary: (NSDictionary*) dictionary;


@end

NS_ASSUME_NONNULL_END
