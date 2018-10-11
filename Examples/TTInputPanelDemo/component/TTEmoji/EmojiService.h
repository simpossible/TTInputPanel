//
//  EmojiService.h
//  TTService
//
//  Created by wilson on 15/5/27.
//  Copyright (c) 2015年 yiyou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TTEmojiCatelog;
@class TTEmoji;

@interface EmojiService : NSObject

+ (instancetype)currentService;

- (void)initBaseEmojis;


- (TTEmojiCatelog *)getEmojiCatelogByName:(NSString *)name;
- (NSArray<TTEmoji *> *)getEmojiListByCateloyName:(NSString *)cateloyName;


- (TTEmoji *)getEmojiByMd5:(NSString *)md5 excludeText:(BOOL)exclude;
- (NSString *)getTextByMd5:(NSString *)md5;
- (NSString *)getCatelogNameByMd5:(NSString *)md5;




@end
