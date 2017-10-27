//
//  TTInputPanelNormalBarItem.m
//  TTInputPanel
//
//  Created by simp on 2017/9/26.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputPanelNormalBarItem.h"

@interface TTInputPanelNormalBarItem ()
@property (nonatomic, strong) UIImageView * icon;
@end

@implementation TTInputPanelNormalBarItem



- (instancetype)initWithSource:(TTInputSource *)source {
    if (self = [super initWithSource:source]) {
        [self initialUI];
    }
    return self;
}

- (void)initialUI {
    [self initialIcon];
    [self addTarget:self action:@selector(itemCliecked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initialIcon {
    self.icon = [[UIImageView alloc] init];
    [self addSubview:self.icon];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    TTInputNormalBarItem *item = self.source.baritem;
    self.icon.image = item.icon;
}

- (void)itemCliecked:(id)sender {
    TTIInputSoureFocusState state = self.source.focusState == TTIInputSoureFocusStateFoucus?TTIInputSoureFocusStateNone:TTIInputSoureFocusStateFoucus;
    [self.source setFocusState:state];
}


@end
