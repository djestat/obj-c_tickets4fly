//
//  PlaceViewControllerContext.h
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewControllerContext.h"
 
typedef enum : NSUInteger {
    PlaceReasonFrom,
    PlaceReasonTo,
} PlaceReason;

NS_ASSUME_NONNULL_BEGIN

@class City;
@class Airport;

@protocol PlaceViewControllerDelegate <NSObject>

- (void) didSelectCity: (nonnull City*) city reason: (PlaceReason) reason;
- (void) didSelectAirport: (nonnull Airport*) airport reason: (PlaceReason) reason;

@end

@interface PlaceViewControllerContext : NSObject <ViewControllerContext>

+ (PlaceViewControllerContext*) create: (PlaceReason) reason delegate: (NSObject<PlaceViewControllerDelegate>*) delegate;

@end

NS_ASSUME_NONNULL_END
