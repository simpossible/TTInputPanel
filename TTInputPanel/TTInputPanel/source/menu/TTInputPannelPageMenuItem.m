//
//  TTInputPannelPageMenuItem.m
//  Masonry
//
//  Created by simp on 2017/10/22.
//

#import "TTInputPannelPageMenuItem.h"

@implementation TTInputPannelPageMenuItem

- (instancetype)initWithPage:(TTInputSourcePage *)page {
    if(self = [super init]) {
        _page = page;
        [self initialUI];
    }
    return self;
}

- (void)initialUI {
    self.backgroundColor = [UIColor yellowColor];
}

@end
