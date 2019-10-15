//
//  APIManager.m
//  ticket4fly
//
//  Created by Igor on 10.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "APIManager.h"
#import "Route.h"
#import "MapPrice.h"
#import "Ticket.h"

#define API_TOKEN @"TOKEN"

@implementation APIManager

+ (APIManager*) shared {
    static APIManager* shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (void) orderRoute: (Route*) route completion: (APIManager_OrderRouteCompletion) completion {
    NSString* urlString = [NSString stringWithFormat: @"https://map.aviasales.ru/prices.json?origin_iata="];
    NSURL* url = [NSURL URLWithString: urlString];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: url];
    request.HTTPMethod = @"POST";
    
    NSDictionary* dictionary = [route dictionary];
    NSError* error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject: dictionary options: NSJSONWritingPrettyPrinted error: &error];
    request.HTTPBody = jsonData;
    
    NSLog(@"error %@", error);
    if (nil != error) {
        completion(NO);
        return;
    }
    
    NSLog(@"jsonData %@", [[NSString alloc] initWithData: jsonData encoding: NSUTF8StringEncoding]);
}

- (void) getMapPricesNear: (NSString*) IATA completion: (APIManager_GetMapPricesCompletion) completion {
    NSURLSession* session = [NSURLSession sharedSession];
    NSString* urlString = [NSString stringWithFormat: @"https://map.aviasales.ru/prices.json?origin_iata=%@", IATA];
    NSURL* url = [NSURL URLWithString: urlString];
    NSURLRequest* request = [NSURLRequest requestWithURL: url];
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSArray* json = nil;
        if (nil != data) {
            NSError* jsonError;
            json = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &jsonError];
        }

        NSMutableArray<MapPrice*>* prices = [NSMutableArray new];
        
        if ([json isKindOfClass: [NSArray class]]) {
            for (NSDictionary* dictionary in json) {
                if (NO == [dictionary isKindOfClass: [NSDictionary class]]) { continue; }
                MapPrice* object = [MapPrice createWithDictionary: dictionary];
                if (NO == [object isKindOfClass: [MapPrice class]]) { continue; }
                [prices addObject: object];
            }
        }

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(prices);
        }];
    }];
    [dataTask resume];
}

- (void) getTicketsFrom2: (NSString*) fromIATA to: (NSString*) toIATA completion: (APIManager_GetTicketsCompletion) completion {
    NSURLSession* session = [NSURLSession sharedSession];
    NSString* urlString = [NSString stringWithFormat: @"https://api.skypicker.com/flights?flyFrom=%@&to=%@&partner=picky", fromIATA, toIATA];

    NSURL* url = [NSURL URLWithString: urlString];
    NSURLRequest* request = [NSURLRequest requestWithURL: url];
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSDictionary* json = nil;
        if (nil != data) {
            NSError* jsonError;
            json = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &jsonError];
        }
        
        NSArray* routesDictionaries = nil;
        if ([json isKindOfClass: [NSDictionary class]]) {
            routesDictionaries = [json valueForKey: @"data"];
        }
        
        NSLog(@"%@", routesDictionaries);
        
        NSMutableArray<Route*>* routes = [NSMutableArray new];
        if ([routesDictionaries isKindOfClass: [NSArray class]]) {
            for (NSDictionary* routesDictionary in routesDictionaries) {
                if (NO == [routesDictionary isKindOfClass: [NSDictionary class]]) { continue; }
                Route* route = [Route createWithDictionary: routesDictionary];
                if (NO == [route isKindOfClass: [Route class]]) { continue; }
                [routes addObject: route];
            }
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(routes);
        }];
    }];
    [dataTask resume];
}

- (void) getTicketsFrom: (NSString*) fromIATA to: (NSString*) toIATA completion: (APIManager_GetTicketsCompletion) completion {
    NSURLSession* session = [NSURLSession sharedSession];
    NSString* urlString = [NSString stringWithFormat: @"https://api.travelpayouts.com/v1/prices/cheap?origin=%@&destination=%@&token=%@", fromIATA, toIATA, API_TOKEN];
    
#warning Replace with current date
//http://api.travelpayouts.com/v1/prices/direct?origin=MOW&destination=LED&depart_date=2017-11&return_date=2017-12&token=PutHereYourToken

    NSURL* url = [NSURL URLWithString: urlString];
    NSURLRequest* request = [NSURLRequest requestWithURL: url];
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSDictionary* json = nil;
        if (nil != data) {
            NSError* jsonError;
            json = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &jsonError];
        }

        NSDictionary* dataDictionary = nil;
        if ([json isKindOfClass: [NSDictionary class]]) {
            dataDictionary = [json valueForKey: @"data"];
        }
        
        NSDictionary* routesDictionaries = nil;
        if ([dataDictionary isKindOfClass: [NSDictionary class]]) {
            routesDictionaries = [dataDictionary valueForKey: toIATA];
        }
        
        NSLog(@"%@", routesDictionaries);
        NSLog(@"%lu", (unsigned long)routesDictionaries.count);

        NSMutableArray<Route*>* routes = [NSMutableArray new];
        if ([routesDictionaries isKindOfClass: [NSDictionary class]]) {
            for (int i = 0; i < routesDictionaries.count; i++) {
                Route* route = [Route createWithDictionary: [routesDictionaries valueForKey: [NSString stringWithFormat: @"%d", i]]];
                if (NO == [route isKindOfClass: [Route class]]) { continue; }
                [routes addObject: route];
            }
            
            for (int i = 0; i < routesDictionaries.count; i++) {
                Route* route = [[Route alloc] initWithDictionary: [routesDictionaries valueForKey: [NSString stringWithFormat: @"%d", i]]];
                route.from = fromIATA;
                route.to = toIATA;
                if (NO == [route isKindOfClass: [Route class]]) { continue; }
                [routes addObject: route];
            }
        }
        
        int i = 1;
        NSLog(@"%@", [routesDictionaries valueForKey: [NSString stringWithFormat: @"%d", i]]);
        NSLog(@"%lu", (unsigned long)routes.count);
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(routes);
        }];
    }];
    [dataTask resume];
}

@end
