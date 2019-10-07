//
//  PlaceTableViewCell.m
//  ticket4fly
//
//  Created by Igor on 16/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "PlaceTableViewCell.h"
#import "ThemeManager.h"
#import "TitleLabel.h"
#import "PlaceCellModel.h"

@interface PlaceTableViewCell ()

@property (nonatomic, weak) ThemeManager* themeManager;

@end


@implementation PlaceTableViewCell

- (void) configureWith: (PlaceCellModel*) cellModel {
    self.textLabel.text = [cellModel placeName];
    self.detailTextLabel.text = [cellModel placeName];
}

#pragma mark - Layout

- (void) layoutSubviews {
    [super layoutSubviews];
    
}

#pragma mark - Style

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: reuseIdentifier];
    return self;
}

#pragma mark - Subviews

- (void) addSubviews {
}


@end
