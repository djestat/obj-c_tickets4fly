//
//  RootNavigationController.m
//  ticket4fly
//
//  Created by Igor on 11/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "RootNavigationController.h"
#import "ThemeManager.h"

@interface RootNavigationController ()

@property (nonatomic, weak, readwrite) ThemeManager* themeManager;

@end

@implementation RootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.themeManager = [ThemeManager shared];
    
    [self addNotifications];
    
    [self updateTheme];
    
    self.navigationBar.translucent = NO;
}

- (void)dealloc {
    [self removeNotifications];
}

#pragma mark - Theme

- (void) updateTheme {
    BaseTheme* activeTheme = [self.themeManager activeTheme];
    
    self.view.backgroundColor = [activeTheme backgroundColor];
    
    self.navigationBar.tintColor = [activeTheme activeColor];
    self.navigationBar.barTintColor = [UIColor systemGreenColor];
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
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
