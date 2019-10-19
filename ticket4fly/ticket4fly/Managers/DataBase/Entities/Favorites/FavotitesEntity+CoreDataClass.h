//
//  FavotitesEntity+CoreDataClass.h
//  ticket4fly
//
//  Created by Igor on 29/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@class Ticket;

@interface FavotitesEntity : NSManagedObject

- (Ticket*) create;

+ (FavotitesEntity*) createFrom: (Ticket*) ticket context: (NSManagedObjectContext*) context;

@end

NS_ASSUME_NONNULL_END

#import "FavotitesEntity+CoreDataProperties.h"
