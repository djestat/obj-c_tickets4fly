//
//  RouteCellModel.m
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "RouteCellModel.h"
#import "Route.h"

@interface RouteCellModel ()

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
    return cellModel;
}

@end
