//
//  SettingsViewController.m
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "SettingsViewController.h"
#import "SegmentedControl.h"
#import "TitleLabel.h"

@interface SettingsViewController ()

@property (nonatomic, weak) SegmentedControl* themasSegmentedControl;
@property (nonatomic, weak) TitleLabel* titleLabel;

@end

@implementation SettingsViewController
/*
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addSubviews];

}
*/
#pragma mark - Layout

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    BaseTheme* activeTheme = [self.themeManager activeTheme];
    CGFloat horizontalEdgeInset = [activeTheme horizontalEdgeInset];
    CGFloat width = self.view.frame.size.width - horizontalEdgeInset * 2;
    CGFloat height = [activeTheme submitActionHeight];
    CGFloat y = (self.view.frame.size.height - height) / 2;
    
    self.themasSegmentedControl.frame = CGRectMake(horizontalEdgeInset, y, width, height);
    
    CGFloat titleLabelY = [activeTheme topInset];
    self.titleLabel.frame = CGRectMake(horizontalEdgeInset,
                                       titleLabelY,
                                       width,
                                       height);
}

#pragma mark - Theme

- (void) updateTheme {
    [super updateTheme];
}

#pragma mark - Subviews

- (void) addSubviews {
    [super addSubviews];
    [self addThemasSegmentedControl];
    [self addTitleLabel];
}

- (void) addTitleLabel {
    if (nil != self.titleLabel) { return; }
    
    TitleLabel* titleLabel = [TitleLabel new];
    [self.view addSubview: titleLabel];
    self.titleLabel = titleLabel;
    
    titleLabel.text = @"Settings";
}

- (void) addThemasSegmentedControl {
    if (nil != self.themasSegmentedControl) { return; }
    
    SegmentedControl* themasSegmentedControl = [SegmentedControl new];
    [self.view addSubview: themasSegmentedControl];
    self.themasSegmentedControl = themasSegmentedControl;
    
    [themasSegmentedControl addTarget: self
                               action: @selector(themasSegmentedControlAction)
                     forControlEvents: UIControlEventValueChanged];
    
    NSArray* avaliableThemas = [self.themeManager avaliableThemas];
    NSString* activeThemeIdentifier = [[self.themeManager activeTheme] identifier];
    NSUInteger index = 0;
    for (BaseTheme* theme in avaliableThemas) {
        NSString* identifier = [theme identifier];
        [themasSegmentedControl insertSegmentWithTitle: identifier
                                               atIndex: index
                                              animated: NO];
        if ([identifier isEqualToString: activeThemeIdentifier]) {
            themasSegmentedControl.selectedSegmentIndex = index;
        }
        
        index++;
    }
}

#pragma mark - Actions

- (void) themasSegmentedControlAction {
    NSUInteger selectedIndex = [self.themasSegmentedControl selectedSegmentIndex];
    
    NSArray* avaliableThemas = [self.themeManager avaliableThemas];
    for (NSUInteger i = 0; i < [avaliableThemas count]; i++) {
        if (i != selectedIndex) { continue; }
        
        BaseTheme* newTheme = [avaliableThemas objectAtIndex: i];
        [self.themeManager selectThemeWith: [newTheme identifier]];
    }
}

@end
