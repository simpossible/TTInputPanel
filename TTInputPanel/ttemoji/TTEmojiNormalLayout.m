//
//  TTEmojiNormalLayout.m
//  TTInputPanelDemo
//
//  Created by simp on 2018/10/17.
//  Copyright © 2018年 simp. All rights reserved.
//

#import "TTEmojiNormalLayout.h"
#import "TTInputNormlSouce.h"
#import "TTInputSourcePage.h"
#import "TTInputSourceItem.h"
#import "TTEmojiSourceItem.h"

@implementation TTEmojiNormalLayout

//- (CGFloat)widthForPage:(TTInputSourcePage *)page section:(NSInteger)section lastSectionWidth:(CGFloat)lastWidth{
//    if (page.itemCount == 0) {
//        return 0;
//    }
//
//    CGFloat collectWidth = self.collectionView.bounds.size.width;
//    CGFloat width = collectWidth - page.margin.left - page.margin.right;
//
//    CGFloat height = self.collectionView.bounds.size.height;
//    height = height - page.margin.top - page.margin.bottom;
//    //先计算一个page 需要装多少个 页面
//    NSInteger currentPage = 0;
//    CGFloat alreadyWidth = 0;
//    CGFloat alreadyHeight = 0;
//    NSInteger currentLine = 0;//行
//
//    NSInteger alreadyNumber = 0;//已经显示了的item 个数 用来限制每一页显示的最大个数
//
//    CGFloat caculateWidth = page.itemSize.width + page.itemMargin.left;
//    for (int i = 0; i < page.itemCount; i ++) {
//        alreadyNumber ++;
//        CGFloat nextWdith = alreadyWidth + caculateWidth;
//        if(nextWdith > width + 0.05) {//最后一个可以贴着section 右 这里的0.05为 float 误差
//            //应该换行了
//            alreadyHeight += page.itemBoxHeight;
//            currentLine += 1;
//            alreadyWidth = 0;
//
//            BOOL shouldToNextPage = NO;
//            if (alreadyNumber > self.numberItemOneceShow && self.numberItemOneceShow != 0) {
//                alreadyNumber = 1;
//                shouldToNextPage = YES;
//            }
//
//            if (alreadyHeight + page.itemBoxHeight + page.lineSpace > height || shouldToNextPage) {//该换页了
//                if (page.index == 0) {//第一个不要最后三个
//                    i -= 3;//最后三个要变成一个空格
//                }
//                currentPage += 1;
//                currentLine = 0;
//                alreadyHeight = 0;
//            }else {
//                alreadyHeight += page.lineSpace;
//            }
//
//        }else {
//        }
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
//
//        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//        attr.size = page.itemSize;
//
//        CGFloat centerX = 0;
//        if (alreadyWidth == 0) {//第一个不要考虑左边距
//            centerX =  lastWidth + alreadyWidth+page.itemSize.width/2 + currentPage * collectWidth + page.margin.left;
//        }else {
//            centerX =  lastWidth + alreadyWidth+page.itemSize.width/2 +page.itemMargin.left + currentPage * collectWidth + page.margin.left;
//        }
//        CGFloat centerY = alreadyHeight+page.itemSize.height/2 + page.margin.top + page.itemMargin.top;
//        attr.center = CGPointMake(centerX, centerY);
//
//        [self.cacheForItem setObject:attr forKey:@(i+1000*section)];
//
//        if (alreadyWidth == 0) {
//            alreadyWidth +=  page.itemMargin.right + page.itemSize.width;
//        }else {
//            alreadyWidth += page.itemBoxWidth;
//        }
//    }
//
//    page.totoalpage = currentPage + 1;
//    return (currentPage + 1)*collectWidth;
//
//}

- (CGFloat)widthForPage:(TTInputSourcePage *)page section:(NSInteger)section lastSectionWidth:(CGFloat)lastWidth{
    if (page.itemCount == 0) {
        return 0;
    }
    
    CGFloat collectWidth = self.layoutSize.width;
    CGFloat width = collectWidth - page.margin.left - page.margin.right;
    
    CGFloat height = self.layoutSize.height;
    height = height - page.margin.top - page.margin.bottom;
    //先计算一个page 需要装多少个 页面
    NSInteger currentPage = 0;
    CGFloat alreadyWidth = 0;
    CGFloat alreadyHeight = page.margin.top;
    NSInteger currentLine = 0;//行
    
    NSInteger alreadyNumber = 0;//已经显示了的item 个数 用来限制每一页显示的最大个数
    
    NSInteger numberItemPerRow = 0;
    
    CGFloat tempAlreadyHeight = 0;
    CGFloat tempAlreadyWidth = 0;
    
    CGFloat caculateWidth = page.itemSize.width + page.itemMargin.left;
    
    CGFloat lastRowHeight = 0;//记录上一行的高度
    
    for (int i = 0; ; i ++) {
        NSInteger count = page.useItemLayout?page.sourceItems.count:page.itemCount;
        if (i >= count ) {
            break;
        }
        TTInputSourceItem * item;
        if (page.useItemLayout) {
            item = [page.sourceItems objectAtIndex:i];
            caculateWidth = item.itemSize.width + item.margin.left;
        }
        CGFloat boxHeight = page.useItemLayout?item.boxHeight:page.itemBoxHeight;
        CGFloat boxWidth = page.useItemLayout?item.boxWidth:page.itemBoxWidth;
        alreadyNumber ++;
        
       

        
        CGFloat nextWdith = alreadyWidth + caculateWidth;
        if(nextWdith > width + 0.05) {//最后一个可以贴着section 右 这里的0.05为 float 误差
            //应该换行了
            if (numberItemPerRow == 0) {
                numberItemPerRow = alreadyNumber -1;
            }
           
            alreadyHeight += lastRowHeight;
            lastRowHeight = 0;
            
            currentLine += 1;
            alreadyWidth = 0;
            
            CGFloat nextHeight = page.useItemLayout?(item.itemSize.height + item.margin.top):(page.itemSize.height + page.itemMargin.top);
           
            if (alreadyHeight + nextHeight + page.lineSpace > height ) {//该换页了 - 允许最后一行
                BOOL shouldToNextPage = YES;
                if (shouldToNextPage) {
                    currentPage += 1;
                    currentLine = 0;
                    alreadyHeight = page.margin.top;
                }else{
                    continue;
                }
            }else {
                alreadyHeight += page.lineSpace;
            }
            
        }else {
        }
        
        CGFloat tempLastRowHeight;
        if (currentLine == 0) {
            tempLastRowHeight = page.useItemLayout?(item.itemSize.height+item.margin.bottom):(page.itemSize.height + page.itemMargin.bottom);
        }else {
            tempLastRowHeight = boxHeight;
        }
        
        lastRowHeight = (lastRowHeight > tempLastRowHeight)?lastRowHeight:tempLastRowHeight;
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attr.size = page.useItemLayout?item.itemSize:page.itemSize;
        
        CGFloat itemWidth = page.useItemLayout?item.itemSize.width:page.itemSize.width;
        CGFloat itemHeight = page.useItemLayout?item.itemSize.height:page.itemSize.height;
        UIEdgeInsets itemMargin = page.useItemLayout?item.margin:page.itemMargin;
        CGSize itemSize = page.useItemLayout?item.itemSize:page.itemSize;
        
        CGFloat centerX = 0;
        if (alreadyWidth == 0) {//第一个不要考虑左边距
            centerX =  lastWidth + alreadyWidth+ itemWidth/2 + currentPage * collectWidth + page.margin.left;
        }else {
            centerX =  lastWidth + alreadyWidth+ itemWidth/2 + itemMargin.left + currentPage * collectWidth + page.margin.left;
        }
        
        CGFloat centerY = 0;
        
        if (currentLine == 0) {//第一行 不要考虑上编剧
            centerY = alreadyHeight+ itemHeight/2 ;
        }else {
            centerY = alreadyHeight+ itemHeight/2 + itemMargin.top;
        }
        attr.center = CGPointMake(centerX, centerY);
        
        [self.cacheForItem setObject:attr forKey:@(i+1000*section)];
        
        if (alreadyWidth == 0) {
            alreadyWidth +=  itemMargin.right + itemSize.width;
        }else {
            alreadyWidth += boxWidth;
        }
        

        
        if (!page.isSizeCaculated && page.index == 0) {
            if (numberItemPerRow != 0) {
                NSInteger countPerPage =  3 * numberItemPerRow - 1;
                NSInteger index = i % countPerPage;
                if (index == (countPerPage - 3) && i != page.sourceItems.count-1) {
                    tempAlreadyHeight = alreadyHeight;
                    tempAlreadyWidth = alreadyWidth;
                    TTEmojiSourceItem *delete = [TTEmojiSourceItem deleteItem];//插入发送 和 删除
                    TTEmojiSourceItem * send = [TTEmojiSourceItem sendItem];
                    [page insertItem:delete atIndex:i+1];
                    [page insertItem:send atIndex:i+2];
                }
            }
            
            if (i == page.sourceItems.count-1) {
                TTEmojiSourceItem * eitem = (TTEmojiSourceItem *)item;
                if (eitem.type < TTEmojiItemTypeDelete) {//如果最后一个是 普通的
                    alreadyHeight = tempAlreadyHeight;
                    alreadyWidth = tempAlreadyWidth;
                    currentLine = 2;
                    TTEmojiSourceItem *delete = [TTEmojiSourceItem deleteItem];//插入发送 和 删除
                    TTEmojiSourceItem * send = [TTEmojiSourceItem sendItem];
                    [page appendItem:delete];
                    [page appendItem:send];
                }
            }
        }
    }
    
    page.totoalpage = currentPage + 1;
    page.isSizeCaculated = YES;
    page.useItemLayout?page.itemCount = page.sourceItems.count:nil;
    return (currentPage + 1)*collectWidth;
    
}

@end
