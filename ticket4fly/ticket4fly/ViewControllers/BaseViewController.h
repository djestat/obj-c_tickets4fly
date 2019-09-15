//
//  BaseViewController.h
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeManager.h"

typedef enum : NSUInteger {
    PlaceReasonFrom,
    PlaceReasonTo,
} PlaceReason;

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property (nonatomic, weak, readonly) ThemeManager* themeManager;

- (void) updateTheme;

- (void) addSubviews;

- (void) addNotifications;
- (void) removeNotifications;

- (void) openPlaceViewControllerWith: (PlaceReason) reason;

@end

NS_ASSUME_NONNULL_END
