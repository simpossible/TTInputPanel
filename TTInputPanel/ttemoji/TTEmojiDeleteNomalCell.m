//
//  TTEmojiDeleteNomalCell.m
//  TTInputPanelDemo
//
//  Created by simp on 2018/10/17.
//  Copyright © 2018年 simp. All rights reserved.
//

#import "TTEmojiDeleteNomalCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+TTColor_Generated.h"
#import "UIColor+Extension.h"

@interface TTEmojiDeleteNomalCell()

@property (nonatomic, strong) UILabel * textLabel;

@end

@implementation TTEmojiDeleteNomalCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialUI];
    }
    return self;
}

- (void)initialUI {
    self.textLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.textLabel];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    self.textLabel.text = @"发送";
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.textLabel.textColor = [UIColor TTWhite1];
    
    self.contentView.backgroundColor = [UIColor ARGB:0x4856FF];
    self.contentView.layer.cornerRadius = CGRectGetHeight(self.frame)/2;
    self.contentView.layer.masksToBounds = YES;
}

- (void)diddisAppear {
    
}

@end
