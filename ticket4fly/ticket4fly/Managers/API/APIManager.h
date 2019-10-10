//
//  APIManager.h
//  ticket4fly
//
//  Created by Igor on 10.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Route;
@class MapPrice;
@class Route;

typedef void (^APIManager_GetTicketsCompletion)(NSArray<Route*>*);
typedef void (^APIManager_GetMapPricesCompletion)(NSArray<MapPrice*>*);

typedef void (^APIManager_OrderRouteCompletion)(BOOL);

@interface APIManager : NSObject

- (void) getTicketsFrom: (NSString*) fromIATA to: (NSString*) toIATA completion: (APIManager_GetTicketsCompletion) completion;

- (void) getMapPricesNear: (NSString*) IATA completion: (APIManager_GetMapPricesCompletion) completion;

- (void) orderRoute: (Route*) route completion: (APIManager_OrderRouteCompletion) completion;

@end

NS_ASSUME_NONNULL_END
