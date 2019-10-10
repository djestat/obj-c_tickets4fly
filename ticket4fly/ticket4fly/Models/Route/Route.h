//
//  Route.h
//  ticket4fly
//
//  Created by Igor on 10.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Route : NSObject


@property (nonatomic, strong, readonly) NSNumber* aTime;
@property (nonatomic, strong, readonly) NSNumber* dTime;

+ (nullable Route*) createWithDictionary: (NSDictionary*) dictionary;

- (NSDictionary*) dictionary;


@end

NS_ASSUME_NONNULL_END
