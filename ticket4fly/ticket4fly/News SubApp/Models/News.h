//
//  News.h
//  ticket4fly
//
//  Created by Igor on 17/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface News : NSObject

@property (nonatomic, strong, readonly) NSString* name;
@property (nonatomic, strong, readonly) NSString* title;
@property (nonatomic, strong, readonly) NSString* descript;
@property (nonatomic, strong, readonly) NSString* urlToImage;

+ (nullable News*) createWithDictionary: (NSDictionary*) dictionary;

@end

NS_ASSUME_NONNULL_END
