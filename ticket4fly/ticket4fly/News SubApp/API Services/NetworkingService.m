//
//  NetworkingService.m
//  ticket4fly
//
//  Created by Igor on 17/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "NetworkingService.h"
#import "News.h"

@implementation NetworkingService

+ (NetworkingService*) shared {
    static NetworkingService* shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (void) getNews: (NewsApi_GetNewssCompletion) completion {
    NSURLSession* session = [NSURLSession sharedSession];
    NSString* urlString = [NSString stringWithFormat: @"https://newsapi.org/v2/top-headlines?country=ru&apiKey=3360a255ef2440e7934aaa1903e1e5af"];
    NSURL* url = [NSURL URLWithString: urlString];
    NSURLRequest* request = [NSURLRequest requestWithURL: url];
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSDictionary* json = nil;
        if (nil != data) {
            NSError* jsonError;
            json = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &jsonError];
        }
        
        NSArray* newsDictionaries = nil;
        if ([json isKindOfClass: [NSDictionary class]]) {
            newsDictionaries = [json valueForKey: @"articles"];
        }
        
        NSMutableArray<News*>* news = [NSMutableArray new];
        if ([newsDictionaries isKindOfClass: [NSArray class]]) {
            for (NSDictionary* newsDictionary in newsDictionaries) {
                if (NO == [newsDictionary isKindOfClass: [NSDictionary class]]) { continue; }
                News* oneNews = [News createWithDictionary: newsDictionary];
                if (NO == [oneNews isKindOfClass: [News class]]) { continue; }
                [news addObject: oneNews];
            }
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(news);
        }];
    }];
    [dataTask resume];
}
@end
