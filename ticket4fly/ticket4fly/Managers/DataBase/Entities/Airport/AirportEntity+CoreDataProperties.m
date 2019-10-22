//
//  AirportEntity+CoreDataProperties.m
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//
//

#import "AirportEntity+CoreDataProperties.h"

@implementation AirportEntity (CoreDataProperties)

+ (NSFetchRequest<AirportEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"AirportEntity"];
}

@dynamic cityCode;
@dynamic code;
@dynamic countryCode;
@dynamic lat;
@dynamic lon;
@dynamic name;
@dynamic timeZone;
@dynamic translations;

@end
