//
//  TTCustomEmoji.h
//  TTService
//
//  Created by wangyilong on 2018/10/17.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EmojiItem;
@class EmojiMsg;

@interface TTCustomEmoji : NSObject

@property(nonatomic, strong) NSString *emojiId;         // 表情包id
@property(nonatomic, strong) NSString *url;             // 下载原图url
@property(nonatomic, strong) NSString *thumbnail;       // 缩略url，这个不一定有值，压缩图片异步进行；优先获取缩略图，若缩略图为空字符串则获取原图
@property(nonatomic, strong) NSString *name;            // 表情名字
@property(nonatomic, strong) NSString *desc;            // 表情描述，备用字段

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;

- (instancetype)initWithPBEmojiItem:(EmojiItem *)emojiItem;

- (instancetype)initWithPBEmojiMsg:(EmojiMsg *)emojimsg;

- (NSString *)thumbUrl;
- (NSString *)bigUrl;
- (NSString *)thumbKey;
- (NSString *)emojiKey;

- (void)dealSize;


@end
