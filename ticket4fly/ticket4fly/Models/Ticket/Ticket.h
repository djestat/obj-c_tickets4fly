//
//  Ticket.h
//  ticket4fly
//
//  Created by Igor on 10.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Ticket : NSObject

@property (nonatomic, strong, nonnull, readwrite) NSNumber *price;
@property (nonatomic, strong, nonnull, readwrite) NSString *airline;
@property (nonatomic, strong, nonnull, readwrite) NSDate *departure;
@property (nonatomic, strong, nonnull, readwrite) NSNumber *flightNumber;
@property (nonatomic, strong, nonnull, readwrite) NSDate *returnDate;
@property (nonatomic, strong, nonnull, readwrite) NSString *from;
@property (nonatomic, strong, nonnull, readwrite) NSString *to;
@property (nonatomic, strong, nonnull, readwrite) NSString *type;

//+ (nullable Ticket*) createWithDictionary: (NSDictionary*) dictionary;
//- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
