//
//  TTCustomEmoji.m
//  TTService
//
//  Created by wangyilong on 2018/10/17.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import "TTCustomEmoji.h"

#define CUSTOMEMOJICDNPROXY @"http://appcdn.52tt.com/emoji/download/"

#define MAXEMOJIHEIGHT 128

@implementation TTCustomEmoji

- (instancetype)initWithPBEmojiItem:(EmojiItem *)emojiItem
{
    self = [super init];
    if (self) {
//        self.emojiId = emojiItem.emojiId;
//        self.url = emojiItem.URL;
//        self.thumbnail = emojiItem.thumbnail;
//        self.name = emojiItem.name;
//        self.desc = emojiItem.desc;
//        self.height = emojiItem.height;
//        self.width = emojiItem.width;
        [self dealSize];
    }
    return self;
}

- (instancetype)initWithPBEmojiMsg:(EmojiMsg *)emojimsg {
    self = [super init];
    if (self) {
//        self.emojiId = emojimsg.id_p;
//        self.url = emojimsg.URL;
//        self.height = emojimsg.height;
//        self.width = emojimsg.width;
        [self dealSize];
    }
    return self;
}

- (void)dealSize {
    
    if (self.height == 0 && self.width == 0) {
        self.height = 100;
        self.width = 100;
    }
    
    if (self.height > MAXEMOJIHEIGHT || self.width > MAXEMOJIHEIGHT) {
        CGFloat fdegree = MAXEMOJIHEIGHT/self.height;
        CGFloat wDegree = MAXEMOJIHEIGHT/self.width ;
        CGFloat finnalDegree = fdegree > wDegree?wDegree :fdegree;
        self.height = self.height * finnalDegree;
        self.width = self.width * finnalDegree;
    }
}

- (NSString *)thumbUrl {
    if (self.thumbnail.length != 0) {
        return self.thumbnail;
    }else {
        NSString *url= CUSTOMEMOJICDNPROXY;
        url = [NSString stringWithFormat:@"%@%@?imageView2/0/w/100/h/100",url,self.emojiId];
        return url;
    }
}

- (NSString *)bigUrl {
    if (self.url.length != 0) {
        return self.url;
    }else {
        NSString *url= CUSTOMEMOJICDNPROXY;
        url = [NSString stringWithFormat:@"%@%@",url,self.emojiId];
        return url;
    }
}

- (NSString *)thumbKey {
    return [NSString stringWithFormat:@"IM_Emoji_%@_thumb_%@",self.emojiId,[self thumbUrl]];
}

- (NSString *)emojiKey {
    return [NSString stringWithFormat:@"IM_Emoji_%@_emoji_%@",self.emojiId,[self bigUrl]];
}

@end
