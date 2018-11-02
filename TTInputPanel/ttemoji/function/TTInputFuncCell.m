//
//  TTInputFuncCell.m
//  TT
//
//  Created by simp on 2018/10/18.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import "TTInputFuncCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+TTColor_Generated.h"
#import "TTFuncSourceItem.h"

@interface TTInputFuncCell ()

@property (nonatomic, strong) UIImageView * imageview;

@property (nonatomic, strong) UILabel * nameLabel;

@property (nonatomic, strong) UIView * containerView;

@end

@implementation TTInputFuncCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialUI];
    }
    return self;
}

- (void)initialUI {
    self.containerView = [[UIView alloc] init];
    [self.contentView addSubview:self.containerView];
    
    [self initialImageView];
    [self initiallabel];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.top.equalTo(self.imageview.mas_top);
        make.bottom.equalTo(self.nameLabel.mas_bottom);
    }];
}

- (void)initialImageView {
    self.imageview = [[UIImageView alloc] init];
    [self.containerView addSubview:self.imageview];
    
    [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(48);
        make.height.mas_equalTo(48);
        make.centerX.equalTo(self.containerView.mas_centerX);
        make.top.equalTo(self.containerView.mas_top);
    }];
}

- (void)initiallabel {
    self.nameLabel = [[UILabel alloc] init];
    [self.containerView addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageview.mas_centerX);
        make.top.equalTo(self.imageview.mas_bottom).offset(1);
        make.width.mas_lessThanOrEqualTo(self.mas_width);
        make.height.mas_equalTo(17);
    }];
    
    self.nameLabel.textColor = [UIColor TTGray2];
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    
}

- (void)setItem:(TTFuncSourceItem *)item {
    [super setItem:item];
    
    if (!item.itemImg) {
        item.itemImg = [UIImage imageNamed:item.imageName];
    }
    self.nameLabel.text = item.name;
    self.imageview.image = item.itemImg;
    
}

@end
