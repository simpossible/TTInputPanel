//
//  TTInputMenu.m
//  TTInputPanel
//
//  Created by simp on 2017/11/1.
//

#import "TTInputMenu.h"

@interface TTInputMenu()

@property (nonatomic, strong) NSMutableArray * items;

@end

@implementation TTInputMenu


- (instancetype)initWithItems:(NSArray<TTinputMenuItem *> *)items {
    if(self = [super init]) {
        self.items = items;
    }
    return self;
}

- (void)addItem:(TTinputMenuItem *)item {
    if(item) {
        [self.items addObject:item];
    }
}

- (void)loadItems {
    for (TTinputMenuItem *item in self.items) {
        if(item.superview) {
            [item removeFromSuperview];
        }
    }
    __weak typeof(self)wself = self;
    
    TTinputMenuItem *lastItem = nil;
    CGFloat allWidth = 0;
    for (int i = 0; i < self.items.count; i ++) {
        TTinputMenuItem *currentItem = self.items[i];
        [self addSubview:currentItem];
        if (allWidth + currentItem.width > self.frame.size.width) {//超过了最大宽度
            if (lastItem){
                [lastItem mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.mas_right);
                }];
            }
        }else {
            if(lastItem){//如果不是第一个
                    [currentItem mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(lastItem.mas_right);
                        if (i == self.items.count-1) {//最后一个
                            make.right.equalTo(self.mas_right);
                        }
                        [wself layoutWidthForItem:currentItem atConstraint:make];
                        make.height.equalTo(self.mas_height);
                        make.top.equalTo(self.mas_top);
                    }];

            }else {//如果是第一个
                [currentItem mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left);
                    [wself layoutWidthForItem:currentItem atConstraint:make];
                    make.height.equalTo(self.mas_height);
                    make.top.equalTo(self.mas_top);
                    if (i == self.items.count-1) {//最后一个
                        make.right.equalTo(self.mas_right);
                    }
                }];
            }
        }
        
        lastItem = currentItem;
    }
    
}

/**确定宽度的约束*/
- (void)layoutWidthForItem:(TTinputMenuItem *)item atConstraint:(MASConstraintMaker *)make{
    if(item.flex == TTInputLayoutFlexFix) {
        make.width.mas_equalTo(item.width);
    }else if(item.flex == TTInputLayoutFlexGreater) {
        make.width.mas_greaterThanOrEqualTo(item.width);
    }else if (item.flex == TTInputLayoutFlexLesser) {
        make.width.mas_lessThanOrEqualTo(item.width);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect {
    [self loadItems];
}


@end
