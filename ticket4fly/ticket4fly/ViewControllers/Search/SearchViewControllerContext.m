//
//  SearchViewControllerContext.m
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "SearchViewControllerContext.h"
#import "SearchViewController.h"

#import "Airport.h"
#import "City.h"

@implementation SearchViewControllerContext

- (nullable UIViewController*) viewController {
    
    SearchViewController* viewController = [SearchViewController new];
    viewController.fromIATA = @"DME";
    viewController.toIATA = @"DXB";
    return viewController;
     
/*
     if (self.fromAirport == nil && self.fromCity == nil) {
     return nil;
     }
     
     if (self.toAirport == nil && self.toCity == nil) {
     return nil;
     }

     SearchViewController* viewController = [SearchViewController new];
     
     
     viewController.fromIATA = self.fromAirport ? self.fromAirport.code : self.fromCity.code;
     viewController.toIATA = self.toAirport ? self.toAirport.code : self.toCity.code;
     
     return viewController; */
}

@end
