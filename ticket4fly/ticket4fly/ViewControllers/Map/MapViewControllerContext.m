//
//  MapViewControllerContext.m
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "MapViewControllerContext.h"
#import "MapViewController.h"

@interface MapViewControllerContext ()

@end

@implementation MapViewControllerContext

+ (MapViewControllerContext*) create {
    MapViewControllerContext* context = [MapViewControllerContext new];
    return context;
}

- (nullable UIViewController*) viewController {
    
    MapViewController* viewController = [MapViewController new];
    return viewController;
}

@end
