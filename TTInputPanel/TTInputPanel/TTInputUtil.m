//
//  TTInputUtil.m
//  Masonry
//
//  Created by simp on 2017/10/27.
//

#import "TTInputUtil.h"
#import "TTInputPanelDefine.h"

@implementation TTInputUtil

+ (UIEdgeInsets)marginFromDic:(NSDictionary *)margin {   
    CGFloat left = [[margin objectForKey:TTInputMarginLeft] floatValue];
    CGFloat right = [[margin objectForKey:TTInputMarginRight] floatValue];
    CGFloat top = [[margin objectForKey:TTInputMarginTop] floatValue];;
    CGFloat botttom = [[margin objectForKey:TTInputMarginBottom] floatValue];
    
    return UIEdgeInsetsMake(top, left, botttom, right);;
}


+ (CGSize)sizeFromDic:(NSDictionary *)dic {
    CGFloat width = [[dic objectForKey:TTInputSizeWidth] floatValue];
    CGFloat height = [[dic objectForKey:TTInputSizeHeight] floatValue];
    return CGSizeMake(width, height);
}
@end
