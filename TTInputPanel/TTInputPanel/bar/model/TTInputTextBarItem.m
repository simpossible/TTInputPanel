//
//  TTInputTextBarItem.m
//  TTInputPanel
//
//  Created by simp on 2017/9/26.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputTextBarItem.h"

@implementation TTInputTextBarItem

- (instancetype)initWithJson:(NSDictionary *)json {
    if (self = [super init]) {
        self.flex = TTInputLayoutFlexGreater;
        [self dealJson:json];
    }
    return self;
}

- (void)dealJson:(NSDictionary *)json {
    [super dealJson:json];
}

@end
