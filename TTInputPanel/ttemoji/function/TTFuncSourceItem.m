//
//  TTFuncSourceItem.m
//  TT
//
//  Created by simp on 2018/10/18.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import "TTFuncSourceItem.h"

@interface TTFuncSourceItem()


@end

@implementation TTFuncSourceItem

- (instancetype)init {
    if (self = [super init]) {
        self.identifier = @"TTInputFuncCell";
    }
    return self;
}

+ (instancetype)itemWithType:(TTFuncType)type {
    TTFuncSourceItem *item =  [self itemForPicName:[self imgForType:type] andName:[self nameForType:type]];
    item.type = type;
    return item;
}

- (void)changeToType:(TTFuncType)type {
    self.imageName = [TTFuncSourceItem imgForType:type];
    self.name = [TTFuncSourceItem nameForType:type];
    self.type = type;
}

+ (NSString *)nameForType:(TTFuncType)type {
    if (type == TTFuncTypePicture) {
        return NSLocalizedString(@"picture", nil);
    }else if (type == TTFuncTypeTakePhoto) {
        return NSLocalizedString(@"take_photo", nil);
    }else if (type == TTFuncTypeIMMute) {
        return NSLocalizedString(@"forbid_all_talk", nil);
    }else if (type == TTFuncTypeIMUnMute) {
        return NSLocalizedString(@"forbid_all_talk", nil);
    }else if (type == TTFuncTypeRoom) {
        return NSLocalizedString(@"my_room", nil);
    }
    return @"";
}

+ (NSString *)imgForType:(TTFuncType)type {
  
    if (type == TTFuncTypePicture) {
        return @"ic_im_more_photo_default";
    }else if (type == TTFuncTypeTakePhoto) {
        return @"ic_im_more_take_photo_default";
    }else if (type == TTFuncTypeIMMute) {
        return @"ic_im_more_take_all_no_talking_off_default";
    }else if (type == TTFuncTypeIMUnMute) {
        return @"ic_im_more_take_all_no_talking_on_default";
    }else if (type == TTFuncTypeRoom) {
        return @"ic_im_more_my_room_default";
    }
    return @"";
}



+ (instancetype)itemForPicName:(NSString *)picname andName:(NSString *)name {
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat funcWidth = width/4;
    TTFuncSourceItem *item = [[TTFuncSourceItem alloc] init];
    item.imageName = picname;
    item.name = name;
//    item.itemImg = [UIImage imageNamed:picname];
    item.itemSize = CGSizeMake(funcWidth, 94);
    item.margin = UIEdgeInsetsZero;
    return item;
}
@end
