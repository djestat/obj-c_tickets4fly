//
//  RouteCellModel.h
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "CellModel.h"

NS_ASSUME_NONNULL_BEGIN

@class Route;

@interface RouteCellModel : CellModel

@property (nonatomic, strong, readonly) NSString* info;

+ (RouteCellModel*) createWith: (Route*) route;

@end

NS_ASSUME_NONNULL_END
