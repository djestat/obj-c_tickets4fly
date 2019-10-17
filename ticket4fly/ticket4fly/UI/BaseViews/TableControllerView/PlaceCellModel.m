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
        return [NSString stringWithFormat: @"%@", self.airport.name];
    }
    
    if (nil != self.city) {
        return [NSString stringWithFormat: @"%@", self.city.name];
    }
    
    return @"";
}

- (NSString*) placeCode {
    if (nil != self.airport) {
        return [NSString stringWithFormat: @"Airport code [%@]", self.airport.code];
    }
    
    if (nil != self.city) {
        return [NSString stringWithFormat: @"City code [%@]", self.city.code];
    }
    
    return @"";
}

- (void)didSelect {
    [super didSelect];
    
    if (nil != self.airport && [self.delegate respondsToSelector: @selector(didSelectAirport:)]) {
        [self.delegate didSelectAirport: self.airport];
    } else if (nil != self.city && [self.delegate respondsToSelector: @selector(didSelectCity:)]) {
        [self.delegate didSelectCity: self.city];
    }
}

@end
