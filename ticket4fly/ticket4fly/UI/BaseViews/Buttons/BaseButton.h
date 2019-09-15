//
//  BaseButton.h
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseButton : UIButton

@property (nonatomic, weak, readonly) ThemeManager* themeManager;

- (void) updateTheme;

@end

NS_ASSUME_NONNULL_END
