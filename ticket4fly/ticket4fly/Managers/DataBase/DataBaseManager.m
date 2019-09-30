//
//  DataBaseManager.m
//  ticket4fly
//
//  Created by Igor on 29/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "DataBaseManager.h"

#import <CoreData/CoreData.h>

@interface DataBaseManager () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSPersistentContainer* container;
@property (nonatomic, strong) NSFetchedResultsController* favoritesFetchedResultsController;

@end


@implementation DataBaseManager 

@end
