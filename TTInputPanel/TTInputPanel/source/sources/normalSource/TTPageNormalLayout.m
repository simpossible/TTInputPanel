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
    [self.source pageCaculated];
    return CGSizeMake(allWidth, self.collectionView.bounds.size.height);
}

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
    
    CGFloat caculateWidth = [self roundFloat:(page.itemSize.width + page.itemMargin.left)];
    for (int i = 0; i < page.itemCount; i ++) {
        CGFloat nextWdith = alreadyWidth + caculateWidth;
        if(nextWdith > width + 0.05) {//最后一个可以贴着section 右 这里的0.05为 float 误差
            //应该换行了
            alreadyHeight += page.itemBoxHeight;
            currentLine += 1;
            alreadyWidth = 0;
            if (alreadyHeight + page.itemBoxHeight + page.lineSpace > height) {//该换页了
                _numberItemOneceShow = i;
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

- (CGFloat)roundFloat:(CGFloat)sp {
    sp=( (float)( (int)( (sp+0.005)*100 ) ) )/100;
    return sp;
}


@end
