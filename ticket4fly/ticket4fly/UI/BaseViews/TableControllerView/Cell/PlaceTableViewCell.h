//
//  PlaceTableViewCell.h
//  ticket4fly
//
//  Created by Igor on 16/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PlaceCellModel;

@interface PlaceTableViewCell : UITableViewCell

- (void) configureWith: (PlaceCellModel*) cellModel;

@end

NS_ASSUME_NONNULL_END
