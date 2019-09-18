//
//  NetworkingService.h
//  ticket4fly
//
//  Created by Igor on 17/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class News;

typedef void (^NewsApi_GetNewssCompletion)(NSArray<News*>*);

@interface NetworkingService : NSObject

- (void) getNews: (NewsApi_GetNewssCompletion) completion;

@end

NS_ASSUME_NONNULL_END

