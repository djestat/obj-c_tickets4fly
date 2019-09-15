//
//  Country.h
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <Foundation/Foundation.h>

// http://api.travelpayouts.com/data/ru/countries.json

NS_ASSUME_NONNULL_BEGIN

@interface Country : NSObject

@property (nonatomic, strong, readonly) NSString     *name;
@property (nonatomic, strong, readonly) NSString     *currency;
@property (nonatomic, strong, readonly) NSDictionary *translations;
@property (nonatomic, strong, readonly) NSString     *code;

+ (nullable Country*) createWithDictionary: (NSDictionary*) dictionary;

@end

NS_ASSUME_NONNULL_END
