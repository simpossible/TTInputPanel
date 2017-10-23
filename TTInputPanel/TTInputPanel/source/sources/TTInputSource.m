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

- (instancetype)initWithSource:(NSDictionary *)dic {
    if (self = [super init]) {
        [self dealSourceDic:dic];
    }
    return self;
}

- (void)dealSourceDic:(NSDictionary *)dic {
    self.name = [dic objectForKey:@"name"];
    NSArray *pages = [dic objectForKey:@"pages"];
    
    NSMutableArray *ttpages = [NSMutableArray array];
    for (NSDictionary *pagedic in pages) {
        TTInputSourcePage *page = [[TTInputSourcePage alloc] initFromDic:pagedic];
        [ttpages addObject:page];
    }
    self.pages = ttpages;
}



@end
