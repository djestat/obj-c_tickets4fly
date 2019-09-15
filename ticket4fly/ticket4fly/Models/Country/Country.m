//
//  Country.m
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "Country.h"


@interface Country ()

@property (nonatomic, strong, readwrite) NSString     *name;
@property (nonatomic, strong, readwrite) NSString     *currency;
@property (nonatomic, strong, readwrite) NSDictionary *translations;
@property (nonatomic, strong, readwrite) NSString     *code;

@end

@implementation Country

+ (nullable Country*) createWithDictionary: (NSDictionary*) dictionary; {
    NSString* name = [dictionary objectForKey: @"name"];
    if (NO == [name isKindOfClass: [NSString class]]) { return nil; }
    
    NSString* currency = [dictionary objectForKey: @"currency"];
    if (NO == [currency isKindOfClass: [NSString class]]) { return nil; }
    
    NSString* code = [dictionary objectForKey: @"code"];
    if (NO == [code isKindOfClass: [NSString class]]) { return nil; }
    
    NSDictionary* translations = [dictionary objectForKey: @"name_translations"];
    if (NO == [translations isKindOfClass: [NSDictionary class]]) { return nil; }
    
    Country* country = [Country new];
    country.name = name;
    country.currency = currency;
    country.code = code;
    country.translations = translations;
    
    return country;
}

- (NSString *)description {
    NSMutableString* description = [NSMutableString new];
    [description appendString: [super description]];
    
    [description appendFormat: @"\n name = %@", self.name];
    [description appendFormat: @"\n currency = %@", self.currency];
    [description appendFormat: @"\n code = %@", self.code];
    [description appendFormat: @"\n translations = %@", self.translations];
    
    return description;
}

@end
