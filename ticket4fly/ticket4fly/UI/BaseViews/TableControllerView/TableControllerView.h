//
//  TableControllerView.h
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableControllerView : UIView

- (void) reload: (NSArray<CellModel*>*)models;

@end

NS_ASSUME_NONNULL_END
