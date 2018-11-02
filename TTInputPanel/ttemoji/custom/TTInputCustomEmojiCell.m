//
//  TTInputCustomEmojiCell.m
//  TT
//
//  Created by simp on 2018/10/19.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import "TTInputCustomEmojiCell.h"
#import "TTInputCusSourceItem.h"
#import <Masonry/Masonry.h>
#import <YYKit/YYKit.h>

@interface TTInputCustomEmojiCell()<TTInputCusSourceItemProtocol>

@property (nonatomic, strong) UIActivityIndicatorView * indicataor;


@end

@implementation TTInputCustomEmojiCell




- (void)initialUI {
    [self initialIndicator];
    [super initialUI];
}

- (void)initialIndicator {
    self.indicataor = [[UIActivityIndicatorView alloc] init];
    [self.contentView addSubview:self.indicataor];
    
    [self.indicataor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
}

- (void)initialImgView {
    
    _img = [[YYAnimatedImageView alloc] init];
    [self.contentView addSubview:self.img];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [_img setContentMode:UIViewContentModeScaleAspectFit];
    
}


- (void)setItem:(TTInputCusSourceItem *)item {
    [super setItem:item];
    item.delegate = self;
    
    if (!item.emoji) {
        [item loadConfig];
    }

    if (!item.thumbImage) {
        [item loadThumb];
    }
    
    if (item.customState == TTInputCusSourceItemStateConfigring || item.customState == TTInputCusSourceItemStateThumbDownloading) {
        [self.indicataor startAnimating];
    }else {
        [self.indicataor stopAnimating];
        if (item.thumbImage) {
            self.img.image = item.thumbImage;
        }else {
            self.img.image = [UIImage imageNamed:@"img_not_found"];
        }
    }        
}

- (void)diddisAppear {
    TTInputCusSourceItem *item = (TTInputCusSourceItem *)self.item;
    [item clearThumbImage];
    self.img.image = nil;
}

- (void)itemStateChanged {
    self.item = self.item;
}

@end
