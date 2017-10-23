//
//  TTInputNormlSouce.m
//  TTInputPanel
//
//  Created by simp on 2017/10/18.
//

#import "TTInputNormlSouce.h"
#import "TTInputNormalBarItem.h"

@implementation TTInputNormlSouce

- (instancetype)initWithSource:(NSDictionary *)dic {
    if (self = [super initWithSource:dic]) {
        _sourceType = TTINPUTSOURCETYPENORMAL;
        self.focusState = TTIInputSoureFocusStateNone;
    }
    return self;
}


- (void)dealSourceDic:(NSDictionary *)dic {
    
    NSDictionary *barItemJson = [dic objectForKey:@"baritem"];
    self.baritem = [[TTInputNormalBarItem alloc] initWithJson:barItemJson];
    self.foucesHeight = [[dic objectForKey:@"focusheight"] integerValue];
}

#pragma mark - 焦点事件

- (void)setFocusState:(TTIInputSoureFocusState)focusState {
    if (focusState != _focusState) {
        [super setFocusState:focusState];
        if ([self.delegate respondsToSelector:@selector(foucusChangedForSource:)]) {
            [self.delegate foucusChangedForSource:self];
        }
    }
    
}

@end
