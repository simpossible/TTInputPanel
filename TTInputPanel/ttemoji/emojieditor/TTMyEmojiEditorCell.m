//
//  TTMyEmojiEditorCell.m
//  TT
//
//  Created by simp on 2018/10/20.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import "TTMyEmojiEditorCell.h"
#import "TTInputCusEditItem.h"
#import <Masonry/Masonry.h>
#import "UIColor+TTColor_Generated.h"
#import "UIColor+Extension.h"

@interface TTMyEmojiEditorCell()<TTInputCusEditItemProtocol>


@property (nonatomic, strong) UIImageView * image;

@property (nonatomic, strong) UIActivityIndicatorView * indicator;

/**是否选中*/
@property (nonatomic, strong) UIImageView * selectView;

@property (nonatomic, strong) UIControl * eventCotrol;

@end

@implementation TTMyEmojiEditorCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor TTGray4].CGColor;
    }
    return self;
}

- (void)initialUI {
    [super initialUI];
    [self.img mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(self.mas_width).multipliedBy(0.784);
        make.height.equalTo(self.mas_height).multipliedBy(0.784);
    }];
    [self initialSelectView];
    [self initialEventControl];
}

- (void)initialSelectView {
    self.selectView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.selectView];
    
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-4);
        make.top.equalTo(self.contentView.mas_top).offset(4);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];
    
    self.selectView.layer.cornerRadius = 9;
}

- (void)initialEventControl {
    self.eventCotrol = [[UIControl alloc] init];
    [self.contentView addSubview:self.eventCotrol];
    
    [self.eventCotrol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.eventCotrol addTarget:self action:@selector(eventControlClicked:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)setItem:(TTInputCusEditItem *)item {

    [super setItem:item];
    item.editDelegate = self;
    [self editStateChanged];
}


- (void)eventControlClicked:(UIControl *)control {
    TTInputCusEditItem *item =  (TTInputCusEditItem *)self.item;
    if (!item.emoji) {
        NSLog(@"loading");
        return;
    }
    item.selected =!item.selected;
    if ([self.delegate respondsToSelector:@selector(itemSeletedStateChanged:)]) {
        [self.delegate itemSeletedStateChanged:item];
    }
}

- (void)editStateChanged {
     TTInputCusEditItem *item =  (TTInputCusEditItem *)self.item;
    BOOL editor = [self.delegate isEditorMode];
    if (editor) {
        self.selectView.hidden = NO;
        self.eventCotrol.hidden = NO;
        if (item.selected) {
//            self.selectView.backgroundColor = [UIColor purpleColor];
            self.selectView.image = [UIImage imageNamed:@"ic_emoji_selected"];
        }else {
            self.selectView.image = nil;
            self.selectView.backgroundColor = [UIColor ARGB:0x1A000000];
        }
    }else {
        self.selectView.hidden = YES;
        self.eventCotrol.hidden = YES;
    }
}

@end
