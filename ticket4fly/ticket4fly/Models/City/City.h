//
//  City.h
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <Foundation/Foundation.h>

// https://support.travelpayouts.com/hc/ru/articles/203956163-Aviasales-API-%D0%B4%D0%BE%D1%81%D1%82%D1%83%D0%BF%D0%B0-%D0%BA-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D0%BC-%D0%B4%D0%BB%D1%8F-%D1%83%D1%87%D0%B0%D1%81%D1%82%D0%BD%D0%B8%D0%BA%D0%BE%D0%B2-%D0%BF%D0%B0%D1%80%D1%82%D0%BD%D0%B5%D1%80%D1%81%D0%BA%D0%BE%D0%B9-%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D1%8B
// http://api.travelpayouts.com/data/ru/cities.json


NS_ASSUME_NONNULL_BEGIN

@interface City : NSObject

@property (nonatomic, strong, nonnull, readonly) NSString* code;
@property (nonatomic, strong, nonnull, readonly) NSString* name;

@property (nonatomic, strong, nonnull, readonly) NSString* timeZone;
@property (nonatomic, strong, nonnull, readonly) NSString* countryCode;

@property (nonatomic, strong, nonnull, readonly) NSDictionary* translations;

@property (nonatomic, strong, nonnull, readonly) NSNumber* lon;
@property (nonatomic, strong, nonnull, readonly) NSNumber* lat;

+ (nullable City*) createWithDictionary: (NSDictionary*) dictionary;

@end

NS_ASSUME_NONNULL_END
