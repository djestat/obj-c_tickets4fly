//
//  CityEntity+CoreDataProperties.m
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//
//

#import "CityEntity+CoreDataProperties.h"

@implementation CityEntity (CoreDataProperties)

+ (NSFetchRequest<CityEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"CityEntity"];
}

@dynamic code;
@dynamic countryCode;
@dynamic lat;
@dynamic lon;
@dynamic name;
@dynamic timeZone;
@dynamic translations;

@end
