//
//  FavotitesEntity+CoreDataProperties.h
//  ticket4fly
//
//  Created by Igor on 29/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//
//

#import "FavotitesEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FavotitesEntity (CoreDataProperties)

+ (NSFetchRequest<FavotitesEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *fromCity;
@property (nullable, nonatomic, copy) NSString *toCity;

@end

NS_ASSUME_NONNULL_END
