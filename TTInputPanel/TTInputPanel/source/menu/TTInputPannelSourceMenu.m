//
//  TTInputPannelSourceMenu.m
//  Masonry
//
//  Created by simp on 2017/10/22.
//

#import "TTInputPannelSourceMenu.h"

@interface TTInputPannelSourceMenu ()

@property (nonatomic, strong) UICollectionView * menuItemsCollection;

@end

@implementation TTInputPannelSourceMenu

- (instancetype)initWithSource:(TTInputSource *)source {
    if (self = [super init]) {
        [self initialUI];
    }
    return self;
}

- (void)initialUI {
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
