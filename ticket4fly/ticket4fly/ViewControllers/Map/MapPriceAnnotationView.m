//
//  MapPriceAnnotationView.m
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "MapPriceAnnotationView.h"

@implementation MapPriceAnnotationView

- (void) configure {
    
    if (nil == self.image) {
        self.image = [UIImage imageNamed: @"annotation"];
        
    }
    
}

@end
