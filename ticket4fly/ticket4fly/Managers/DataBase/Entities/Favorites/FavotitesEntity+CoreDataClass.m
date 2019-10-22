//
//  FavotitesEntity+CoreDataClass.m
//  ticket4fly
//
//  Created by Igor on 29/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//
//

#import "FavotitesEntity+CoreDataClass.h"

#import "Ticket.h"


@implementation FavotitesEntity

- (Ticket*) create {
    Ticket* ticket = [Ticket new];
    
    ticket.price = @(self.price);
    ticket.airline = self.airline;
    ticket.departure = self.departure;
    ticket.flightNumber = @(self.flightNumber);
    ticket.returnDate = self.returnDate;
    ticket.from = self.from;
    ticket.to = self.to;
    
    ticket.type = self.type;

    return ticket;
}

+ (FavotitesEntity*) createFrom: (Ticket*) ticket context: (NSManagedObjectContext*) context {
    
    FavotitesEntity* entity = nil;
    
    NSLog(@"FavotitesEntity createFrom %@", ticket.type);
    
    NSFetchRequest<FavotitesEntity *> * fetchRequest = [FavotitesEntity fetchRequest];
    fetchRequest.predicate = [NSPredicate predicateWithFormat: @"flightNumber == %@", ticket.flightNumber];
    fetchRequest.fetchLimit = 1;
    
    NSError* error = nil;
    NSArray* result = [context executeFetchRequest: fetchRequest error: &error];
    entity = [result firstObject];
    
    if (nil == entity) {
        entity = [NSEntityDescription insertNewObjectForEntityForName: @"FavotitesEntity" inManagedObjectContext: context];
        
        entity.price = [ticket.price doubleValue];
        entity.airline = ticket.airline;
        entity.departure = ticket.departure;
        entity.flightNumber = [ticket.flightNumber doubleValue];
        entity.returnDate = ticket.returnDate;
        entity.from = ticket.from;
        entity.to = ticket.to;
        
        entity.type = ticket.type;
    }
    
    return entity;
}

@end
