//
//  SearchViewController.h
//  ticket4fly
//
//  Created by Igor on 13.10.2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : BaseViewController

@property (nonatomic, strong) NSString* fromIATA;
@property (nonatomic, strong) NSString* toIATA;

@end

NS_ASSUME_NONNULL_END
