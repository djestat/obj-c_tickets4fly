//
//  PlaceCellModel.m
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "PlaceCellModel.h"
#import "Airport.h"
#import "City.h"

@interface PlaceCellModel ()

@property (nonatomic, strong) Airport* airport;
@property (nonatomic, strong) City* city;

@end

@implementation PlaceCellModel

+ (PlaceCellModel*) createWithAirport: (Airport*) airport {
    PlaceCellModel* cellModel = [PlaceCellModel new];
    cellModel.airport = airport;
    return cellModel;
}

+ (PlaceCellModel*) createWithCity: (City*) city {
    PlaceCellModel* cellModel = [PlaceCellModel new];
    cellModel.city = city;
    return cellModel;
}

- (CGFloat) heightInTableView: (UITableView*) tableView {
    return 50;
}

- (NSString*) placeName {
    if (nil != self.airport) {
        return self.airport.name;
    }
    
    if (nil != self.city) {
        return self.city.name;
    }
    
    return @"";
}

@end