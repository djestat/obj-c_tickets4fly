//
//  TranslationEntity+CoreDataProperties.m
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//
//

#import "TranslationEntity+CoreDataProperties.h"

@implementation TranslationEntity (CoreDataProperties)

+ (NSFetchRequest<TranslationEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"TranslationEntity"];
}

@dynamic key;
@dynamic value;
@dynamic airport;
@dynamic city;

@end
