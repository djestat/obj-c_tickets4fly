//
//  TravelDirectionsView.h
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TravelDirectionsViewDelegate <NSObject>

- (void) fromButtonAction;
- (void) toButtonAction;
- (void) departureDate;
- (void) arrivalDate;
- (void) searchButtonAction;

@end

NS_ASSUME_NONNULL_BEGIN

@interface TravelDirectionsView : UIView

@property (nonatomic, weak) id<TravelDirectionsViewDelegate> delegate;

- (void) enableSearchButton;
- (void) disableSearchButton;

- (void) setFromTitle: (NSString*) title;

@end

NS_ASSUME_NONNULL_END
