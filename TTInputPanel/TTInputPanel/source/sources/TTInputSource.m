//
//  TTInputSource.m
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputSource.h"
#import "TTInputTextSource.h"
#import "TTInputNormlSouce.h"
#import "TTInputUtil.h"
#import "TTInputSourcePage.h"

@interface TTInputSource()

@property (nonatomic, copy) NSString * name;

@end

@implementation TTInputSource

+ (TTInputSource *)sourcesFromDic:(NSDictionary *)sourceDic {
    NSString *type = [sourceDic objectForKey:TTINPUTSOURCETYPE];
    if ([type isEqualToString:TTINPUTSOURCETYPETEXTINPUT]) {
        return [[TTInputTextSource alloc] initWithSource:sourceDic];
    }else if ([type isEqualToString:TTINPUTSOURCETYPENORMAL]) {
        return [[TTInputNormlSouce alloc] initWithSource:sourceDic];
    }
    return [[self alloc] initWithSource:sourceDic];
}

+ (TTInputSource *)normalSource {
   return [[TTInputNormlSouce alloc] init];
}

+ (TTInputSource *)textInputSource {
     return [[TTInputTextSource alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
    
        self.flex = TTInputLayoutFlexFix;
    }
    return self;
}

- (instancetype)initWithSource:(NSDictionary *)dic {
    if (self = [super init]) {
        [self dealSourceDic:dic];
        [self genrateBarView];
        self.flex = TTInputLayoutFlexFix;
    }
    return self;
}

- (void)dealSourceDic:(NSDictionary *)dic {
    self.name = [dic objectForKey:@"name"];
  
    
    [self generateView];
    
    //初始化baritem 的属性
    NSDictionary *barItemJson = [dic objectForKey:@"baritem"];
    self.barItemMargin = [TTInputUtil marginFromDic:[barItemJson objectForKey:TTInputMargin]];
    CGFloat width = [[barItemJson objectForKey:@"width"] floatValue];
    CGFloat height = [[barItemJson objectForKey:@"height"] floatValue];
    self.barItemSize = CGSizeMake(width, height);
}

- (void)initialUI {
    [self generateView];
    [self genrateBarView];
}

- (void)initialData {
    
}
- (void)dealItemSource {
    
}

- (void)generateView {
    self.sourceView = [[UIView alloc] init];
}

- (void)genrateBarView {
    self.barView = [[UIControl alloc] init];
    self.barView.backgroundColor = [UIColor blueColor];
}

- (void)disappearSource {
    
}
- (void)becomeFoucus{
    
}

- (void)resignFocus {
    
}

- (void)setFoucesHeight:(CGFloat)foucesHeight {
    _foucesHeight = foucesHeight;
    [self.sourceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(foucesHeight);
    }];
}


@end
