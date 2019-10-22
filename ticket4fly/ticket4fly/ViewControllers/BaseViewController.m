//
//  BaseViewController.m
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "BaseViewController.h"
#import "PlaceViewController.h"


@interface BaseViewController ()

@property (nonatomic, weak, readwrite) ThemeManager* themeManager;

@end


@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.themeManager = [ThemeManager shared];
    
    [self addSubviews];
    
    [self addNotifications];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self updateTheme];
}

- (void)dealloc {
    [self removeNotifications];
}

#pragma mark - Subview

- (void) addSubviews {
    
}

#pragma mark - Theme

- (void) updateTheme {
    BaseTheme* activeTheme = [self.themeManager activeTheme];
    
    UIColor* backgroundColor  = [activeTheme backgroundColor];
    self.view.backgroundColor = backgroundColor;
    
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

#pragma mark - NotRouter

- (void) push: (NSObject<ViewControllerContext>*) context {
    UIViewController* viewController = [context viewController];
    if ([viewController isKindOfClass: [UIViewController class]]) {
        [self.navigationController pushViewController: viewController animated: YES];
    } else {
        NSLog(@"Can not push %@ from %@", viewController, context);
    }
}

@end
