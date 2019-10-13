//
//  DataBaseManager.h
//  ticket4fly
//
//  Created by Igor on 29/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class City;

typedef void(^DataBaseManager_CitiesCompletion)(NSArray<City*>*);
//typedef void(^DataBaseManager_CitiesCompletion)(NSArray<City*>*);

@interface DataBaseManager : NSObject

+ (DataBaseManager*) shared;

- (void) saveCities: (NSArray<City*>*) cities;
- (void) loadCitiesWithQuery: (nullable NSString*) query completiom: (DataBaseManager_CitiesCompletion) completion;
/*
- (void) saveTickets: (NSArray<City*>*) cities;
- (void) loadFavoritesTickets: (nullable NSString*) query completiom: (DataBaseManager_CitiesCompletion) completion;
- (void) deleteTickets: (NSArray<City*>*) cities;
*/

@end

NS_ASSUME_NONNULL_END
