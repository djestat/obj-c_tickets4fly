//
//  RouteTableViewCell.h
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RouteCellModel;

@interface RouteTableViewCell : UITableViewCell

- (void) configureWith: (RouteCellModel*) cellModel;

@end

NS_ASSUME_NONNULL_END
