//
//  TTEmoji.h
//  TTService
//
//  Created by wilson on 15/5/27.
//  Copyright (c) 2015年 yiyou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;

typedef NS_ENUM(NSUInteger, EmojiType) {
    kEmojiTypePNG      = 0,    // 静态图片
    kEmojiTypeGIF      = 1,    // 动态图片
};


@interface TTEmoji : NSObject

@property(nonatomic, strong) NSString *md5;    //旧：f001，新：微笑
@property(nonatomic, strong) NSString *image;    //本地图片路径
@property(nonatomic, strong) NSString *thumb;
@property(nonatomic, strong) NSString *text; //表情意义：微笑
@property(nonatomic, assign) EmojiType type;
@property(nonatomic, assign, getter=isDirect) BOOL direct;  // 是否直接发送

@property(nonatomic, assign, readonly, getter=isClassical) BOOL classical;  // 是否旧表情


- (instancetype)initWithAttributes:(NSDictionary *)attribute inCatelogName:(NSString *)catelogName;

- (UIImage *)emojiImage;

@end
