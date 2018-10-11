//
//  TTEmojiCatelog.h
//  TTService
//
//  Created by wilson on 15/5/27.
//  Copyright (c) 2015年 yiyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTEmojiCatelog : NSObject


@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *title;


- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (NSString *)baseEmojisDirectory;


@end
