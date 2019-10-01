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
#import "MapViewController.h"
#import "FavoritesController.h"


@interface TabBarController ()

@end

@implementation TabBarController

- (instancetype)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
        MainViewController *mainViewController = [[MainViewController alloc] init];
        mainViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle: @"Tickets" image: [UIImage imageNamed: @"ticket"] tag: 0];
        RootNavigationController *rootNavigationController = [[RootNavigationController alloc] initWithRootViewController:mainViewController];
        
        MapViewController *mapViewController = [[MapViewController alloc] init];
        mapViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle: @"Price map" image: [UIImage imageNamed: @"map"] tag: 1];
        
//        CollectionViewController *collectionViewController = [[CollectionViewController alloc] init];
//        collectionViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle: @"Collection" image: [UIImage imageNamed: @"collection"] tag: 2];
        
        FavoritesController *favoritesController = [[FavoritesController alloc] init];
        favoritesController.tabBarItem = [[UITabBarItem alloc] initWithTitle: @"Favorites" image: [UIImage imageNamed: @"favorites"] tag: 2];
        
        self.viewControllers = @[rootNavigationController, mapViewController, favoritesController];
        self.tabBar.tintColor = [UIColor redColor];
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
