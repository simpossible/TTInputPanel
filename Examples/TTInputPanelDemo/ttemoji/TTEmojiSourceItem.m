//
//  TTEmojiSourceItem.m
//  TTInputPanelDemo
//
//  Created by simp on 2018/10/11.
//  Copyright © 2018年 simp. All rights reserved.
//

#import "TTEmojiSourceItem.h"

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
    titem.itemSize = CGSizeMake(48, 24);
    titem.margin  = UIEdgeInsetsMake(10, 9, 10, 9);
    titem.identifier = @"TTEmojiDeleteNomalCell";
    return titem;
}

+ (instancetype)deleteItem {    
    TTEmojiSourceItem *titem = [[TTEmojiSourceItem alloc] init];
    titem.type = TTEmojiItemTypeDelete;
    titem.itemSize = CGSizeMake(24, 24);
    titem.margin  = UIEdgeInsetsMake(10, 9, 10, 9);
     titem.identifier = @"TTEmojiDeleteNomalCell";
    
    return titem;
}
@end
