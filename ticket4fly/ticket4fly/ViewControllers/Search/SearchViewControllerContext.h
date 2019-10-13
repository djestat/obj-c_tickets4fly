//
//  SearchViewControllerContext.h
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ViewControllerContext.h"

NS_ASSUME_NONNULL_BEGIN

@class Airport;
@class City;

@interface SearchViewControllerContext : NSObject <ViewControllerContext>


@property (nonatomic, strong, nullable) Airport* fromAirport;
@property (nonatomic, strong, nullable) Airport* toAirport;

@property (nonatomic, strong, nullable) City* fromCity;
@property (nonatomic, strong, nullable) City* toCity;

@end

NS_ASSUME_NONNULL_END
