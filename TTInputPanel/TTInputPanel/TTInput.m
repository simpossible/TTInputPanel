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

@interface TTInput ()

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
    [self.inpurtBar setParameterWithJson:barSetting];
}

- (void)dealSourcesaArray:(NSArray *)array {
    
    NSMutableArray *barItems = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        TTInputSource *source = [TTInputSource sourcesFromDic:dic];
        [self.sources addObject:source];
        [barItems addObject:source.baritem];
    }
    TTInputBar *bar = [[TTInputBar alloc] initWithBarItems:barItems];
    self.inpurtBar = bar;
}


@end
