//
//  CityEntity+CoreDataClass.h
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TranslationEntity;

NS_ASSUME_NONNULL_BEGIN

@class City;

@interface CityEntity : NSManagedObject

- (City*) create;

+ (CityEntity*) createFrom: (City*) city context: (NSManagedObjectContext*) context;

@end

NS_ASSUME_NONNULL_END

#import "CityEntity+CoreDataProperties.h"
