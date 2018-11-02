//
//  TTInputCustomPage.m
//  TT
//
//  Created by simp on 2018/10/19.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import "TTInputCustomPage.h"
#import "TTInputCusSourceItem.h"
#import "TTCustomEmojiPackage.h"
#import "TTInputMyEmojiEditItem.h"

@interface TTInputCustomPage()<TTCustomEmojiPackageProtocol>

@property (nonatomic, strong) TTCustomEmojiPackage * pakage;

@property (nonatomic, strong) NSMutableDictionary * customItems;

@end

@implementation TTInputCustomPage

- (instancetype)initWithPackage:(TTCustomEmojiPackage *)package {
    if (self = [super init]) {
        self.pakage = package;
        self.useItemLayout = NO;
        self.customItems = [NSMutableDictionary dictionary];
        package.delegate = self;
    }
    return self;
}


- (void)setPakage:(TTCustomEmojiPackage *)pakage {
    _pakage = pakage;
    self.itemCount = pakage.totalCount;
    self.itemCount = pakage.totalCount;
    if ([pakage.packageId hasPrefix:MYCUSTOMPREFIX]) {
        self.itemCount ++;
    }
}

- (TTInputSourceItem *)itemAtIndex:(NSInteger)index {
    TTInputCusSourceItem *item = [self.customItems objectForKey:@(index)];
    if (!item) {
        
        if ([self.pakage isMyEmoji] ) {//自定义的第一个是编辑
            if (index == 0) {
                TTInputMyEmojiEditItem * titem = [[TTInputMyEmojiEditItem alloc] init];
                titem.itemImg = [UIImage imageNamed:@"ic_emoji_add"];
                titem.name = @"编辑";
                [self.customItems setObject:titem forKey:@(index)];
                return titem;
            }else {
                item =  [[TTInputCusSourceItem alloc] init];
                [self.customItems setObject:item forKey:@(index)];
                item.index = index-1;
                item.package = self.pakage;
                [item loadConfig];
            }
            if (!item.emoji) {
                [item loadConfig];
            }
        }else {
            item =  [[TTInputCusSourceItem alloc] init];
            [self.customItems setObject:item forKey:@(index)];
            item.index = index;
            item.package = self.pakage;
            [item loadConfig];
        }

    }else {
        if ([self.pakage isMyEmoji] ) {//自定义的第一个是编辑
            if (index == 0) {
                TTInputMyEmojiEditItem * titem = (TTInputMyEmojiEditItem *)item;
                titem.itemImg = [UIImage imageNamed:@"ic_emoji_add"];
                titem.name = @"编辑";
                titem.cornerRadiu = 4;
                return titem;
            }else {
                item.index = index-1;
                item.package = self.pakage;
                [item loadConfig];
                [item loadThumb];
            }
        }
    }
    
  
    return item;
}

- (void)packageItem:(TTCustomEmoji *)emoji loadedAtIndex:(NSInteger)index {
    if ([self.pakage isMyEmoji]) {
        index ++;
    }
    TTInputCusSourceItem * item = [self.customItems objectForKey:@(index)];
    item.emoji = emoji;
    [item loadThumb];
}

- (void)loadItems {
    
}

- (NSString *)iconUrl {
    return self.pakage.coverUrl;
}


@end
