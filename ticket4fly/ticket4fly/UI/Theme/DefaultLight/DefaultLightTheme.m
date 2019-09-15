//
//  DefaultLightTheme.m
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "DefaultLightTheme.h"

@implementation DefaultLightTheme

- (nonnull NSString*) identifier { return ThemeIdentifier_DefaultLight; }

- (nonnull UIColor*) backgroundColor     { return UIColor.whiteColor; }
- (nonnull UIColor*) viewBackgroundColor { return UIColor.grayColor; }
- (nonnull UIColor*) activeColor         { return UIColor.blueColor; }

- (nonnull UIColor*) textActionColor   { return UIColor.darkTextColor; }
- (nonnull UIColor*) textActiveColor   { return UIColor.darkTextColor; }
- (nonnull UIColor*) textInactiveColor { return UIColor.lightTextColor; }

- (CGFloat) actionCornerRadius  { return 0; }

- (CGFloat) horizontalEdgeInset { return 20; }

- (CGFloat) submitActionHeight { return 50; }

- (CGFloat) topInset { return 50; }


- (nonnull UIFont*) titleFont { return [UIFont boldSystemFontOfSize: 13]; }

@end
