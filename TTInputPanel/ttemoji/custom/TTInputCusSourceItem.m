//
//  TTInputCusSourceItem.m
//  TT
//
//  Created by simp on 2018/10/19.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import "TTInputCusSourceItem.h"
#import "TTCustomEmojiPackage.h"
#import <SDWebImage/SDWebImageManager.h>
#import "TTCustomEmoji.h"
#import <YYKit/YYKit.h>







@interface TTInputCusSourceItem()

@property (nonatomic, strong) UIImage * thumbImage;

@property (nonatomic, strong) UIImage * bigImage;

@property (nonatomic, assign) TTInputCusSourceItemState customState;

@property (nonatomic, assign) NSInteger tryBigTime;

@property (nonatomic, assign) NSInteger tryThumbTime;


@end

@implementation TTInputCusSourceItem

- (instancetype)init {
    if (self = [super init]) {
        self.identifier = @"TTInputCustomEmojiCell";
        self.tryBigTime = 0;
        self.tryThumbTime = 0;
    }
    return self;
}

- (instancetype)initWithEmoji:(TTCustomEmoji *)emoji {
    if (self = [super init]) {
        self.identifier = @"TTInputCustomEmojiCell";
        self.emoji = emoji;
        self.tryBigTime = 0;
        self.tryThumbTime = 0;
    }
    return self;
}

- (void)load {
    
}

- (void)setEmoji:(TTCustomEmoji *)emoji {
    _emoji = emoji;
    if (self.customState == TTInputCusSourceItemStateConfigring && emoji) {
        self.customState = TTInputCusSourceItemStateNone;
    }
}

- (void)setCustomState:(TTInputCusSourceItemState)customState {
    _customState = customState;
    if ([self.delegate respondsToSelector:@selector(itemStateChanged)]) {
        [self.delegate itemStateChanged];
    }
}

- (void)loadThumb {
    
 
    
    if (!self.emoji) {
        return;
    }
    if (self.tryThumbTime > 3) {
        return;
    }
    if (self.thumbImage) {
        return;
    }
    if (self.customState == TTInputCusSourceItemStateThumbDownloading) {
        return;
    }
    self.customState = TTInputCusSourceItemStateThumbDownloading;
    NSURL * url = [NSURL URLWithString:[self.emoji thumbUrl]];
    __weak typeof(self)wself = self;
    NSString *key = [self.emoji thumbKey];
//    UIImage *image = [IMAttachmentHelper imageForKey:key];
    NSData *data = nil;//[IMAttachmentHelper imageDataForKey:key];
    if (data) {
        YYImage *image = [[YYImage alloc] initWithData:data];
        self.thumbImage = image;
        self.itemImg = image;
        self.customState = TTInputCusSourceItemStateNone;
    }else {
        self.tryThumbTime ++;
       
        [[SDWebImageManager sharedManager] loadImageWithURL:url options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
//            [IMAttachmentHelper saveImage:image withData:data forKey:key];
            YYImage *yimage = [[YYImage alloc] initWithData:data];
            wself.thumbImage = yimage;
            wself.itemImg = yimage;
            wself.customState = TTInputCusSourceItemStateNone;
        }];
    }
}

- (void)loadConfig {
    if (self.customState == TTInputCusSourceItemStateConfigring) {
        return;
    }
    self.customState = TTInputCusSourceItemStateConfigring;
    TTCustomEmoji *emoji = [self.package emojiAtIndex:self.index];
    if (emoji) {
        self.emoji = emoji;
        [self loadThumb];
    }else {
        [self.package loadItemAt:self.index];
    }
}


- (NSString *)thumbKey {
    return [NSString stringWithFormat:@"IM_Emoji_%@_thumb",self.emoji.emojiId];
}

- (NSString *)emojiKey {
    return [NSString stringWithFormat:@"IM_Emoji_%@_emoji",self.emoji.emojiId];
}

- (void)loadBigImage {
    if (!self.bigImage) {
        if (self.customState == TTInputCusSourceItemStateImageDownloading) {
            return;
        }
        if (self.tryBigTime > 3) {
            return;
        }
        self.customState = TTInputCusSourceItemStateImageDownloading;
        NSURL * url = [NSURL URLWithString:[self.emoji bigUrl]];
        __weak typeof(self)wself = self;
        NSString *key = [self.emoji emojiKey];
//        UIImage *image = [IMAttachmentHelper imageForKey:key];
        NSData *data = nil;//[IMAttachmentHelper imageDataForKey:key];
        if (data) {
            YYImage *image = [[YYImage alloc] initWithData:data];
            self.bigImage = image;
            self.customState = TTInputCusSourceItemStateNone;
        }else {
            self.tryBigTime ++;
            [[SDWebImageManager sharedManager] loadImageWithURL:url options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                YYImage *yimage = [[YYImage alloc] initWithData:data];
                if (data) {
//                    [IMAttachmentHelper saveImage:image withData:data forKey:key];
                }
                wself.bigImage = yimage;
                wself.customState = TTInputCusSourceItemStateNone;
            }];
        }
    }
   
}

- (void)clearThumbImage {
    self.thumbImage = nil;
}

- (void)loadItemImage {
    
}
@end
