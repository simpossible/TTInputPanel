//
//  TTEmoji.m
//  TTService
//
//  Created by wilson on 15/5/27.
//  Copyright (c) 2015年 yiyou. All rights reserved.
//

#import "TTEmoji.h"
#import "TTEmojiCatelog.h"
#import "EmojiUtil.h"

@implementation TTEmoji

- (instancetype)initWithAttributes:(NSDictionary *)attribute inCatelogName:(NSString *)catelogName{
    self = [super init];
    if (self) {
//        NSString *emojisDirectory = [TTEmojiCatelog baseEmojisDirectory];
        self.md5 = [attribute objectForKey:@"md5"];
//        self.image = [NSString stringWithFormat:@"%@/%@/%@/%@", emojisDirectory, catelogName, @"images", self.md5];
        self.image = self.md5;
//        self.thumb = [NSString stringWithFormat:@"%@/%@/%@/%@", emojisDirectory, catelogName, @"thumbs", self.md5];
        self.thumb = self.md5;
        self.text = [attribute objectForKey:@"text"];
        self.type = [[attribute objectForKey:@"type"] integerValue];
        self.direct = [[attribute objectForKey:@"direct"] boolValue];
        
        NSString *oldEmojiRegex = @"f0[0-9]{2}";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", oldEmojiRegex];
        _classical = [predicate evaluateWithObject:self.md5];
        
        
    }
    return self;
}

- (UIImage *)emojiImage {
   return [EmojiUtil getFaceImage:self.thumb];
}

@end
