//
//  RouteCellModel.m
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "RouteCellModel.h"
#import "Route.h"

#import "Ticket.h"

#import "DataBaseManager.h"

@interface RouteCellModel ()

@property (nonatomic, strong, readwrite) Ticket* ticket;

@property (nonatomic, strong, readwrite) NSNumber *price;
@property (nonatomic, strong, readwrite) NSString *airline;
@property (nonatomic, strong, readwrite) NSDate *departure;
@property (nonatomic, strong, readwrite) NSDate *expires;
@property (nonatomic, strong, readwrite) NSNumber *flightNumber;
@property (nonatomic, strong, readwrite) NSDate *returnDate;
@property (nonatomic, strong, readwrite) NSString *from;
@property (nonatomic, strong, readwrite) NSString *to;

@end


@implementation RouteCellModel

- (CGFloat) heightInTableView: (UITableView*) tableView {
    return 140;
}

+ (RouteCellModel*) createWith: (Route*) route {
    RouteCellModel* cellModel = [RouteCellModel new];
    cellModel.price = route.price;
    cellModel.airline = route.airline;
    cellModel.departure = route.departure;
    cellModel.expires = route.expires;
    cellModel.flightNumber = route.flightNumber;
    cellModel.returnDate = route.returnDate;
    cellModel.from = route.from;
    cellModel.to = route.to;
    
    NSLog(@"Airlines %@", route.airline);
    
    Ticket* ticket = [Ticket new];
    ticket.price = route.price;
    ticket.airline = route.airline;
    ticket.departure = route.departure;
    ticket.flightNumber = route.flightNumber;
    ticket.returnDate = route.returnDate;
    ticket.from = route.from;
    ticket.to = route.to;
    ticket.type = @"search";
    
    cellModel.ticket = ticket;
    
    return cellModel;
}

- (void)didSelect {
    [super didSelect];
    
    if (nil != self.ticket) {
//    if (nil != self.ticket && [self.delegate respondsToSelector: @selector(didSelectTicket:)]) {
        [self.delegate didSelectTicket: self.ticket];
        NSLog(@"Ticket not nil");
        
        Ticket* ticket = self.ticket;
//        NSMutableArray<Ticket*>* tickets = [NSMutableArray new];
//        [tickets addObject: ticket];
        [[DataBaseManager shared] saveTickets: ticket];
    }
    
    NSLog(@"Ticket did select");
}


@end
