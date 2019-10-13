//
//  DataBaseManager.m
//  ticket4fly
//
//  Created by Igor on 29/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "DataBaseManager.h"

#import <CoreData/CoreData.h>

#import "CityEntity+CoreDataProperties.h"

@interface DataBaseManager () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSPersistentContainer* container;

@property (nonatomic, strong) NSFetchedResultsController* citiesSearchFetchedResultsController;

@property (nonatomic, strong) NSFetchedResultsController* favoritesFetchedResultsController;

@end


@implementation DataBaseManager 

+ (DataBaseManager*) shared {
    static DataBaseManager* shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
        
        NSURL* fileURL = [DataBaseManager dbFile];
        NSLog(@"fileURL %@", fileURL);
        
        NSPersistentStoreDescription* storeDescription = [NSPersistentStoreDescription persistentStoreDescriptionWithURL: fileURL];
        
        shared.container = [NSPersistentContainer persistentContainerWithName: @"ticket4fly"];
        shared.container.persistentStoreDescriptions = @[storeDescription];
        
        [shared.container loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * storeDescription, NSError * error) {
            
        }];
    });
    return shared;
}

- (NSFetchedResultsController *)citiesSearchFetchedResultsController {
    if (nil == _citiesSearchFetchedResultsController) {
        NSFetchRequest *fetchRequest = [CityEntity fetchRequest];
        fetchRequest.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey: @"name" ascending: YES] ];
         
        NSManagedObjectContext* context = self.container.viewContext;
        self.citiesSearchFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: fetchRequest
                                                                                        managedObjectContext: context
                                                                                          sectionNameKeyPath: nil
                                                                                                   cacheName: nil];
        
        // Configure Fetched Results Controller
        [self.citiesSearchFetchedResultsController setDelegate: self];
    }
    return _citiesSearchFetchedResultsController;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controller: (NSFetchedResultsController *)controller
  didChangeSection: (id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex: (NSUInteger)sectionIndex
     forChangeType: (NSFetchedResultsChangeType)type {
    
}

#pragma mark - Cities

- (void) update: (NSString*) query {
    [self.citiesSearchFetchedResultsController performFetch: nil];
}

- (void) requestCities {
    [self.citiesSearchFetchedResultsController performFetch: nil];
}

- (void) saveCities: (NSArray<City*>*) cities {
    
    [self.container performBackgroundTask:^(NSManagedObjectContext * context) {
        
        for (City* city in cities) {
            [CityEntity createFrom: city context: context];
        }
        
        NSError* error = nil;
        [context save: &error];
        NSLog(@"saveCities, error %@", error);
    }];
}

- (void) loadCitiesWithQuery: (nullable NSString*) query completiom: (DataBaseManager_CitiesCompletion) completion {
    
    
    [self.container performBackgroundTask:^(NSManagedObjectContext * context) {
        NSFetchRequest* fetchRequest = [CityEntity fetchRequest];
        if (nil != query && query.length > 0) {
            NSPredicate* namePredicate = [NSPredicate predicateWithFormat: @"name CONTAINS[c] %@", query];
            NSPredicate* codePredicate = [NSPredicate predicateWithFormat: @"code CONTAINS[c] %@", query];
            fetchRequest.predicate = [NSCompoundPredicate orPredicateWithSubpredicates: @[namePredicate, codePredicate]];
        }
        
        fetchRequest.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey: @"name" ascending: YES] ];
        
        NSError* error = nil;
        NSArray* result = [context executeFetchRequest: fetchRequest error: &error];
        NSLog(@"%s %@", __FUNCTION__, error);
        
        NSMutableArray* cities = [NSMutableArray new];
        for (CityEntity* entity in result) {
            if (NO == [entity isKindOfClass: [CityEntity class]]) { continue; }
            City* city = [entity create];
            [cities addObject: city];
        }
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(cities);
        }];
    }];
}


// MARK: -

+ (NSURL*) dbFile {
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [searchPaths firstObject];
    
    NSString* filePath = [documentPath stringByAppendingPathComponent: @"ticket4fly.sqlite"];
    
    
    if (NO == [[NSFileManager defaultManager] fileExistsAtPath: filePath]) {
        
        NSError* error = nil;
        
        NSString* sqliteFile = [[NSBundle mainBundle] pathForResource: @"ticket4fly" ofType: @"sqlite"];
        [[NSFileManager defaultManager] copyItemAtPath: sqliteFile toPath: filePath error: &error];
        NSLog(@"Copy ticket4fly.sqlite %@", error);
        
        NSString* sqliteWalFile = [[NSBundle mainBundle] pathForResource: @"ticket4fly" ofType: @"sqlite-wal"];
        NSString* walFilePath = [documentPath stringByAppendingPathComponent: @"ticket4fly.sqlite-wal"];
        [[NSFileManager defaultManager] copyItemAtPath: sqliteWalFile toPath: walFilePath error: &error];
        NSLog(@"Copy ticket4fly.sqlite-wal %@", error);
    }
    
    return [NSURL fileURLWithPath: filePath];
}

@end
