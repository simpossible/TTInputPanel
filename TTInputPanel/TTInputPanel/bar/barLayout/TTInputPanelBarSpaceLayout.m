//
//  TTInputPanelBarSpaceLayout.m
//  TTInputPanel
//
//  Created by simp on 2017/9/28.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputPanelBarSpaceLayout.h"
#import "TTInputBarItem.h"
#import "TTInputPanelBarItem.h"

@implementation TTInputPanelBarSpaceLayout


- (void)layoutItemForSources:(NSArray<TTInputSource *> *)sources inBar:(TTInputPanelBar *)bar{
    
    [bar.superview layoutIfNeeded];
    
    CGFloat width = CGRectGetWidth(bar.frame);
    
    CGFloat layoutWidth = 0;
    CGFloat totoalItemWidth = 0;
    
    //最小的空格间隙
    CGFloat minSpace = 5;
    
    NSInteger itemIndex = 0;
    
    for (int i = 0; i < sources.count; i ++) {
        TTInputSource *source = sources[i];
        TTInputBarItem *item = source.baritem;
        totoalItemWidth += item.margin.left;
        totoalItemWidth += item.width;
        totoalItemWidth += item.margin.right;
        layoutWidth = totoalItemWidth + minSpace * 2;
        //已经超过达到能布局的最大个数了
        if (layoutWidth > width) {
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
    
    CGFloat totoalSpace = width - totoalItemWidth;
    CGFloat eachSpace = totoalSpace / itemIndex;
    
    [self layoutItems:sources inBar:bar withSpace:eachSpace itemIndex:itemIndex];
    

}

- (void)layoutItems:(NSArray<TTInputSource *> *)sources inBar:(TTInputPanelBar *)bar withSpace:(CGFloat)space itemIndex:(NSInteger)itemIndex{
    
    TTInputPanelBarItem *lastPanelItem = nil;
    TTInputBarItem *lastInputItem = nil;
    
    for (int i = 0; i <= itemIndex; i ++) {
         TTInputSource *source = sources[i];
        TTInputBarItem *item = source.baritem;
        TTInputPanelBarItem *panelItem = [TTInputPanelBarItem panelItemWithSource:source];
        [bar addSubview:panelItem];
        
        [panelItem mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(bar.mas_top).offset(item.margin.top);
            make.height.mas_equalTo(item.height);
            
            if (lastInputItem) {
                make.left.equalTo(lastPanelItem.mas_right).offset(item.margin.left+lastInputItem.margin.right + space);
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
            }
        }];
        
        
        lastInputItem = item;
        lastPanelItem = panelItem;
    }
    
}

@end
