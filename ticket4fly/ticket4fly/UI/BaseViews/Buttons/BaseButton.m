//
//  BaseButton.m
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "BaseButton.h"

@interface BaseButton ()

@property (nonatomic, weak, readwrite) ThemeManager* themeManager;

@end

@implementation BaseButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    
    self.themeManager = [ThemeManager shared];
    [self addNotifications];
    [self updateTheme];
    
    return self;
}

- (void)dealloc {
    [self removeNotifications];
}

#pragma mark - Theme

- (void) updateTheme {

}

#pragma mark - Notifications

- (void) addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(didReceiveChangedThemeNotification)
                                                 name: [self.themeManager didChangedThemeNotificationName]
                                               object: nil];
}

- (void) removeNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: [self.themeManager didChangedThemeNotificationName]
                                                  object: nil];
}

- (void) didReceiveChangedThemeNotification {
    [self updateTheme];
}

@end
