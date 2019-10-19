//
//  FavoriteTicketCell.h
//  ticket4fly
//
//  Created by Igor on 29/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Ticket;

@interface FavoriteTicketCell : UITableViewCell

@property (nonatomic, strong, readonly) Ticket* ticket;

- (void) configureWith: (Ticket*) ticket;

@end

NS_ASSUME_NONNULL_END
