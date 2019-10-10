//
//  APIManagerV2.m
//  ticket4fly
//
//  Created by Igor on 10.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "APIManagerV2.h"
#import "Ticket.h"

#define API_TOKEN @"<<ПОЛУЧЕННЫЙ ТОКЕН>>"
#define API_URL_CHEAP @"https://api.travelpayouts.com/v1/prices/cheap"

@interface APIManagerV2 ()

@end

@implementation APIManagerV2

+ (instancetype)sharedInstance {
    static APIManagerV2 *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[APIManagerV2 alloc] init];
    });
    return instance;
}

- (void)load:(NSString *)urlString withCompletion:(void (^)(id _Nullable result))completion {
    dispatch_async(dispatch_get_main_queue(), ^{
       [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    });
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        });
        completion([NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]);
    }] resume] ;
}

- (void)ticketsWithRequest:(SearchRequest)request withCompletion:(void (^)(NSArray *tickets))completion {
    NSString *urlString = [NSString stringWithFormat:@"%@?%@&token=%@", API_URL_CHEAP, SearchRequestQuery(request), API_TOKEN];
    [self load:urlString withCompletion:^(id  _Nullable result) {
        NSDictionary *response = result;
        if (response) {
            NSDictionary *json = [[response valueForKey:@"data"] valueForKey:request.destionation];
            NSMutableArray *array = [NSMutableArray new];
            for (NSString *key in json) {
                NSDictionary *value = [json valueForKey: key];
                Ticket *ticket = [[Ticket alloc] initWithDictionary:value];
                ticket.from = request.origin;
                ticket.to = request.destionation;
                [array addObject:ticket];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(array);
            });
        }
    }];
}

NSString * SearchRequestQuery(SearchRequest request) {
    NSString *result = [NSString stringWithFormat:@"origin=%@&destination=%@", request.origin, request.destionation];
    if (request.departDate && request.returnDate) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM";
        result = [NSString stringWithFormat:@"%@&depart_date=%@&return_date=%@", result, [dateFormatter stringFromDate:request.departDate], [dateFormatter stringFromDate:request.returnDate]];
    }
    return result;
}

@end
