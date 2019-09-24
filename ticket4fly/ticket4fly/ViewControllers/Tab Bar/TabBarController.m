//
//  TabBarController.m
//  ticket4fly
//
//  Created by Igor on 24/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "TabBarController.h"
#import "RootNavigationController.h"
#import "MainViewController.h"
#import "CollectionViewController.h"
#import "MapViewController.h"


@interface TabBarController ()

@end

@implementation TabBarController

- (instancetype)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
        
        
        MainViewController *mainViewController = [[MainViewController alloc] init];
        mainViewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:0];
        RootNavigationController *rootNavigationController = [[RootNavigationController alloc] initWithRootViewController:mainViewController];
        
        MapViewController *mapViewController = [[MapViewController alloc] init];
        mapViewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
        
        CollectionViewController *collectionViewController = [[CollectionViewController alloc] init];
        collectionViewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:2];
        
        self.viewControllers = @[rootNavigationController, mapViewController, collectionViewController];
        self.tabBar.tintColor = [UIColor blackColor];
        self.selectedIndex = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Navigation


@end
