//
//  TTInputSource.m
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputSource.h"

@interface TTInputSource()
@property (nonatomic, copy) NSString * name;
@end

@implementation TTInputSource

+ (TTInputSource *)sourcesFromDic:(NSDictionary *)sourceDic {
    return [[self alloc] initWithSource:sourceDic];
}

- (instancetype)initWithSource:(NSDictionary *)dic {
    if (self = [super init]) {
        [self dealSourceDic:dic];
    }
    return self;
}

- (void)dealSourceDic:(NSDictionary *)dic {
    
    self.name = [dic objectForKey:@"name"];
    NSDictionary *barItemJson = [dic objectForKey:@"baritem"];
    
    NSString *type = [dic objectForKey:TTINPUTSOURCETYPE];
    self.baritem = [TTInputBarItem barItemWithJson:barItemJson andSourceType:type];
    
}

@end
