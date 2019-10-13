//
//  MapViewControllerContext.h
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewControllerContext.h"

NS_ASSUME_NONNULL_BEGIN

@class City;

@interface MapViewControllerContext : NSObject <ViewControllerContext>

+ (MapViewControllerContext*) create;

@end

NS_ASSUME_NONNULL_END
