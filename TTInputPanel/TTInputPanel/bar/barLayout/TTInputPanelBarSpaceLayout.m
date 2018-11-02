//
//  TTInputPanelBarSpaceLayout.m
//  TTInputPanel
//
//  Created by simp on 2017/9/28.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputPanelBarSpaceLayout.h"
#import <Masonry/Masonry.h>
@implementation TTInputPanelBarSpaceLayout


- (void)layoutItemForSources:(NSArray<TTInputSource *> *)sources inBar:(TTInputBar *)bar{
    
    [bar.superview layoutIfNeeded];
    
    CGFloat width = CGRectGetWidth(bar.frame);
    
    CGFloat layoutWidth = 0;
    CGFloat totoalItemWidth = 0;
    
    //最小的空格间隙
    CGFloat minSpace = 5;
    
    NSInteger itemIndex = 0;
    
    for (int i = 0; i < sources.count; i ++) {
        TTInputSource *source = sources[i];

        totoalItemWidth += source.barItemMargin.left;
        totoalItemWidth += source.barItemSize.width;
        totoalItemWidth += source.barItemMargin.right;
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

- (void)layoutItems:(NSArray<TTInputSource *> *)sources inBar:(TTInputBar *)bar withSpace:(CGFloat)space itemIndex:(NSInteger)itemIndex{
    
    UIView *lastPanelItem = nil;
    TTInputSource *lastSource = nil;
    for (int i = 0; i <= itemIndex; i ++) {
         TTInputSource *source = sources[i];
        UIView *panelItem = source.barView;
        [bar addSubview:panelItem];
        
        [panelItem mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(bar.mas_top).offset(source.barItemMargin.top);
            make.height.mas_equalTo(source.barItemSize.height);
            
            if (lastPanelItem) {
                make.left.equalTo(lastPanelItem.mas_right).offset(source.barItemMargin.left+lastSource.barItemMargin.right + space);
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
            }
        }];
        
        
        lastSource = source;
        lastPanelItem = panelItem;
    }
    
}

@end
