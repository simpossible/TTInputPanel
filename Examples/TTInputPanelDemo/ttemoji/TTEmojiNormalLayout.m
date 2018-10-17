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
    
    NSInteger numberItemPerRow = 0;
    
    CGFloat tempAlreadyHeight = 0;
    CGFloat tempAlreadyWidth = 0;
    
    for (int i = 0; i < page.sourceItems.count; i ++) {
        TTInputSourceItem * item = [page.sourceItems objectAtIndex:i];
        CGFloat caculateWidth = item.itemSize.width + item.margin.left;
        
        alreadyNumber ++;
        CGFloat nextWdith = alreadyWidth + caculateWidth;
        if(nextWdith > width + 0.05) {//最后一个可以贴着section 右 这里的0.05为 float 误差
            //应该换行了
            if (numberItemPerRow == 0) {
                numberItemPerRow = alreadyNumber -1;
            }
            alreadyHeight += item.boxHeight;
            currentLine += 1;
            CGFloat lastAlredyWidth = alreadyWidth;
            alreadyWidth = 0;
            
            if (alreadyHeight + item.boxHeight + page.lineSpace > height ) {//该换页了
                BOOL shouldToNextPage = YES;
//                if ([item isKindOfClass:[TTEmojiSourceItem class]]) {//如果是表情
//
//                    TTEmojiSourceItem * eitem = (TTEmojiSourceItem *)[page.sourceItems objectAtIndex:i -1];
//                    if (eitem.type < TTEmojiItemTypeDelete) {//如果不是删除 或者 发送那么回退 3个
//
//                        TTInputSourceItem *tempItem = [page.sourceItems objectAtIndex:i-1];
//                        lastAlredyWidth -= [tempItem boxWidth];
//                        tempItem = [page.sourceItems objectAtIndex:i-2];
//                        lastAlredyWidth -= [tempItem boxWidth];
//                        tempItem = [page.sourceItems objectAtIndex:i-3];
//                        lastAlredyWidth -= [tempItem boxWidth];//宽度回归
//                        alreadyWidth = lastAlredyWidth;
//                        [self.cacheForItem removeObjectForKey:@((i-1)+1000*section)];
//                        [self.cacheForItem removeObjectForKey:@((i-2)+1000*section)];
//                        [self.cacheForItem removeObjectForKey:@((i-3)+1000*section)];
//
//                         i -= 3;
//                        TTEmojiSourceItem *delete = [TTEmojiSourceItem deleteItem];//插入发送 和 删除
//                        TTEmojiSourceItem * send = [TTEmojiSourceItem sendItem];
//
//                        [page insertItem:delete atIndex:i];
//                        [page insertItem:send atIndex:i+1];
//                        alreadyNumber = 1;
//                        shouldToNextPage = NO;//插入了就不要进入下一页了
//                        i -= 1;//这里让计算
//                    }
//                }
                if (shouldToNextPage) {
                    currentPage += 1;
                    currentLine = 0;
                    alreadyHeight = 0;
                }else{
                    continue;
                }
            }else {
                alreadyHeight += page.lineSpace;
            }
            
        }else {
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attr.size = item.itemSize;
        
        CGFloat centerX = 0;
        if (alreadyWidth == 0) {//第一个不要考虑左边距
            centerX =  lastWidth + alreadyWidth+item.itemSize.width/2 + currentPage * collectWidth + page.margin.left;
        }else {
            centerX =  lastWidth + alreadyWidth+item.itemSize.width/2 +item.margin.left + currentPage * collectWidth + page.margin.left;
        }
        CGFloat centerY = alreadyHeight+item.itemSize.height/2 + page.margin.top + item.margin.top;
        attr.center = CGPointMake(centerX, centerY);
        
        [self.cacheForItem setObject:attr forKey:@(i+1000*section)];
        
        if (alreadyWidth == 0) {
            alreadyWidth +=  item.margin.right + item.itemSize.width;
        }else {
            alreadyWidth += item.boxWidth;
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
    return (currentPage + 1)*collectWidth;
    
}

@end
