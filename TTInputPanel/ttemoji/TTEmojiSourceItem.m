//
//  TTEmojiSourceItem.m
//  TTInputPanelDemo
//
//  Created by simp on 2018/10/11.
//  Copyright © 2018年 simp. All rights reserved.
//

#import "TTEmojiSourceItem.h"
//#import <EmojiHelper.h>

@interface TTEmojiSourceItem()

@property (nonatomic, strong) TTEmoji *emoji;

@end

@implementation TTEmojiSourceItem

- (instancetype)initWIthEmoji:(TTEmoji *)tmoji {
    if (self = [super init]) {
        self.emoji = tmoji;
    }
    return self;
}

+ (instancetype)sendItem {
    TTEmojiSourceItem *titem = [[TTEmojiSourceItem alloc] init];
    titem.type = TTEmojiItemTypeSend;
    titem.itemSize = CGSizeMake(60, 30);
    titem.margin  = UIEdgeInsetsMake(7.5, 12, 10, 0);
    titem.identifier = @"TTEmojiDeleteNomalCell";
    return titem;
}

+ (instancetype)deleteItem {    
    TTEmojiSourceItem *titem = [[TTEmojiSourceItem alloc] init];
    titem.type = TTEmojiItemTypeDelete;
    titem.itemSize = CGSizeMake(33, 20);
    titem.margin  = UIEdgeInsetsMake(12.5, 10.5, 10, 12);
    titem.itemImg = [UIImage imageNamed:@"button_emoji_clear"];
    return titem;
}

- (void)loadItemImage {
    if (self.type == TTEmojiItemTypeDelete) {
        self.itemImg =[UIImage imageNamed:@"button_emoji_clear"];
    }else if (self.type == TTEmojiItemTypeSend) {
    }else {
//        self.itemImg = [EmojiHelper getFaceImage:self.emoji.thumb];
    }
}


@end
