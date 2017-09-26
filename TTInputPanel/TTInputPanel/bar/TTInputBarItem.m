//
//  TTInputBarItem.m
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputBarItem.h"

NSString * const TTInputBarFlex = @"flex";

NSString * const TTInputBarName = @"name";

NSString * const TTInputBarMargin = @"margin";

NSString * const TTInputBarMarginLeft = @"left";

NSString * const TTInputBarMarginRight = @"right";

NSString * const TTInputBarMarginTop = @"top";

NSString * const TTInputBarMarginBottom = @"bottom";


@interface TTInputBarItem ()

@end

@implementation TTInputBarItem

+ (instancetype)barItemWithJson:(NSDictionary *)json {
    return [[self alloc] initWithJson:json];
}

- (instancetype)initWithJson:(NSDictionary *)json {
    if (self = [super init]) {
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
    
    NSNumber *flex = [json objectForKey:@"flex"];
    self.flex =flex?[flex integerValue]:1000;
    
    CGFloat width = [[json objectForKey:@"width"] floatValue];
    CGFloat height = [[json objectForKey:@"height"] floatValue];
    self.width = width;
    self.height = height;
}

@end
