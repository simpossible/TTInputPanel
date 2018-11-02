//
//  TTInputMyEmojiEditCell.m
//  TT
//
//  Created by simp on 2018/10/19.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import "TTInputMyEmojiEditCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+TTColor_Generated.h"
#import "TTInputMyEmojiEditItem.h"

@interface TTInputMyEmojiEditCell()

@end

@implementation TTInputMyEmojiEditCell


- (void)initialUI {
    
    [super initialUI];
    
    [self.img removeFromSuperview];
    
    UIView * contanerView = [[UIView alloc] init];
    [self.contentView addSubview:contanerView];
    
    [contanerView addSubview:self.img];
    [self.img mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contanerView.mas_top);
        make.centerX.equalTo(contanerView.mas_centerX);
        make.width.mas_equalTo(24);
        make.height.mas_equalTo(24);
    }];
    
    
    self.nameLabel = [[UILabel alloc] init];
    [contanerView addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contanerView.mas_centerX);
        make.top.equalTo(self.img.mas_bottom).offset(2);
        make.height.mas_equalTo(14);
    }];
    self.nameLabel.textColor = [UIColor TTGray2];
    self.nameLabel.font = [UIFont systemFontOfSize:10];
    
    [contanerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.top.equalTo(self.img.mas_top);
        make.bottom.equalTo(self.nameLabel.mas_bottom);
        make.width.equalTo(self.mas_width);
    }];
    
    self.contentView.layer.cornerRadius = 4;
    self.contentView.layer.borderWidth = 0.5;
    self.contentView.layer.borderColor = [UIColor TTGray3].CGColor;
}

- (void)setItem:(TTInputMyEmojiEditItem *)item {
    [super setItem:item];
    self.img.image = item.itemImg;
    self.nameLabel.text = item.name;
  
}

@end
