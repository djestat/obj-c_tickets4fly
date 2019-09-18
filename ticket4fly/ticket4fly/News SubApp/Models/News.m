//
//  News.m
//  ticket4fly
//
//  Created by Igor on 17/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "News.h"

@interface News ()

@property (nonatomic, strong, readwrite) NSString* name;
@property (nonatomic, strong, readwrite) NSString* title;
@property (nonatomic, strong, readwrite) NSString* descript;
@property (nonatomic, strong, readwrite) NSString* urlToImage;

@end

@implementation News

+ (nullable News*) createWithDictionary: (NSDictionary*) dictionary {
    
    NSDictionary* source = [dictionary objectForKey: @"source"];
    if (NO == [source isKindOfClass: [NSDictionary class]]) {
        NSLog(@"News wrong source %@", source);
        return nil;
    }
    
    NSString* name = [source objectForKey: @"name"];
    if (NO == [name isKindOfClass: [NSString class]]) {
        NSLog(@"News wrong name %@", name);
        return nil;
    }
    
    NSString* title = [dictionary objectForKey: @"title"];
    if (NO == [title isKindOfClass: [NSString class]]) {
        NSLog(@"News wrong title %@", title);
        return nil;
    }
    
    NSString* descript = [dictionary objectForKey: @"description"];
    if (NO == [descript isKindOfClass: [NSString class]]) {
        NSLog(@"News wrong description %@", descript);
        return nil;
    }
    
    NSString* urlToImage = [dictionary objectForKey: @"urlToImage"];
    if (NO == [urlToImage isKindOfClass: [NSString class]]) {
        NSLog(@"News wrong urlToImage %@", urlToImage);
        return nil;
    }
    
    News* news = [News new];
    news.name = name;
    news.title = title;
    news.descript = descript;
    news.urlToImage = urlToImage;
    return news;
}

@end

