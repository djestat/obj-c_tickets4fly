//
//  CityEntity+CoreDataClass.m
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//
//

#import "CityEntity+CoreDataClass.h"
#import "TranslationEntity+CoreDataProperties.h"

#import "City.h"

@implementation CityEntity

- (City*) create {
    City* city = [City new];
    
    city.code = self.code;
    city.name = self.name;
    
    city.timeZone = self.timeZone;
    city.countryCode = self.countryCode;
    
    city.lat = @(self.lat);
    city.lon = @(self.lon);
    
    NSMutableDictionary* translations = [NSMutableDictionary new];
    for (TranslationEntity* translationEntity in [self.translations allObjects]) {
        [translations setValue: translationEntity.value forKey: translationEntity.key];
    }
    
    city.translations = translations;
    
    return city;
}

+ (CityEntity*) createFrom: (City*) city context: (NSManagedObjectContext*) context {
    
    CityEntity* entity = nil;
    
    NSFetchRequest<CityEntity *> * fetchRequest = [CityEntity fetchRequest];
    fetchRequest.predicate = [NSPredicate predicateWithFormat: @"code == %@", city.code];
    fetchRequest.fetchLimit = 1;
    
    NSError* error = nil;
    NSArray* result = [context executeFetchRequest: fetchRequest error: &error];
    entity = [result firstObject];
    
    if (nil == entity) {
        entity = [NSEntityDescription insertNewObjectForEntityForName: @"CityEntity" inManagedObjectContext: context];
        
        entity.code = city.code;
        entity.name = city.name;
        
        entity.timeZone = city.timeZone;
        entity.countryCode = city.countryCode;
        
        entity.lon = [city.lon doubleValue];
        entity.lat = [city.lat doubleValue];
        
        for (NSString* key in city.translations.allKeys) {
            NSString* value = [city.translations objectForKey: key];
            
            TranslationEntity* translationEntity = [NSEntityDescription insertNewObjectForEntityForName: @"TranslationEntity" inManagedObjectContext: context];
            translationEntity.key = key;
            translationEntity.value = value;
            
            translationEntity.city = entity;
        }
    }
    
    return entity;
}

@end
