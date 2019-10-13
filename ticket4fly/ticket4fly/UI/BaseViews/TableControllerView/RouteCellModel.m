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

@property (nonatomic, strong, readwrite) NSString* info;

@property (nonatomic, strong) UIImageView *airlineLogoView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *placesLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@end


@implementation RouteCellModel

- (CGFloat) heightInTableView: (UITableView*) tableView {
    return 140;
}

+ (RouteCellModel*) createWith: (Route*) route {
    RouteCellModel* cellModel = [RouteCellModel new];
    cellModel.info = [NSString stringWithFormat: @"%@ - %@", route.price, route.airline];
    NSLog(@"%@", route.airline);
    return cellModel;
}

@end
