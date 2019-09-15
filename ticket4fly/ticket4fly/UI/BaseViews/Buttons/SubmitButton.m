//
//  SubmitButton.m
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "SubmitButton.h"

@implementation SubmitButton

- (void) updateTheme {
    BaseTheme* activeTheme = [self.themeManager activeTheme];
    
    UIColor* titleColor = [activeTheme backgroundColor];
    [self setTitleColor: titleColor forState: UIControlStateNormal];
    
    UIColor* backgroundColor = [activeTheme activeColor];
    self.backgroundColor = backgroundColor;
    
    self.layer.cornerRadius = [activeTheme actionCornerRadius];
    self.layer.borderWidth = 1.0f;
    self.layer.masksToBounds = YES;
}

@end
