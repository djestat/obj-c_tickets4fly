//
//  AirportEntity+CoreDataClass.h
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

@class Airport;

@interface AirportEntity : NSManagedObject

- (Airport*) create;

+ (AirportEntity*) createFrom: (Airport*) airport context: (NSManagedObjectContext*) context;


@end

NS_ASSUME_NONNULL_END

#import "AirportEntity+CoreDataProperties.h"
