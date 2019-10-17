//
//  AirportEntity+CoreDataClass.m
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//
//

#import "AirportEntity+CoreDataClass.h"
#import "TranslationEntity+CoreDataProperties.h"

#import "Airport.h"

@implementation AirportEntity

- (Airport*) create {
    Airport* airport = [Airport new];
    
    airport.code = self.code;
    airport.name = self.name;
    
    airport.timeZone = self.timeZone;
    airport.countryCode = self.countryCode;
    airport.cityCode = self.cityCode;
    
    airport.lat = @(self.lat);
    airport.lon = @(self.lon);
    
    NSMutableDictionary* translations = [NSMutableDictionary new];
    for (TranslationEntity* translationEntity in [self.translations allObjects]) {
        [translations setValue: translationEntity.value forKey: translationEntity.key];
    }
    
    airport.translations = translations;
    
    return airport;
}

+ (AirportEntity*) createFrom: (Airport*) airport context: (NSManagedObjectContext*) context {
    
    AirportEntity* entity = nil;
    
    NSFetchRequest<AirportEntity *> * fetchRequest = [AirportEntity fetchRequest];
    fetchRequest.predicate = [NSPredicate predicateWithFormat: @"code == %@", airport.code];
    fetchRequest.fetchLimit = 1;
    
    NSError* error = nil;
    NSArray* result = [context executeFetchRequest: fetchRequest error: &error];
    entity = [result firstObject];
    
    if (nil == entity) {
        entity = [NSEntityDescription insertNewObjectForEntityForName: @"AirportEntity" inManagedObjectContext: context];
        
        entity.code = airport.code;
        entity.name = airport.name;
        
        entity.timeZone = airport.timeZone;
        entity.countryCode = airport.countryCode;
        entity.cityCode = airport.cityCode;

        entity.lon = [airport.lon doubleValue];
        entity.lat = [airport.lat doubleValue];
        
        for (NSString* key in airport.translations.allKeys) {
            NSString* value = [airport.translations objectForKey: key];
            
            TranslationEntity* translationEntity = [NSEntityDescription insertNewObjectForEntityForName: @"TranslationEntity" inManagedObjectContext: context];
            translationEntity.key = key;
            translationEntity.value = value;
            
            translationEntity.airport = entity;
        }
    }
    
    return entity;
}

@end
