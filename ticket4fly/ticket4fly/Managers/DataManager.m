//
//  DataManager.m
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "DataManager.h"

#import "DataBaseManager.h"

@interface DataManager ()

@property (nonatomic, strong, readwrite) NSArray<Country*>* countries;
@property (nonatomic, strong, readwrite) NSArray<City*>* cities;
@property (nonatomic, strong, readwrite) NSArray<Airport*>* airports;

@end


@implementation DataManager

+ (DataManager*) shared {
    static DataManager* shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (NSNotificationName) didLoadCountriesNotificationName {
    return @"DataManager_didLoadCountriesNotificationName";
}

- (NSNotificationName) didLoadCitiesNotificationName {
    return @"DataManager_didLoadCitiesNotificationName";
}

- (NSNotificationName) didLoadAirportsNotificationName {
    return @"DataManager_didLoadAirportsNotificationName";
}

- (void) loadData {
     dispatch_async(dispatch_get_global_queue( QOS_CLASS_UTILITY, 0), ^(void){
           [self loadCountries];
       });

       dispatch_async(dispatch_get_global_queue( QOS_CLASS_UTILITY, 0), ^(void){
           [self loadCities];
       });
       
       dispatch_async(dispatch_get_global_queue( QOS_CLASS_UTILITY, 0), ^(void){
           [self loadAirports];
       });
}

- (void) loadAirports {
    [[DataBaseManager shared] loadAirportsWithQuery: nil completiom:^(NSArray<Airport *> * airports) {
        self.airports = airports;
        [self.delegate didReceivedAirports];
    }];
    
    NSString* fileName = @"Airports";
    
    NSMutableArray<Airport*>* airports = [NSMutableArray new];
    NSArray* json = [self jsonFromFileName: fileName];
    if ([json isKindOfClass: [NSArray class]]) {
        for (NSDictionary* dictionary in json) {
            if (NO == [dictionary isKindOfClass: [NSDictionary class]]) { continue; }
            Airport* airport = [Airport createWithDictionary: dictionary];
            if (nil != airport) {
                [airports addObject: airport];
            }
        }
    } else {
        NSLog(@"Wrong data in %@: %@", fileName, json);
    }
    
    self.airports = airports;
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"postNotificationName %@", [self didLoadAirportsNotificationName]);
//        [[NSNotificationCenter defaultCenter] postNotificationName: [self didLoadAirportsNotificationName] object: nil];
        [self.delegate didReceivedAirports];
    });
    
    [[DataBaseManager shared] saveAirports: airports];

}

- (void) loadCities {
    [[DataBaseManager shared] loadCitiesWithQuery: nil completiom:^(NSArray<City *> * cities) {
        self.cities = cities;
        [self.delegate didReceivedCities];
    }];
    
        NSString* fileName = @"Cities";
    
        NSMutableArray<City*>* cities = [NSMutableArray new];
        NSArray* json = [self jsonFromFileName: fileName];
        if ([json isKindOfClass: [NSArray class]]) {
            for (NSDictionary* dictionary in json) {
                if (NO == [dictionary isKindOfClass: [NSDictionary class]]) { continue; }
                City* city = [City createWithDictionary: dictionary];
                if (nil != city) {
                    [cities addObject: city];
                }
            }
        } else {
            NSLog(@"Wrong data in %@: %@", fileName, json);
        }
    
        self.cities = cities;
    
        dispatch_async(dispatch_get_main_queue(), ^{
            //NSLog(@"postNotificationName %@", [self didLoadCitiesNotificationName]);
            //[[NSNotificationCenter defaultCenter] postNotificationName: [self didLoadCitiesNotificationName] object: nil];
    
            [self.delegate didReceivedCities];
        });
    
        [[DataBaseManager shared] saveCities: cities];
}

- (void) loadCountries {
    
    NSString* fileName = @"Countries";
    
    NSMutableArray<Country*>* countries = [NSMutableArray new];
    NSArray* json = [self jsonFromFileName: fileName];
    if ([json isKindOfClass: [NSArray class]]) {
        for (NSDictionary* dictionary in json) {
            if (NO == [dictionary isKindOfClass: [NSDictionary class]]) { continue; }
            Country* country = [Country createWithDictionary: dictionary];
            if (nil != country) {
                [countries addObject: country];
            }
        }
    } else {
        NSLog(@"Wrong data in %@: %@", fileName, json);
    }
    
    self.countries = countries;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"postNotificationName %@", [self didLoadCountriesNotificationName]);
        [[NSNotificationCenter defaultCenter] postNotificationName: [self didLoadCountriesNotificationName] object: nil];
    });
}

- (nullable NSArray<NSDictionary*>*) jsonFromFileName: (NSString*) fileName {
    NSString* filePath = [[NSBundle mainBundle] pathForResource: fileName ofType: @"json"];
    
    NSData* fileData = nil;
    if (nil != filePath) {
        fileData = [NSData dataWithContentsOfFile: filePath];
    } else {
        NSLog(@"No file %@", fileName);
    }
    
    NSArray* json = nil;
    if (nil != fileData) {
        NSError* jsonError;
        json = [NSJSONSerialization JSONObjectWithData: fileData options: NSJSONReadingMutableContainers error: &jsonError];
        if(jsonError) {
            NSLog(@"json error : %@ in %@", [jsonError localizedDescription], fileName);
        }
    } else {
        NSLog(@"No data in %@", fileName);
    }
    
    if ([json isKindOfClass: [NSArray class]]) {
        return  json;
    }
    
    return nil;
}

@end
