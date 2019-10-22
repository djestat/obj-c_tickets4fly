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
#import "AirportEntity+CoreDataProperties.h"
#import "FavotitesEntity+CoreDataProperties.h"

@interface DataBaseManager () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSPersistentContainer* container;

@property (nonatomic, strong) NSFetchedResultsController* citiesSearchFetchedResultsController;
@property (nonatomic, strong) NSFetchedResultsController* airportsSearchFetchedResultsController;

@property (nonatomic, strong) NSFetchedResultsController* favoriteTicketsFetchedResultsController;

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
        
        shared.container = [NSPersistentContainer persistentContainerWithName: @"DataBaseModel"];
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

- (NSFetchedResultsController *) airportsSearchFetchedResultsController {
    if (nil == _airportsSearchFetchedResultsController) {
        NSFetchRequest *fetchRequest = [AirportEntity fetchRequest];
        fetchRequest.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey: @"name" ascending: YES] ];
         
        NSManagedObjectContext* context = self.container.viewContext;
        self.airportsSearchFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: fetchRequest
                                                                                        managedObjectContext: context
                                                                                          sectionNameKeyPath: nil
                                                                                                   cacheName: nil];
        
        // Configure Fetched Results Controller
        [self.airportsSearchFetchedResultsController setDelegate: self];
    }
    return _airportsSearchFetchedResultsController;
}

- (NSFetchedResultsController *) favoriteTicketsFetchedResultsController {
    if (nil == _favoriteTicketsFetchedResultsController) {
        NSFetchRequest *fetchRequest = [FavotitesEntity fetchRequest];
        fetchRequest.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey: @"price" ascending: YES] ];
         
        NSManagedObjectContext* context = self.container.viewContext;
        self.favoriteTicketsFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: fetchRequest
                                                                                        managedObjectContext: context
                                                                                          sectionNameKeyPath: nil
                                                                                                   cacheName: nil];
        
        // Configure Fetched Results Controller
        [self.favoriteTicketsFetchedResultsController setDelegate: self];
    }
    return _favoriteTicketsFetchedResultsController;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controller: (NSFetchedResultsController *)controller
  didChangeSection: (id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex: (NSUInteger)sectionIndex
     forChangeType: (NSFetchedResultsChangeType)type {
    
}

#pragma mark - Cities

- (void) updateCities: (NSString*) query {
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

#pragma mark - Airports

- (void) updateAirports: (NSString*) query {
    [self.airportsSearchFetchedResultsController performFetch: nil];
}

- (void) requestAirports {
    [self.airportsSearchFetchedResultsController performFetch: nil];
}

- (void) saveAirports: (NSArray<Airport*>*) airports {
    [self.container performBackgroundTask:^(NSManagedObjectContext * context) {
        
        for (Airport* airport in airports) {
            [AirportEntity createFrom: airport context: context];
        }
        
        NSError* error = nil;
        [context save: &error];
        NSLog(@"saveAirports, error %@", error);
    }];
}

- (void) loadAirportsWithQuery: (nullable NSString*) query completiom: (DataBaseManager_AirportsCompletion) completion {
    
    
    [self.container performBackgroundTask:^(NSManagedObjectContext * context) {
        NSFetchRequest* fetchRequest = [AirportEntity fetchRequest];
        if (nil != query && query.length > 0) {
            NSPredicate* namePredicate = [NSPredicate predicateWithFormat: @"name CONTAINS[c] %@", query];
            NSPredicate* codePredicate = [NSPredicate predicateWithFormat: @"code CONTAINS[c] %@", query];
            fetchRequest.predicate = [NSCompoundPredicate orPredicateWithSubpredicates: @[namePredicate, codePredicate]];
        }
        
        fetchRequest.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey: @"name" ascending: YES] ];
        
        NSError* error = nil;
        NSArray* result = [context executeFetchRequest: fetchRequest error: &error];
        NSLog(@"%s %@", __FUNCTION__, error);
        
        NSMutableArray* airports = [NSMutableArray new];
        for (AirportEntity* entity in result) {
            if (NO == [entity isKindOfClass: [AirportEntity class]]) { continue; }
            Airport* airport = [entity create];
            [airports addObject: airport];
        }
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(airports);
        }];
    }];
}

#pragma mark - Favorites Tickets

- (void) saveTickets: (Ticket*) ticket {
    [self.container performBackgroundTask:^(NSManagedObjectContext * context) {
        
        [FavotitesEntity createFrom: ticket context: context];

        NSLog(@"saveTickets, FavotitesEntity createFrom %@", ticket);
        
        NSError* error = nil;
        [context save: &error];
        NSLog(@"saveTickets, error %@", error);
    }];
}

- (void) loadFavoritesTickets:(nullable NSString *)query completiom:(DataBaseManager_TicketsCompletion)completion {
    
    
    [self.container performBackgroundTask:^(NSManagedObjectContext * context) {
        NSFetchRequest* fetchRequest = [FavotitesEntity fetchRequest];
        if (nil != query && query.length > 0) {
            NSPredicate* typePredicate = [NSPredicate predicateWithFormat: @"type CONTAINS[c] %@", query];
            fetchRequest.predicate = typePredicate;
        }
        
        fetchRequest.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey: @"price" ascending: YES] ];
        
        NSError* error = nil;
        NSArray* result = [context executeFetchRequest: fetchRequest error: &error];
        NSLog(@"%s %@", __FUNCTION__, error);
        
        NSMutableArray* tickets = [NSMutableArray new];
        for (FavotitesEntity* entity in result) {
            if (NO == [entity isKindOfClass: [FavotitesEntity class]]) { continue; }
            Ticket* ticket = [entity create];
            [tickets addObject: ticket];
        }
        NSLog(@"loadFavoritesTickets count %ld", tickets.count);
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(tickets);
        }];
    }];
}


#pragma mark - File db SQLite


+ (NSURL*) dbFile {
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [searchPaths firstObject];
    
    NSString* filePath = [documentPath stringByAppendingPathComponent: @"ticket4fly.sqlite"];
    
    /*
    if (NO == [[NSFileManager defaultManager] fileExistsAtPath: filePath]) {
        
        NSError* error = nil;
        
        NSString* sqliteFile = [[NSBundle mainBundle] pathForResource: @"ticket4fly" ofType: @"sqlite"];
        [[NSFileManager defaultManager] copyItemAtPath: sqliteFile toPath: filePath error: &error];
        NSLog(@"Copy ticket4fly.sqlite %@", error);
        
        NSString* sqliteWalFile = [[NSBundle mainBundle] pathForResource: @"ticket4fly" ofType: @"sqlite-wal"];
        NSString* walFilePath = [documentPath stringByAppendingPathComponent: @"ticket4fly.sqlite-wal"];
        [[NSFileManager defaultManager] copyItemAtPath: sqliteWalFile toPath: walFilePath error: &error];
        NSLog(@"Copy ticket4fly.sqlite-wal %@", error);
    }*/
    
    return [NSURL fileURLWithPath: filePath];
}

@end
