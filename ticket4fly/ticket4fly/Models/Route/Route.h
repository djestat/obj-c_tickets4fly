//
//  Route.h
//  ticket4fly
//
//  Created by Igor on 10.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Route : NSObject

@property (nonatomic, strong, readonly) NSNumber *price;
@property (nonatomic, strong, readonly) NSString *airline;
@property (nonatomic, strong, readonly) NSDate *departure;
@property (nonatomic, strong, readonly) NSDate *expires;
@property (nonatomic, strong, readonly) NSNumber *flightNumber;
@property (nonatomic, strong, readonly) NSDate *returnDate;
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *to;

+ (nullable Route*) createWithDictionary: (NSDictionary*) dictionary;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary*) dictionary;


@end

NS_ASSUME_NONNULL_END
