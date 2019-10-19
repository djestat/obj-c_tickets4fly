//
//  FavotitesEntity+CoreDataProperties.h
//  ticket4fly
//
//  Created by Igor on 19.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//
//

#import "FavotitesEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FavotitesEntity (CoreDataProperties)

+ (NSFetchRequest<FavotitesEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *airline;
@property (nullable, nonatomic, copy) NSDate *departure;
@property (nonatomic) double flightNumber;
@property (nullable, nonatomic, copy) NSString *from;
@property (nonatomic) double price;
@property (nullable, nonatomic, copy) NSDate *returnDate;
@property (nullable, nonatomic, copy) NSString *to;
@property (nullable, nonatomic, copy) NSString *type;

@end

NS_ASSUME_NONNULL_END
