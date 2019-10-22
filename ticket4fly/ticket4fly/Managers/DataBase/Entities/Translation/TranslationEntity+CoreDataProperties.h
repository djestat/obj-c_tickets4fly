//
//  TranslationEntity+CoreDataProperties.h
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//
//

#import "TranslationEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TranslationEntity (CoreDataProperties)

+ (NSFetchRequest<TranslationEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *key;
@property (nullable, nonatomic, copy) NSString *value;
@property (nullable, nonatomic, retain) AirportEntity *airport;
@property (nullable, nonatomic, retain) CityEntity *city;

@end

NS_ASSUME_NONNULL_END
