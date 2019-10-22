//
//  PlaceViewController.h
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "BaseViewController.h"

#import "PlaceViewControllerContext.h"


NS_ASSUME_NONNULL_BEGIN

@interface PlaceViewController : BaseViewController

@property (nonatomic, assign) PlaceReason reason;
@property (nonatomic, weak) NSObject<PlaceViewControllerDelegate>* delegate;

@end

NS_ASSUME_NONNULL_END
