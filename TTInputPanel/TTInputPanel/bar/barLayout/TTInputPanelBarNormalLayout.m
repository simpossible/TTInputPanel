//
//  TTInputPanelBarNormalLayout.m
//  Masonry
//
//  Created by simp on 2017/10/8.
//

#import "TTInputPanelBarNormalLayout.h"
#import <Masonry.h>
#import "TTInputSource.h"

@implementation TTInputPanelBarNormalLayout

- (void)layoutItemForSources:(NSArray<TTInputSource *> *)sources inBar:(TTInputBar *)bar {
    
    [bar.superview layoutIfNeeded];
    
    CGFloat width = CGRectGetWidth(bar.frame);
    
    CGFloat totoalItemWidth = 0;
    
    
    NSInteger itemIndex = 0;
    
    for (int i = 0; i < sources.count; i ++) {
        TTInputSource *source = sources[i];
        totoalItemWidth += source.barItemMargin.left;
        totoalItemWidth += source.barItemSize.width;
        totoalItemWidth += source.barItemMargin.right;
        //已经超过达到能布局的最大个数了
        if (totoalItemWidth > width) {
            if (i == 1) {
                NSLog(@"item 占用太多");
            }else {
                //跳出循环
                itemIndex = i - 1;
                break;
            }
        }
        
        itemIndex = i;
    }
    
    [self layoutItems:sources inBar:bar itemIndex:itemIndex];
    
    
}

- (void)layoutItems:(NSArray<TTInputSource *> *)sources inBar:(TTInputBar *)bar itemIndex:(NSInteger)itemIndex{
    
    UIView *lastPanelItem = nil;
    TTInputSource *lastSoure = nil;
    for (int i = 0; i <= itemIndex; i ++) {
        
        TTInputSource *source = [sources objectAtIndex:i];
        UIView *panelItem = source.barView;
        [bar addSubview:panelItem];
        
        [panelItem mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(bar.mas_top).offset(source.barItemMargin.top);
            make.height.mas_equalTo(source.barItemSize.height);
            
            if (lastPanelItem) {
                make.left.equalTo(lastPanelItem.mas_right).offset(source.barItemMargin.left+lastSoure.barItemMargin.right);
            }else {
                make.left.equalTo(bar.mas_left).offset(source.barItemMargin.left);
            }
            
            
            if (source.flex == TTInputLayoutFlexFix) {
                make.width.mas_equalTo(source.barItemSize.width);
            }else if (source.flex == TTInputLayoutFlexGreater) {
                make.width.mas_greaterThanOrEqualTo(source.barItemSize.width);
            }else if (source.flex == TTInputLayoutFlexLesser) {
                make.width.mas_lessThanOrEqualTo(source.barItemSize.width);
            }else {
                make.width.mas_equalTo(source.barItemSize.width);
            }
            
            if (i == itemIndex) {//布局到了最后一个
                //                make.right.equalTo(bar.mas_right).offset(-(item.margin.right + space));
                make.right.equalTo(bar.mas_right).offset(-lastSoure.barItemMargin.right);
            }
        }];
        
        
        lastSoure = source;
        lastPanelItem = panelItem;
    }
    
}

@end
