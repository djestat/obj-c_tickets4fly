//
//  LocalNotificationManager.h
//  ticket4fly
//
//  Created by Igor on 02/10/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalNotificationManager : NSObject

+ (LocalNotificationManager*) shared;

- (void) requestPermissionsWithText: (NSString*) text after: (NSTimeInterval) delay;

- (void) send: (NSString*) text after: (NSTimeInterval) delay;


@end

NS_ASSUME_NONNULL_END
