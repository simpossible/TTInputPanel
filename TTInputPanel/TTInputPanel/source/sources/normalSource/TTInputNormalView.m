//
//  TTInputNormalView.m
//  Masonry
//
//  Created by simp on 2018/10/16.
//

#import "TTInputNormalView.h"

@interface TTInputNormalView()
@end

@implementation TTInputNormalView

- (instancetype)init {
    if (self = [super init]) {
        
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.drawCallBack) {
        self.drawCallBack();
        self.drawCallBack = nil;
    }
}

@end
