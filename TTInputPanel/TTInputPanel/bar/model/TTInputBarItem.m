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
#import "TTInputUtil.h"

NSString * const TTInputBarFlex = @"flex";

NSString * const TTInputBarName = @"name";



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
    
    self.margin = [TTInputUtil marginFromDic:[json objectForKey:TTInputMargin]];
    
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

- (void)setIsFoucus:(BOOL)isFoucus {
    if ([self.delegate respondsToSelector:@selector(itemFoucusWillChange)]) {
        [self.delegate itemFoucusWillChange];
    }
    _isFoucus = isFoucus;
    if ([self.delegate respondsToSelector:@selector(itemFoucusChanged:)]) {
        [self.delegate itemFoucusChanged:self];
    }
    
}


@end
