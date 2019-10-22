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

@protocol PlaceCellModelDelegate <NSObject>

- (void) didSelectCity: (nonnull City*) city;
- (void) didSelectAirport: (nonnull Airport*) airport;

@end

@interface PlaceCellModel : CellModel

@property (nonatomic, weak) NSObject<PlaceCellModelDelegate>* delegate;

+ (PlaceCellModel*) createWithAirport: (Airport*) airport;
+ (PlaceCellModel*) createWithCity: (City*) city;

- (NSString*) placeName;
- (NSString*) placeCode;


@end

NS_ASSUME_NONNULL_END
