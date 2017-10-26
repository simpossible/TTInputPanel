//
//  TTInputNormlSouce.m
//  TTInputPanel
//
//  Created by simp on 2017/10/18.
//

#import "TTInputNormlSouce.h"
#import "TTInputNormalBarItem.h"

@interface TTInputNormlSouce ()

@end

@implementation TTInputNormlSouce

- (instancetype)initWithSource:(NSDictionary *)dic {
    if (self = [super initWithSource:dic]) {
        _sourceType = TTINPUTSOURCETYPENORMAL;
        self.focusState = TTIInputSoureFocusStateNone;
    }
    return self;
}


- (void)dealSourceDic:(NSDictionary *)dic {
    
    [super dealSourceDic:dic];
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
    }else {
    }
    
}

- (void)generateView {
    self.sourceView = [[UIScrollView alloc] init];
    self.sourceView.backgroundColor = [UIColor orangeColor];
    UIView *preview = nil;
    for (TTInputSourcePage *page in self.pages) {
        UIView *pageview = page.pageView;
        if (pageview) {
            [self.sourceView addSubview:pageview];
            if (preview) {
                [pageview mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(preview.mas_right);
                    make.top.equalTo(self.sourceView.mas_top);
                    make.width.equalTo(self.sourceView.mas_width);
                    make.height.equalTo(self.sourceView.mas_height);
                }];
            }else {
                [pageview mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.sourceView.mas_left);
                    make.top.equalTo(self.sourceView.mas_top);
                    make.width.equalTo(self.sourceView.mas_width);
                    make.height.equalTo(self.sourceView.mas_height);
                }];
            }
        }
        
    }
}

@end
