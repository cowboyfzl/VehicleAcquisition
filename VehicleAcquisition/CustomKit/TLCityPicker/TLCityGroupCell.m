//
//  TLCityGroupCell.m
//  VehicleAcquisition
//
//  Created by blm on 2018/8/24.
//  Copyright © 2018年 blm. All rights reserved.
//
#import "TLCityGroupCell.h"

@interface TLCityGroupCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *locationImageView;
@end
static NSInteger const LROffset = 15;
@implementation TLCityGroupCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    _locationImageView.centerY = self.contentView.height / 2;
    _titleLabel.centerY = self.contentView.height / 2;
}

- (void)setCurrentCityName:(NSString *)cityName {
    _titleLabel.text = [NSString stringWithFormat:@"当前定位城市 %@", cityName.length ? cityName : @"无"];
    [_titleLabel sizeToFit];
}

#pragma mark - Getter
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"当前定位城市 ";
        _titleLabel.left = self.locationImageView.right + 5;
        [_titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)locationImageView {
    if (!_locationImageView) {
        _locationImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"location_icon"]];
        _locationImageView.left = LROffset;
        [self.contentView addSubview:_locationImageView];
    }
    return _locationImageView;
}

@end
