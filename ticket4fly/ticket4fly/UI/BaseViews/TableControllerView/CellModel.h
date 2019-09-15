//
//  CellModel.h
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CellModel : NSObject

- (CGFloat) heightInTableView: (UITableView*) tableView;

- (void) didSelect;

@end

NS_ASSUME_NONNULL_END
