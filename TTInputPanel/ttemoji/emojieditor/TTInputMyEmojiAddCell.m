//
//  TTInputMyEmojiAddCell.m
//  TT
//
//  Created by simp on 10/26/18.
//  Copyright © 2018 yiyou. All rights reserved.
//

#import "TTInputMyEmojiAddCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+Extension.h"
#import "UIColor+TTColor_Generated.h"

@implementation TTInputMyEmojiAddCell

- (void)initialUI {
    
    [super initialUI];
    
    [self.img removeFromSuperview];
    
    UIView * contanerView = [[UIView alloc] init];
    [self.contentView addSubview:contanerView];
    
    [contanerView addSubview:self.img];
    [self.img mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contanerView.mas_top);
        make.centerX.equalTo(contanerView.mas_centerX);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    
    
    self.nameLabel = [[UILabel alloc] init];
    [contanerView addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contanerView.mas_centerX);
        make.top.equalTo(self.img.mas_bottom).offset(2);
        make.height.mas_equalTo(15);
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
    
}

@end
