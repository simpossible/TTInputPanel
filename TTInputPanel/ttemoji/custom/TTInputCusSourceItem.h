//
//  TTInputCusSourceItem.h
//  TT
//
//  Created by simp on 2018/10/19.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import "TTInputSourceItem.h"
@class TTCustomEmojiPackage;

/**
 TTInputSourceItem 的状态

 - TTInputCusSourceItemStateNone: 初始化
 - TTInputCusSourceItemStateConfigring: 拉取对应的配置中
 - TTInputCusSourceItemStateThumbDownloading: 下载缩略图
 - TTInputCusSourceItemStateImageDownloading: 下载真正的大图
 */
typedef NS_ENUM(NSUInteger,TTInputCusSourceItemState) {
    TTInputCusSourceItemStateNone,
    TTInputCusSourceItemStateConfigring,
    TTInputCusSourceItemStateThumbDownloading,
    TTInputCusSourceItemStateImageDownloading,
};

@protocol TTInputCusSourceItemProtocol <NSObject>

- (void)itemStateChanged;

@end

@class TTCustomEmoji;

@interface TTInputCusSourceItem : TTInputSourceItem

@property (nonatomic, strong, readonly) UIImage * thumbImage;

@property (nonatomic, strong, readonly) UIImage * bigImage;

@property (nonatomic, assign, readonly) TTInputCusSourceItemState customState;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) TTCustomEmojiPackage * package;

@property (nonatomic, strong) TTCustomEmoji * emoji;

@property (nonatomic, weak) id<TTInputCusSourceItemProtocol> delegate;

/**用于IM cell 的显示*/
- (instancetype)initWithEmoji:(TTCustomEmoji *)emoji;

/**防止内存过大的问题*/
- (void)clearThumbImage;


- (void)loadBigImage;

/**加载缩略图*/
- (void)loadThumb;


- (void)loadConfig;
@end
