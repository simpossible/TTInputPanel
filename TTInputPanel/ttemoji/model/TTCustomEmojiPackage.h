//
//  TTCustomEmojiPackage.h
//  TTService
//
//  Created by wangyilong on 2018/10/17.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import <Foundation/Foundation.h>


@class TTCustomEmoji;
@class EmojiPackage;

@protocol TTCustomEmojiPackageProtocol <NSObject>

- (void)packageItem:(TTCustomEmoji *)emoji loadedAtIndex:(NSInteger)index;

@end

@interface TTCustomEmojiPackage : NSObject

@property(nonatomic, strong) NSString *packageId;     // 表情包id
@property(nonatomic, assign) UInt64 updateTime;       // 表情包最后修改时间
@property(nonatomic, strong) NSString *name;          // 表情包名字，备用字段
@property(nonatomic, assign) UInt32 totalCount;       // 表情包内表情总数
@property(nonatomic, strong) NSString *coverUrl;      // 表情包封面图标url
@property(nonatomic, assign) UInt32 ownerId;          // 表情包拥有者id，可与自身用户id对比，一致即可以做增删操作
@property(nonatomic, strong) NSString *type;          // 表情包类型，备用字段


@property (nonatomic, weak) id<TTCustomEmojiPackageProtocol> delegate;

- (instancetype)initWithPBEmojiPackage:(EmojiPackage *)emojiPackage;

- (void)loadItems;

/**加载到一个index - 一次加载 8 个。判断当前的index 是否在请求 没有请求 就直接请求8个*/
- (void)loadItemAt:(NSInteger)index;

- (TTCustomEmoji *)emojiAtIndex:(NSInteger)index;

- (BOOL)isMyEmoji;

- (NSString *)iconKey;

@end
