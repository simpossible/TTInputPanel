//
//  TTFuncSourceItem.h
//  TT
//
//  Created by simp on 2018/10/18.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import "TTInputSourceItem.h"

typedef NS_ENUM(NSUInteger,TTFuncType) {
    TTFuncTypePicture,
    TTFuncTypeTakePhoto,
    TTFuncTypeIMMute,
    TTFuncTypeIMUnMute,
    TTFuncTypeRoom,
};

@interface TTFuncSourceItem : TTInputSourceItem

@property (nonatomic, copy) NSString * name;

@property (nonatomic, copy) NSString * imageName;

@property (nonatomic, assign) TTFuncType type;

- (void)changeToType:(TTFuncType)type;

+ (instancetype)itemWithType:(TTFuncType)type;

+ (instancetype)photoItem;

+ (instancetype)albumItem;

+ (instancetype)openBlackItem;
@end
