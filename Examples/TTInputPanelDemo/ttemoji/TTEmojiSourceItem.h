//
//  TTEmojiSourceItem.h
//  TTInputPanelDemo
//
//  Created by simp on 2018/10/11.
//  Copyright © 2018年 simp. All rights reserved.
//

#import "TTInputSourceItem.h"
#import "TTEmoji.h"

typedef NS_ENUM(UInt8,TTEmojiItemType) {
    TTEmojiItemTypeTT,
    TTEmojiItemTypeQQ,
    TTEmojiItemTypeDelete,
    TTEmojiItemTypeSend,
};

@interface TTEmojiSourceItem : TTInputSourceItem

@property (nonatomic, assign) TTEmojiItemType type;

- (instancetype)initWIthEmoji:(TTEmoji *)tmoji;

+ (instancetype)sendItem;

+ (instancetype)deleteItem;

@end
