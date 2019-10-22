//
//  FavotitesEntity+CoreDataProperties.m
//  ticket4fly
//
//  Created by Igor on 19.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//
//

#import "FavotitesEntity+CoreDataProperties.h"

@implementation FavotitesEntity (CoreDataProperties)

+ (NSFetchRequest<FavotitesEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"FavotitesEntity"];
}

@dynamic airline;
@dynamic departure;
@dynamic flightNumber;
@dynamic from;
@dynamic price;
@dynamic returnDate;
@dynamic to;
@dynamic type;

@end
