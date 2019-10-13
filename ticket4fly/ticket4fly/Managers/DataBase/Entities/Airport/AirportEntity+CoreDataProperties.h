//
//  AirportEntity+CoreDataProperties.h
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//
//

#import "AirportEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AirportEntity (CoreDataProperties)

+ (NSFetchRequest<AirportEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *cityCode;
@property (nullable, nonatomic, copy) NSString *code;
@property (nullable, nonatomic, copy) NSString *countryCode;
@property (nonatomic) double lat;
@property (nonatomic) double lon;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *timeZone;
@property (nullable, nonatomic, retain) TranslationEntity *translations;

@end

NS_ASSUME_NONNULL_END
