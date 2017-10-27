//
//  TTPageNormalLayout.m
//  TTInputPanel
//
//  Created by simp on 2017/10/26.
//

#import "TTPageNormalLayout.h"

@interface TTPageNormalLayout ()

@property (nonatomic, strong) TTInputNormlSouce * source;

@property (nonatomic, strong) NSMutableDictionary * cacheForItem;

@property (nonatomic, assign) CGSize contensize;
@end

@implementation TTPageNormalLayout

- (instancetype)initWithSource:(TTInputNormlSouce *)source {
    if(self = [super init]) {
        self.source = source;
        self.cacheForItem = [NSMutableDictionary dictionary];
    }
    return self;
}


- (void)prepareLayout {
    self.contensize =  [self caculateContentSizeForSource];
}

- (CGSize)collectionViewContentSize {
    return self.contensize;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [self.cacheForItem allValues];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [super layoutAttributesForItemAtIndexPath:indexPath];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"sdsd is %@",elementKind);
    return [super layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:indexPath];
}
//
- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"sdsd is +++ %@",elementKind);
    return  [super layoutAttributesForDecorationViewOfKind:elementKind atIndexPath:indexPath];

}

- (CGSize)caculateContentSizeForSource {
    CGFloat allWidth = 0;
    for (int i = 0 ; i < self.source.pages.count; i ++) {
        TTInputSourcePage *page = [self.source.pages objectAtIndex:i];
        CGFloat pageWidth = [self widthForPage:page section:i lastSectionWidth:allWidth];
        allWidth += pageWidth;
    }
    return CGSizeMake(allWidth, self.collectionView.bounds.size.height);
}

- (CGFloat)widthForPage:(TTInputSourcePage *)page section:(NSInteger)section lastSectionWidth:(CGFloat)lastWidth{
    
    
    CGFloat collectWidth = self.collectionView.bounds.size.width;
    CGFloat width = collectWidth - page.margin.left - page.margin.right;
    
    CGFloat height = self.collectionView.bounds.size.height;
    height = height - page.margin.top - page.margin.bottom;
    //先计算一个page 需要装多少个 页面
    NSInteger currentPage = 0;
    CGFloat alreadyWidth = 0;
    CGFloat alreadyHeight = 0;
    NSInteger currentLine = 0;
    for (int i = 0; i < page.sourceItems.count; i ++) {
        TTInputSourceItem *item = [page.sourceItems objectAtIndex:i];
        if(alreadyWidth + item.boxWidth > width) {
            //应该换行了
            alreadyHeight += item.boxHeight;
            currentLine += 1;
            alreadyWidth = 0;
            if (alreadyHeight + item.boxHeight + page.lineSpace > height) {//该换页了
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
        attr.size = item.itemSize;
        attr.center = CGPointMake(lastWidth + alreadyWidth+item.itemSize.width/2 +item.margin.left + currentPage * collectWidth + page.margin.left, alreadyHeight+item.itemSize.height/2 + page.margin.top);
       
        NSLog(@"attr:\n%@",attr.description);
        [self.cacheForItem setObject:attr forKey:@(i+1000*section)];
        
        alreadyWidth += item.boxWidth;
        
    }
    
    return (currentPage + 1)*collectWidth;
}


@end
