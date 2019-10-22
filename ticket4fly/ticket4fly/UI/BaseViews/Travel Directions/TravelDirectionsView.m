//
//  TravelDirectionsView.m
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "TravelDirectionsView.h"
#import "ThemeManager.h"
#import "DirectionButton.h"
#import "SubmitButton.h"


@interface TravelDirectionsView ()

@property (nonatomic, weak) ThemeManager* themeManager;
@property (nonatomic, weak) DirectionButton* fromButton;
@property (nonatomic, weak) DirectionButton* toButton;
@property (nonatomic, weak) SubmitButton* searchButton;


@end

@implementation TravelDirectionsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    
    self.themeManager = [ThemeManager shared];
    [self addNotifications];
    [self addSubviews];
    [self updateTheme];
    
    return self;
}

- (void)dealloc {
    [self removeNotifications];
}

#pragma mark - Control Button Title insert and Searching

#warning Enable search button

- (void) enableSearchButton {
//    if (nil != _fromButton && nil != _toButton) {
//    }
//    _searchButton.enabled = YES;
    self.searchButton.backgroundColor = [UIColor systemBlueColor];
    NSLog(@"🛫 enableSearchButton");
}

- (void) disableSearchButton {
//    if (nil == _fromButton && nil == _toButton) {
//    }
//    _searchButton.enabled = NO;
    self.searchButton.backgroundColor = [UIColor grayColor];
    NSLog(@"🛫 disableSearchButton");
}

- (void) setFromTitle: (NSString*) title {
    if (nil == title) {
        [_fromButton setTitle:@"From 🛫" forState: UIControlStateNormal];
    } else {
        [_fromButton setTitle: title forState: UIControlStateNormal];
    }
}

- (void) setToTitle: (NSString*) title {
    if (nil == title) {
        [_toButton setTitle:@"To 🛬" forState: UIControlStateNormal];
    } else {
        [_toButton setTitle: title forState: UIControlStateNormal];
    }
}



#pragma mark - Layout

- (void) layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    
    CGFloat inset = 10;
    CGFloat x = 20;
    CGFloat y = 20;
    CGFloat buttonWidth = width - x *2;
    CGFloat buttonHeight = 50;
    
    self.fromButton.frame = CGRectMake(x, y, buttonWidth, buttonHeight);
    y += buttonHeight;
    y += inset;
    
    self.toButton.frame = CGRectMake(x, y, buttonWidth, buttonHeight);
    y += buttonHeight;
    y += inset;
    y += inset;

    self.searchButton.frame = CGRectMake(x, y, buttonWidth, buttonHeight);
}

#pragma mark - Subviews

- (void) addSubviews {
    [self addFromButton];
    [self addToButton];
    [self addSearchButton];
}

- (void) addFromButton {
    if (nil != self.fromButton) {
        return;
    }
    
    DirectionButton* button = [DirectionButton buttonWithType: UIButtonTypeCustom];
    
    button.layer.shadowColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.9] CGColor];
    button.layer.shadowOffset = CGSizeZero;
    button.layer.shadowRadius = 3.0;
    button.layer.shadowOpacity = 1.0;
    
    [self addSubview: button];
    self.fromButton = button;
    button.titleLabel.preferredMaxLayoutWidth = _fromButton.bounds.size.width - 10;
    [button.titleLabel setAdjustsFontSizeToFitWidth:YES];
    
    [button setTitle:@"From 🛫" forState: UIControlStateNormal];
    [button addTarget: self action: @selector(fromButtonAction) forControlEvents: UIControlEventTouchUpInside];
}

- (void) addToButton {
    if (nil != self.toButton) {
        return;
    }
    
    DirectionButton* button = [DirectionButton buttonWithType: UIButtonTypeCustom];
    
    button.layer.shadowColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.9] CGColor];
    button.layer.shadowOffset = CGSizeZero;
    button.layer.shadowRadius = 3.0;
    button.layer.shadowOpacity = 1.0;
    
    [self addSubview: button];
    self.toButton = button;
    
    button.titleLabel.preferredMaxLayoutWidth = _fromButton.bounds.size.width - 10;
    [button.titleLabel setAdjustsFontSizeToFitWidth:YES];
    
    [button setTitle:@"To 🛬" forState: UIControlStateNormal];
    [button addTarget: self action: @selector(toButtonAction) forControlEvents: UIControlEventTouchUpInside];
}

- (void) addSearchButton {
    if (nil != self.searchButton) {
        return;
    }
    
    SubmitButton* button = [SubmitButton buttonWithType: UIButtonTypeCustom];
    
    [self addSubview: button];
    self.searchButton = button;
    
    [button setTitle:@"Search" forState: UIControlStateNormal];
    [button addTarget: self action: @selector(searchButtonAction) forControlEvents: UIControlEventTouchUpInside];
    [self disableSearchButton];
}

#pragma mark - Theme

- (void) updateTheme {
    BaseTheme* activeTheme = [self.themeManager activeTheme];
    
    UIColor* viewBackgroundColor = [activeTheme viewBackgroundColor];
    self.backgroundColor = viewBackgroundColor;
    
    self.layer.cornerRadius = [activeTheme actionCornerRadius];
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1.0f;
    self.layer.masksToBounds = YES;
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

#pragma mark -  TravelDirectionsViewDelegate

- (void) fromButtonAction {
    if ([self.delegate respondsToSelector: @selector(fromButtonAction) ]) {
        [self.delegate fromButtonAction];
    }
}
- (void) toButtonAction {
    if ([self.delegate respondsToSelector: @selector(toButtonAction) ]) {
        [self.delegate toButtonAction];
    }
}
- (void) departureDate {
    if ([self.delegate respondsToSelector: @selector(departureDate) ]) {
        [self.delegate departureDate];
    }
}
- (void) arrivalDate {
    if ([self.delegate respondsToSelector: @selector(arrivalDate) ]) {
        [self.delegate arrivalDate];
    }
}
- (void) searchButtonAction {
    if ([self.delegate respondsToSelector: @selector(searchButtonAction) ]) {
        [self.delegate searchButtonAction];
    }
    NSLog(@"searchButtonAction");

    if (self.searchButton.backgroundColor == [UIColor grayColor]) {
        NSLog(@"SearchButton disable");
        
        [UIView animateWithDuration: 0.6
                              delay: 0
                            options: UIViewAnimationOptionTransitionCurlDown
                         animations:^{
            self.fromButton.backgroundColor = [UIColor systemRedColor];
            self.toButton.backgroundColor = [UIColor systemRedColor];
        }
                         completion:^(BOOL finished) {
            self.fromButton.backgroundColor = [UIColor systemGreenColor];
            self.toButton.backgroundColor = [UIColor systemGreenColor];
        }];
    }
}

@end
