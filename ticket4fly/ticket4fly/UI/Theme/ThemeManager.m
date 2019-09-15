//
//  ThemeManager.m
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "ThemeManager.h"
#import "DefaultLightTheme.h"
#import "DefaultDarkTheme.h"


@interface ThemeManager ()

@property (nonatomic, strong, nonnull) NSArray<BaseTheme*>* allThemas;
@property (nonatomic, strong, nonnull) BaseTheme* currentTheme;

@end


@implementation ThemeManager

+ (ThemeManager*) shared {
    static ThemeManager* shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (NSNotificationName) didChangedThemeNotificationName {
    return @"ThemeManager_didChangedThemeNotificationName";
}

- (nonnull NSArray<BaseTheme*>*) avaliableThemas {
    return self.allThemas;
}

- (nonnull BaseTheme*) activeTheme {
    return self.currentTheme;
}

- (void) selectThemeWith: (nonnull NSString*) identifier {
    if ([[self.currentTheme identifier] isEqualToString: identifier]) {
        return;
    }
    
    for (BaseTheme* theme in self.allThemas) {
        if (NO == [[theme identifier] isEqualToString: identifier]) { continue; }
        
        self.currentTheme = theme;
        [self postChangedThemeNotification];
        break;
    }
}

#pragma mark - Private

- (instancetype)init {
    self = [super init];
    if (self) {
        self.allThemas = @[[DefaultLightTheme new], [DefaultDarkTheme new]];
        self.currentTheme = [self.allThemas firstObject];
    }
    return self;
}

- (void) postChangedThemeNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName: [self didChangedThemeNotificationName] object: nil];
}

@end
