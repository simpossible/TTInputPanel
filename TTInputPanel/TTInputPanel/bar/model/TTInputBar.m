//
//  TTInputBar.m
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputBar.h"
#import "TTInputBarItem.h"
@interface TTInputBar()


@end

@implementation TTInputBar

- (instancetype)initWithSources:(NSArray<TTInputSource *> *)sources {
    if (self = [super init]) {
        self.sources = [NSMutableArray arrayWithArray:sources];
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
    for (TTInputSource *source in self.sources) {
        if (source.baritem.flex != TTInputLayoutFlexFix) {
            return YES;
        }
    }
    return NO;
}

@end
