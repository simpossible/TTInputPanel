//
//  TTInputBar.m
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputBar.h"
#import "TTInputPanelBarNormalLayout.h"
@interface TTInputBar()

@property (nonatomic, strong) TTInputPanelBarLayout * layout;

@end

@implementation TTInputBar

- (instancetype)initWithSources:(NSArray<TTInputSource *> *)sources {
    if (self = [super init]) {
        self.sources = [NSMutableArray arrayWithArray:sources];
        self.layout = [TTInputPanelBarLayout layoutForType:self.layoutType];
        self.layer.borderWidth = 1;
    }
    return self;
}

- (void)setParameterWithJson:(NSDictionary *)json {
    CGFloat height = [[json objectForKey:@"barHeight"] floatValue];
//    self.barHeight = height;
    
    NSString *layout = [json objectForKey:TTINPUTBARITEMLAOUT];
    [self dealLayoutType:layout];
}

- (void)dealLayoutType:(NSString *)layoutType {
    //space布局
    if ([layoutType isEqualToString:TTINPUTBARITEMLAOUTSPACE]) {
        self.layoutType = TTInputBarLayoutTypeSpace;
    }else if ([layoutType isEqualToString:TTINPUTBARITEMLAOUTNORMAL]) {
        self.layoutType = TTInputBarLayoutTypeNormal;
    }else {
        self.layout = [TTInputPanelBarLayout layoutForType:self.layoutType];
    }
    
    
    
}

- (void)initialUI {
    [self.layout layoutItemForSources:self.sources inBar:self];
}


- (BOOL)haveFlexItem {
    for (TTInputSource *source in self.sources) {
        if (source.flex != TTInputLayoutFlexFix) {
            return YES;
        }
    }
    return NO;
}

- (void)setLayoutType:(TTInputBarLayoutType)layoutType {
    _layoutType = layoutType;
    self.layout = [TTInputPanelBarLayout layoutForType:layoutType];
}

- (void)drawRect:(CGRect)rect {
     [self initialUI];
}
@end
