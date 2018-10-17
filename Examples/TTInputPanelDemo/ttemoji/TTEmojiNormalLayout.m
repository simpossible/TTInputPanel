//
//  TTEmojiNormalLayout.m
//  TTInputPanelDemo
//
//  Created by simp on 2018/10/17.
//  Copyright © 2018年 simp. All rights reserved.
//

#import "TTEmojiNormalLayout.h"
#import <TTInputNormlSouce.h>
#import <TTInputSourcePage.h>

@implementation TTEmojiNormalLayout

- (CGFloat)widthForPage:(TTInputSourcePage *)page section:(NSInteger)section lastSectionWidth:(CGFloat)lastWidth{
    if (page.itemCount == 0) {
        return 0;
    }
    
    CGFloat collectWidth = self.collectionView.bounds.size.width;
    CGFloat width = collectWidth - page.margin.left - page.margin.right;
    
    CGFloat height = self.collectionView.bounds.size.height;
    height = height - page.margin.top - page.margin.bottom;
    //先计算一个page 需要装多少个 页面
    NSInteger currentPage = 0;
    CGFloat alreadyWidth = 0;
    CGFloat alreadyHeight = 0;
    NSInteger currentLine = 0;//行
    
    NSInteger alreadyNumber = 0;//已经显示了的item 个数 用来限制每一页显示的最大个数
    
    CGFloat caculateWidth = page.itemSize.width + page.itemMargin.left;
    for (int i = 0; i < page.itemCount; i ++) {
        alreadyNumber ++;
        CGFloat nextWdith = alreadyWidth + caculateWidth;
        if(nextWdith > width + 0.05) {//最后一个可以贴着section 右 这里的0.05为 float 误差
            //应该换行了
            alreadyHeight += page.itemBoxHeight;
            currentLine += 1;
            alreadyWidth = 0;
            
            BOOL shouldToNextPage = NO;
            if (alreadyNumber > self.numberItemOneceShow && self.numberItemOneceShow != 0) {
                alreadyNumber = 1;
                shouldToNextPage = YES;
            }
            
            if (alreadyHeight + page.itemBoxHeight + page.lineSpace > height || shouldToNextPage) {//该换页了
                if (page.index == 0) {//第一个不要最后三个
                    i -= 3;//最后三个要变成一个空格
                }
                currentPage += 1;
                currentLine = 0;
                alreadyHeight = 0;
            }else {
                alreadyHeight += page.lineSpace;
            }
            
        }else {
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attr.size = page.itemSize;
        
        CGFloat centerX = 0;
        if (alreadyWidth == 0) {//第一个不要考虑左边距
            centerX =  lastWidth + alreadyWidth+page.itemSize.width/2 + currentPage * collectWidth + page.margin.left;
        }else {
            centerX =  lastWidth + alreadyWidth+page.itemSize.width/2 +page.itemMargin.left + currentPage * collectWidth + page.margin.left;
        }
        CGFloat centerY = alreadyHeight+page.itemSize.height/2 + page.margin.top + page.itemMargin.top;
        attr.center = CGPointMake(centerX, centerY);
        
        [self.cacheForItem setObject:attr forKey:@(i+1000*section)];
        
        if (alreadyWidth == 0) {
            alreadyWidth +=  page.itemMargin.right + page.itemSize.width;
        }else {
            alreadyWidth += page.itemBoxWidth;
        }
    }
    
    page.totoalpage = currentPage + 1;
    return (currentPage + 1)*collectWidth;
    
}

@end
