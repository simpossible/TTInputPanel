//
//  TTInput.m
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInput.h"


NSString * const TTInputName = @"name";

NSString * const TTInputSources = @"sources";

@interface TTInput ()<TTInputSourceProtocol>

@property (nonatomic, copy) NSString * name;

@end

@implementation TTInput


+ (instancetype)inputFromJsonData:(NSData *)data {
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (!error) {
        return  [[self alloc] initWithDicTionary:dic];
    }else {
        NSAssert(false, @"文件错误");
        return nil;
    }    
}


- (instancetype)initWithDicTionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.sources = [NSMutableArray array];
        [self dealJsonObject:dic];
    }
    return self;
}


- (void)dealJsonObject:(NSDictionary *)dic {
    self.name = [dic objectForKey:TTInputName];
    NSArray *sources = [dic objectForKey:TTInputSources];
    if (sources) {
        [self dealSourcesaArray:sources];
    }
    
    NSDictionary *barSetting = [dic objectForKey:@"bar"];
    
    CGFloat height = [[barSetting objectForKey:@"barHeight"] floatValue];
    self.barHeight = height;
    
    [self.inpurtBar setParameterWithJson:barSetting];
}

- (void)dealSourcesaArray:(NSArray *)array {
    
    for (NSDictionary *dic in array) {
        TTInputSource *source = [TTInputSource sourcesFromDic:dic];
        source.delegate = self;
        [self.sources addObject:source];
    }
    TTInputBar *bar = [[TTInputBar alloc] initWithSources:self.sources];
    self.inpurtBar = bar;
}

#pragma mark - source的代理

- (void)foucusChangedForSource:(TTInputSource *)soure {
    
    if (soure.focusState == TTIInputSoureFocusStateFoucus) {
        //这里需要先判断是否需要自动调整高度 text 的高度需要由text source 自己进行调整
        TTInputSource *currentFocus = self.focusSource;
        [currentFocus.sourceView removeFromSuperview];
        self.focusSource = soure;
        currentFocus.focusState = TTIInputSoureFocusStateNone;
        if ([self.delegate respondsToSelector:@selector(toChangeSourceHeight:time:animateOption:)]) {
            [self.delegate toChangeSourceHeight:soure.foucesHeight time:0.5 animateOption:0];
        }
    }else {
        if (self.focusSource == soure) {//如果是当前的焦点变化 那么变为0
            self.focusSource = nil;
            if ([self.delegate respondsToSelector:@selector(toChangeSourceHeight:time:animateOption:)]) {
                [self.delegate toChangeSourceHeight:0 time:0.5 animateOption:0];
            }
        }
    }
}

@end
