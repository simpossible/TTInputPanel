//
//  TTInputBarItem.m
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputBarItem.h"
#import "TTInputTextBarItem.h"
#import "TTInputNormalBarItem.h"

NSString * const TTInputBarFlex = @"flex";

NSString * const TTInputBarName = @"name";

NSString * const TTInputBarMargin = @"margin";

NSString * const TTInputBarMarginLeft = @"left";

NSString * const TTInputBarMarginRight = @"right";

NSString * const TTInputBarMarginTop = @"top";

NSString * const TTInputBarMarginBottom = @"bottom";


@interface TTInputBarItem ()

@property (nonatomic, assign) TTInputLayoutFlex defaultFlex;

@end

@implementation TTInputBarItem

+ (instancetype)barItemWithJson:(NSDictionary *)json {
    return [[self alloc] initWithJson:json];
}

+ (instancetype)barItemWithJson:(NSDictionary *)json andSourceType:(NSString *)type {
    
    if ([type isEqualToString:TTINPUTSOURCETYPENORMAL]) {
        return [[TTInputNormalBarItem alloc] initWithJson:json];
    }else if([type isEqualToString:TTINPUTSOURCETYPETEXTINPUT]) {
        return [[TTInputTextBarItem alloc] initWithJson:json];
    }else {
        return nil;
    }
}

- (instancetype)initWithJson:(NSDictionary *)json {
    if (self = [super init]) {
        
        self.defaultFlex = TTInputLayoutFlexFix;
        [self dealJson:json];
    }
    return self;
}


- (void)dealJson:(NSDictionary *)json {
    self.name = [json objectForKey:TTInputBarName];
    
    NSDictionary *margin = [json objectForKey:TTInputBarMargin];
    CGFloat left = [[margin objectForKey:TTInputBarMarginLeft] floatValue];
    CGFloat right = [[margin objectForKey:TTInputBarMarginRight] floatValue];
    CGFloat top = [[margin objectForKey:TTInputBarMarginTop] floatValue];;
    CGFloat botttom = [[margin objectForKey:TTInputBarMarginBottom] floatValue];
    
    self.margin = UIEdgeInsetsMake(top, left, botttom, right);
    
    //解析浮动属性 这个解析应该默认就行了
//    NSString *flex = [json objectForKey:TTINPUTBARITEFlEX];
//    if ([flex isEqualToString:TTINPUTBARITEFlEXFIX]) {
//        self.flex = TTInputLayoutFlexFix;
//    }else if ([flex isEqualToString:TTINPUTBARITEFlEXGREAT]) {
//        self.flex = TTInputLayoutFlexGreater;
//    }else if ([flex isEqualToString:TTINPUTBARITEFlEXGREAT]) {
//        self.flex = TTInputLayoutFlexLesser;
//    }else {
//    }
    
    CGFloat width = [[json objectForKey:@"width"] floatValue];
    CGFloat height = [[json objectForKey:@"height"] floatValue];
    self.width = width;
    self.height = height;
}


@end
