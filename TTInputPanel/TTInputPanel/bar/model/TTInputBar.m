//
//  TTInputBar.m
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputBar.h"

@interface TTInputBar()

@end

@implementation TTInputBar

- (instancetype)initWithBarItems:(NSArray *)array {
    if (self = [super init]) {
        self.items = [NSMutableArray arrayWithArray:array];
    }
    return self;
}

- (void)setParameterWithJson:(NSDictionary *)json {
    CGFloat height = [[json objectForKey:@"barHeight"] floatValue];
    self.barHeight = height;
    
    NSString *layout = [json objectForKey:TTINPUTBARITEMLAOUT];
    [self dealLayoutType:layout];
}

- (void)dealLayoutType:(NSString *)layoutType {
    //space布局
    if ([layoutType isEqualToString:TTINPUTBARITEMLAOUTSPACE]) {
        self.layoutType = TTInputBarLayoutTypeSpace;
    }else if ([layoutType isEqualToString:TTINPUTBARITEMLAOUTNORMAL]) {
        self.layoutType = TTInputBarLayoutTypeNormal;
    }
}


- (BOOL)haveFlexItem {
    for (TTInputBarItem *item in self.items) {
        if (item.flex != TTInputLayoutFlexFix) {
            return YES;
        }
    }
    return NO;
}

@end
