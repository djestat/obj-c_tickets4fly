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

@property (nonatomic, weak) TitleLabel* placeName;
@property (nonatomic, weak) TitleLabel* placeType;

@property (nonatomic, weak) TitleLabel* placeNameLabel;


@end


@implementation PlaceTableViewCell

- (void) configureWith: (PlaceCellModel*) cellModel {
    self.textLabel.text = [cellModel placeName];
    self.detailTextLabel.text = [cellModel placeName];
    
//    self.textLabel.text  = @"Text";
//    self.detailTextLabel.text = @"Label";
    
//    self.placeNameLabel.text = [cellModel placeName];

}

#pragma mark - Layout

- (void) layoutSubviews {
    [super layoutSubviews];
    
//    self.textLabel.frame = self.contentView.bounds;
//    self.detailTextLabel.frame = self.contentView.bounds;

//    self.placeNameLabel.frame = self.contentView.bounds;

}

#pragma mark - Style

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: reuseIdentifier];
    [self addSubviews];
    return self;
}

#pragma mark - Subviews

- (void) addSubviews {
    [self addPlaceNameLabel];

}

- (void) addPlaceNameLabel {
    /*
    if (nil != self.placeName && nil != self.placeType) {
        return;
    }
    
    TitleLabel* textLabel = [TitleLabel new];
    [self.contentView addSubview: textLabel];
    self.placeName = textLabel;
    
    TitleLabel* detailTextLabel = [TitleLabel new];
    [self.contentView addSubview: detailTextLabel];
    self.placeType = detailTextLabel;
    */
    /*
    if (nil != self.placeNameLabel) {
          return;
      }
      
      TitleLabel* label = [TitleLabel new];
      [self.contentView addSubview: label];
      self.placeNameLabel = label;*/
}

@end
