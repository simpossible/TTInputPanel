//
//  TTEmojiCatelog.m
//  TTService
//
//  Created by wilson on 15/5/27.
//  Copyright (c) 2015年 yiyou. All rights reserved.
//

#import "TTEmojiCatelog.h"
#import "TTEmoji.h"

@implementation TTEmojiCatelog

- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        self.name = [attributes objectForKey:@"name"];
        self.title = [attributes objectForKey:@"title"];
        
    
    }
    return self;
}

+ (NSString *)baseEmojisDirectory{
    
    static NSString *emojisDirectory = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        emojisDirectory = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"emojis"];
    });
    
    return emojisDirectory;
}

@end
