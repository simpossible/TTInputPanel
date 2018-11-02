//
//  TTCustomEmojiPackage.m
//  TTService
//
//  Created by wangyilong on 2018/10/17.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import "TTCustomEmojiPackage.h"

@interface TTCustomEmojiPackage()

@property (nonatomic, strong) NSMutableDictionary * itemsDic;

/**正在加载*/
@property (nonatomic, strong) NSMutableDictionary * loadingDic;

@end

@implementation TTCustomEmojiPackage

- (instancetype)initWithPBEmojiPackage:(EmojiPackage *)emojiPackage;
{
    self = [super init];
    if (self) {        
//        self.packageId = emojiPackage.packageId;
//        self.updateTime = emojiPackage.updateTime;
//        self.name = emojiPackage.name;
//        self.totalCount = emojiPackage.totalCount;
//        self.coverUrl = emojiPackage.coverURL;
//        self.ownerId = emojiPackage.ownerId;
//        self.type = emojiPackage.type;
        
        self.itemsDic = [NSMutableDictionary dictionary];
        self.loadingDic = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)loadItems {
//    [GET_SERVICE(EmojiService) getCustomEmojiList:self.packageId index:<#(UInt32)#> count:<#(UInt32)#> callback:<#^(NSArray *list)callback#>];
}

- (void)loadItemAt:(NSInteger)index {
    
    if (!self.itemsDic) {
        self.itemsDic = [NSMutableDictionary dictionary];
    }
    
//一页8个 8 个
    NSInteger startIndex = (index / 8) * 8;//开始位置
    NSInteger length = index % 8;
    if (startIndex + length < self.totalCount) {
        
        length = self.totalCount<8?self.totalCount:8;
    }
    
    TTCustomEmoji * emoji = [self emojiAtIndex:index];

    if (!emoji) {
        if (![self.loadingDic objectForKey:@(startIndex)]) {//查看是否已经在请求了
            __weak typeof(self)wself = self;
//            [self addLoadingStateAtIndex:startIndex add:YES widthCount:length];
//            [GET_SERVICE(EmojiService) getCustomEmojiList:self.packageId index:(UInt32)startIndex count:length callback:^(NSArray<TTCustomEmoji *> *list) {
//                [self addLoadingStateAtIndex:startIndex add:NO widthCount:length];
//                if (list) {
//                    for (int i = 0; i < length; i ++) {
//                        TTCustomEmoji *emoji;
//                        if (i < list.count) {//可能出现没有那么多的情况
//                            emoji = [list objectAtIndex:i];
//                            [self.itemsDic setObject:emoji forKey:@(startIndex + i)];
//                        }
//                        if ([wself.delegate respondsToSelector:@selector(packageItem:loadedAtIndex:)]) {
//                            [wself.delegate packageItem:emoji loadedAtIndex:startIndex + i];
//                        }
//                    }
//                }
            
//            }];
        }
    }
}

- (void)addLoadingStateAtIndex:(NSInteger)index add:(BOOL)add widthCount:(NSInteger)length{
    for (int i = 0; i < length; i ++) {
        if (add) {
            [self.loadingDic setObject:@(YES) forKey:@(index + i)];
        }else {
            [self.loadingDic removeObjectForKey:@(index + i)];
        }
    }
}

- (TTCustomEmoji *)emojiAtIndex:(NSInteger)index {
    return [self.itemsDic objectForKey:@(index)];
}


- (BOOL)isMyEmoji {
     return [self.packageId hasPrefix:@"EMOJI"];
}

- (NSString *)iconKey {
    return [NSString stringWithFormat:@"IM_EMOJI_PACK_%@_%@",self.packageId,self.coverUrl];
}
@end
