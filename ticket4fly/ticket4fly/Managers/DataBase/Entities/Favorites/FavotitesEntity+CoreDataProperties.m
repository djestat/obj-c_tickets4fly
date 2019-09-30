//
//  FavotitesEntity+CoreDataProperties.m
//  ticket4fly
//
//  Created by Igor on 29/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//
//

#import "FavotitesEntity+CoreDataProperties.h"

@implementation FavotitesEntity (CoreDataProperties)

+ (NSFetchRequest<FavotitesEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"FavotitesEntity"];
}

@dynamic date;
@dynamic fromCity;
@dynamic toCity;

@end
