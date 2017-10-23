//
//  TTInputPanelBarNormalLayout.m
//  Masonry
//
//  Created by simp on 2017/10/8.
//

#import "TTInputPanelBarNormalLayout.h"
#import <Masonry.h>

@implementation TTInputPanelBarNormalLayout

- (void)layoutItemForSources:(NSArray<TTInputSource *> *)sources inBar:(TTInputPanelBar *)bar {
    
    [bar.superview layoutIfNeeded];
    
    CGFloat width = CGRectGetWidth(bar.frame);
    
    CGFloat totoalItemWidth = 0;
    
    
    NSInteger itemIndex = 0;
    
    for (int i = 0; i < sources.count; i ++) {
        TTInputSource *source = sources[i];
        TTInputBarItem *item = source.baritem;
        totoalItemWidth += item.margin.left;
        totoalItemWidth += item.width;
        totoalItemWidth += item.margin.right;
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

- (void)layoutItems:(NSArray<TTInputSource *> *)sources inBar:(TTInputPanelBar *)bar itemIndex:(NSInteger)itemIndex{
    
    TTInputPanelBarItem *lastPanelItem = nil;
    TTInputBarItem *lastInputItem = nil;
    
    for (int i = 0; i <= itemIndex; i ++) {
        
        TTInputSource *source = [sources objectAtIndex:i];
        TTInputBarItem *item = source.baritem;
        TTInputPanelBarItem *panelItem = [TTInputPanelBarItem panelItemWithSource:source];
        [bar addSubview:panelItem];
        
        [panelItem mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(bar.mas_top).offset(item.margin.top);
            make.height.mas_equalTo(item.height);
            
            if (lastInputItem) {
                make.left.equalTo(lastPanelItem.mas_right).offset(item.margin.left+lastInputItem.margin.right);
            }else {
                make.left.equalTo(bar.mas_left).offset(item.margin.left);
            }
            
            
            if (item.flex == TTInputLayoutFlexFix) {
                make.width.mas_equalTo(item.width);
            }else if (item.flex == TTInputLayoutFlexGreater) {
                make.width.mas_greaterThanOrEqualTo(item.width);
            }else if (item.flex == TTInputLayoutFlexLesser) {
                make.width.mas_lessThanOrEqualTo(item.width);
            }else {
                make.width.mas_equalTo(item.width);
            }
            
            if (i == itemIndex) {//布局到了最后一个
                //                make.right.equalTo(bar.mas_right).offset(-(item.margin.right + space));
                make.right.equalTo(bar.mas_right).offset(-lastInputItem.margin.right);
            }
        }];
        
        
        lastInputItem = item;
        lastPanelItem = panelItem;
    }
    
}

@end
