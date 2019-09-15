//
//  PlaceCellModel.h
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "CellModel.h"

NS_ASSUME_NONNULL_BEGIN

@class Airport;
@class City;

@interface PlaceCellModel : CellModel

+ (PlaceCellModel*) createWithAirport: (Airport*) airport;
+ (PlaceCellModel*) createWithCity: (City*) city;

- (NSString*) placeName;

@end

NS_ASSUME_NONNULL_END
