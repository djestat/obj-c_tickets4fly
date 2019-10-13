//
//  PlaceViewControllerContext.m
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "PlaceViewControllerContext.h"
#import "PlaceViewController.h"

@interface PlaceViewControllerContext ()

@property (nonatomic, assign) PlaceReason reason;
@property (nonatomic, weak) NSObject<PlaceViewControllerDelegate>* delegate;

@end

@implementation PlaceViewControllerContext

+ (PlaceViewControllerContext*) create: (PlaceReason) reason delegate: (NSObject<PlaceViewControllerDelegate>*) delegate {
    PlaceViewControllerContext* context = [PlaceViewControllerContext new];
    context.reason = reason;
    context.delegate = delegate;
    return context;
}

- (nullable UIViewController*) viewController {
    PlaceViewController* viewController = [PlaceViewController new];
    viewController.reason = self.reason;
    viewController.delegate = self.delegate;
    return viewController;
}

@end
