//
//  TTInputNormlSouce.m
//  TTInputPanel
//
//  Created by simp on 2017/10/18.
//

#import "TTInputNormlSouce.h"
#import "TTPageNormalLayout.h"
#import "TTInputNomalCell.h"
#import "TTInputNormalBarItem.h"
#import "TTInputMenu.h"
#import "TTInputNormalMenuItem.h"
#import "TTInputNormalView.h"
#import "TTInputSourcePage.h"
#import <Masonry/Masonry.h>
#import "UIColor+Extension.h"
#import "TTInputPageControl.h"

@interface TTInputNormlSouce ()<UICollectionViewDelegate,UICollectionViewDataSource,TTinputMenuItemProtocol>

@property (nonatomic, strong) TTInputNormalBarItem * barView;

@property (nonatomic, strong) TTInputMenu * menu;

/**自己的menuitem*/
@property (nonatomic, strong) TTinputMenuItem * menuItem;

@property (nonatomic, strong) UICollectionView * contentView;

@property (nonatomic, weak) TTInputSourcePage * currentPage;

@property (nonatomic, strong) TTInputPageControl * pageControl;

@property (nonatomic, assign) BOOL animateLock;

@property (nonatomic, strong) TTPageNormalLayout * layout;

@end


@implementation TTInputNormlSouce

@synthesize barView = _barView;

- (instancetype)initWithSource:(NSDictionary *)dic {
    if (self = [super initWithSource:dic]) {
        _sourceType = TTINPUTSOURCETYPENORMAL;
        self.focusState = TTIInputSoureFocusStateNone;
    }
    return self;
}


- (void)dealSourceDic:(NSDictionary *)dic {
    
    NSArray *pages = [dic objectForKey:@"pages"];
    NSMutableArray *ttpages = [NSMutableArray array];
    for (NSDictionary *pagedic in pages) {
        TTInputSourcePage *page = [[TTInputSourcePage alloc] initFromDic:pagedic];
        [ttpages addObject:page];
    }
    self.pages = ttpages;
    self.foucesHeight = [[dic objectForKey:@"focusheight"] integerValue];
    
    [super dealSourceDic:dic];
 
}

#pragma mark - 焦点事件
- (void)setFocusState:(TTIInputSoureFocusState)focusState {

 
    if (focusState != _focusState) {
        
//        if ([self.delegate respondsToSelector:@selector(source:willChangeStateTo:)]) {//判断消失逻辑
//            [self.delegate source:self willChangeStateTo:focusState];
//        }        
        [super setFocusState:focusState];
        if (focusState == TTIInputSoureFocusStateFoucus) {//这里是由不是焦点变为了焦点 则到指定高度
            self.sourceView.hidden = NO;
            if ([self.delegate respondsToSelector:@selector(toChangeSourceHeight:time:animateOption:)]) {//直接进行动画
                [self.delegate toChangeSourceHeight:self.foucesHeight time:0.3 animateOption:0];
            }
        }
        
        self.barView.state = focusState;//改变显示状态
    }
    
    self.pageControl.hidden = (focusState == TTIInputSoureFocusStateNone);
}

- (void)disappearSource {
    if ([self.delegate respondsToSelector:@selector(toChangeSourceHeight:time:animateOption:)]) {//直接进行动画
        [self.delegate toChangeSourceHeight:0 time:0.3 animateOption:0];
    }
    self.focusState = TTIInputSoureFocusStateNone;    
}

- (void)generateView {
    TTInputNormalView *containView = [[TTInputNormalView alloc] init];
    self.sourceView = containView;
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.foucesHeight);
    }];
    
    containView.backgroundColor = [UIColor ARGB:0xF8F8F8];
    
    [self initialCollctionView];
//    [containView setDrawCallBack:^{
//        [self initialCollctionView];
//    }];
    

}

- (void)initialCollctionView {
   
    if (self.contentView) {
        return;
    }
    TTPageNormalLayout *flow = [[TTPageNormalLayout alloc] initWithSource:self];
    if ([self.datasouce respondsToSelector:@selector(normalLayouForSource:)]) {
        TTPageNormalLayout *nflow = [self.datasouce normalLayouForSource:self];
        if (nflow) {
            flow = nflow;
        }
    }
    self.layout = flow;
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    collection.pagingEnabled = YES;
    
    [collection registerClass:[TTInputNomalCell class] forCellWithReuseIdentifier:@"TTInputNomalCell"];
    self.contentView = collection;
    collection.backgroundColor = [UIColor ARGB:0xF8F8F8];
    
    if ([self.datasouce respondsToSelector:@selector(normalCellIdentifiersForSource:)]) {
        NSArray *otherCells = [self.datasouce normalCellIdentifiersForSource:self];
        for (NSString *classStr in otherCells) {
            Class cls = NSClassFromString(classStr);
            [collection registerClass:cls forCellWithReuseIdentifier:classStr];
        }
    }
    if ([self.contentView respondsToSelector:@selector(setPrefetchingEnabled:)]) {
        self.contentView.prefetchingEnabled = false;
    }
    
    [self.sourceView insertSubview:collection atIndex:0];
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    [collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sourceView.mas_left);
        make.top.equalTo(self.sourceView.mas_top);
        make.height.mas_equalTo(self.foucesHeight);
        make.width.mas_equalTo(width);
    }];
    

    flow.layoutSize = CGSizeMake(width, self.foucesHeight);
    [flow caculateContentSizeForSource];
    collection.delegate = self;
    collection.dataSource = self;
    
    [collection layoutIfNeeded];


}

- (void)initialpageControl {
    self.pageControl = [[TTInputPageControl alloc] init];
    [self.sourceView addSubview:self.pageControl];
    
    /**先写死 下次再配置*/
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.sourceView.mas_centerX);
        if (self.menu) {
            make.bottom.equalTo(self.menu.mas_top);
        }else {
            make.bottom.equalTo(self.sourceView.mas_bottom);
        }
        make.height.mas_equalTo(20);
        make.width.equalTo(self.sourceView.mas_width);
    }];
    
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:0.1];
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.pageControl.numberOfPages = self.currentPage.totoalpage;
    self.pageControl.defersCurrentPageDisplay = YES;
    
    [self.pageControl addTarget:self action:@selector(clickPageController:event:) forControlEvents:UIControlEventTouchDown];
    
}



- (void)clickPageController:(UIPageControl *)pageController event:(UIEvent *)touchs{
    UITouch *touch = [[touchs allTouches] anyObject];
    CGPoint p = [touch locationInView:_pageControl];
    
    UIView *view = [self viewForLocation:p];
    NSInteger page = view.tag;

    if (page < self.currentPage.totoalpage) {
        self.pageControl.currentPage = page;
        NSInteger allPage = self.currentPage.startPage + page;
        CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
        [self.contentView setContentOffset:CGPointMake(width * allPage, 0) animated:NO];
    }
}

- (UIView *)viewForLocation:(CGPoint)location {
    for (int i = 0; i < self.pageControl.subviews.count; i ++) {
        UIView *view = [self.pageControl.subviews objectAtIndex:i];
        if (location.x > view.frame.origin.x - 4 && location.x <= view.frame.origin.x + view.frame.size.width + 4) {
            view.tag = i;
            return view;
        }
    }
  
    return nil;
}

#pragma mark - datasource


- (void)initialData {
    self.pages = [self initialPageFromdataSourceForSource];
    if (self.pages.count > 0) {
        self.currentPage = [self.pages objectAtIndex:0];
        self.currentPage.selected = YES;
    }
}

- (void)initialUI {
    [super initialUI];
    if([self.datasouce respondsToSelector:@selector(focusImageForSourcceBarItem:)]) {
        UIImage *img = [self.datasouce focusImageForSourcceBarItem:self];
        self.barView.focusImage = img;
    }
    
    if([self.datasouce respondsToSelector:@selector(unFocusImageForSourceBarItem:)]) {
        UIImage *unImage = [self.datasouce unFocusImageForSourceBarItem:self];
        self.barView.unfocusImage = unImage;
    }
    self.barView.state = self.focusState;
    
    BOOL canShowMenu = NO;
    
    if ([self.datasouce respondsToSelector:@selector(shouldShowMenuForSource:)]) {
        canShowMenu = [self.datasouce shouldShowMenuForSource:self];
    }
    
    if (canShowMenu) {//如果需要显示menu
        [self generateMenu];
    }
        
    [self initialpageControl];
}

/**初始化pages*/
- (NSMutableArray *)initialPageFromdataSourceForSource {
    NSMutableArray * pages = [NSMutableArray array];;
    NSInteger numberOfPage = 0;
    if ([self.datasouce respondsToSelector:@selector(numberOfPageForSource:)]) {
        numberOfPage = [self.datasouce numberOfPageForSource:self];
        for (int i = 0 ; i < numberOfPage; i ++) {
            
            TTInputSourcePage *page;
            
            if ([self.datasouce respondsToSelector:@selector(inputNormalPageForSource:atIndex:)]) {
                page = [self.datasouce inputNormalPageForSource:self atIndex:i];
            }
            if (page == nil) {
                page = [[TTInputSourcePage alloc] init];
                if ([self.datasouce respondsToSelector:@selector(marginForPageIndex:atSource:)]) {
                    page.margin = [self.datasouce marginForPageIndex:i atSource:self];
                }
                
                //            if ([self.datasouce respondsToSelector:@selector(itemSizeForPageAtIndex:atSource:)]) {
                //                page.itemSize = [self.datasouce itemSizeForPageAtIndex:i atSource:self];
                //            }
                
                //            if ([self.datasouce respondsToSelector:@selector(itemMarginForPageIndex:atSource:)]) {
                //                page.itemMargin = [self.datasouce itemMarginForPageIndex:i atSource:self];
                //            }
                
                if ([self.datasouce respondsToSelector:@selector(itemNumerInPageIndex:atSource:)]) {
                    page.itemCount = [self.datasouce itemNumerInPageIndex:i atSource:self];
                }
                
                if ([self.datasouce respondsToSelector:@selector(pageIconForMenu:atIndex:)]) {
                    page.pageIcon = [self.datasouce pageIconForMenu:self atIndex:i];
                }
                
                if ([self.datasouce respondsToSelector:@selector(pageIconSizeForMenu:atIndex:)]) {
                    page.iconSize = [self.datasouce pageIconSizeForMenu:self atIndex:i];
                }
            }
            
            
            page.source = self;
            page.datasource = self.datasouce;
            page.index = i;
            [page loadItems];
            [pages addObject:page];
//            [self addPage:page];
        }
    }
    
    return pages;         
}

- (void)reloadPages {
    
    NSMutableArray *array =  [self initialPageFromdataSourceForSource];
    [self.menu reloadInputViews];
    self.pages = array;
    [self.layout clearAll];
    [self.layout caculateContentSizeForSource];
    [self.contentView reloadData];
    
    [self.menuItem reload];
}

- (void)generateMenu {
    
    TTInputNormalMenuItem * item  = [[TTInputNormalMenuItem alloc] initWithWidth:100 flex:TTInputLayoutFlexGreater content:nil];
    item.source = self;
    item.delegate = self;
    self.menuItem = item;
    
    NSArray *currentItem = @[item];

    if ([self.datasouce respondsToSelector:@selector(itemsForMenuForSource:withExsitItems:)]) {
        NSArray *dataItems = [self.datasouce itemsForMenuForSource:self withExsitItems:currentItem];
        currentItem = dataItems;
    }
    
    self.menu = [[TTInputMenu alloc] initWithItems:currentItem];

    [self.sourceView addSubview:self.menu];
    
    CGFloat height = 37;
    if ([self.datasouce respondsToSelector:@selector(ttinputNormalSourceMenuHeight)]) {
        height = [self.datasouce ttinputNormalSourceMenuHeight];
    }
    
    [self.menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sourceView.mas_bottom);
        make.left.equalTo(self.sourceView.mas_left);
        make.right.equalTo(self.sourceView.mas_right);
        make.height.mas_equalTo(height);
    }];
        
}



#pragma mark - baritem
- (void)genrateBarView {
    self.barView = [[TTInputNormalBarItem alloc] init];

    [self.barView addTarget:self action:@selector(barItemClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)barItemClicked:(UIControl *)sender {
    BOOL canBeFocus = NO;
    TTIInputSoureFocusState state = (self.focusState + 1)%2;
    if ([self.delegate respondsToSelector:@selector(source:canChangeStateTo:)]) {
        canBeFocus = [self.delegate source:self canChangeStateTo:state];
        if (canBeFocus) {
            if (self.focusState != state) {
                self.focusState = state;
            }
        }
    } 
}


#pragma mark - sources
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSInteger count = self.pages.count;
    return count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    TTInputSourcePage *page = [self.pages objectAtIndex:section];
    NSLog(@"the page.itemcount is %ld",page.itemCount);
    return page.itemCount;
   
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    TTInputSourcePage *page = [self.pages objectAtIndex:indexPath.section];
//    TTInputIndex index;
//    index.page = indexPath.section;
//    index.row = indexPath.row;
    TTInputSourceItem *item = [page itemAtIndex:indexPath.row];
     TTInputNomalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item.identifier forIndexPath:indexPath];
    cell.item = item;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTInputSourcePage *page = [self.pages objectAtIndex:indexPath.section];
    TTInputSourceItem *item = [page.sourceItems objectAtIndex:indexPath.row];
    return item.itemSize;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.datasouce respondsToSelector:@selector(itemSelected:atIndex:forsource:)]) {
        TTInputIndex i = indexForPage(indexPath.section, indexPath.row);
        TTInputNomalCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        [self.datasouce itemSelected:cell.item atIndex:i forsource:self];
    }
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) {
    if (!self.animateLock) {
        TTInputSourcePage *page = [self.pages objectAtIndex:indexPath.section];
        if (page != self.currentPage) {
            page.selected = YES;
            self.currentPage.selected = NO;
            self.currentPage = page;
        }
    }
}




- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    TTInputNomalCell *inputCell = (TTInputNomalCell *)cell;
    [inputCell diddisAppear];
}

/**计算当前滚动到第几页了*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.animateLock) {
        CGFloat width = CGRectGetWidth(scrollView.bounds);
        CGFloat offset = scrollView.contentOffset.x + 2;//允许有2个像素的误差。这样更准确
        NSInteger page = offset/width;       
        if (page > self.currentPage.startPage && page <= self.currentPage.startPage + self.currentPage.totoalpage) {
            self.pageControl.currentPage = (page - self.currentPage.startPage);
        }else {
            self.pageControl.currentPage = 0;
        }
        
    }
}

- (void)caculateCurrentPage:(UIScrollView *)scrollView {
    CGFloat width = CGRectGetWidth(scrollView.bounds);
    CGFloat offset = scrollView.contentOffset.x + 2;//允许有2个像素的误差。这样更准确
    NSInteger page = offset/width;
    TTInputSourcePage *tpage = [self pageAtPageOff:page];
    self.currentPage = tpage;
  
}

- (TTInputSourcePage *)pageAtPageOff:(NSInteger)page {
    for (int i = 0; i < self.pages.count; i ++) {
        TTInputSourcePage *tpage = [self.pages objectAtIndex:i];
        if (page >= tpage.startPage && page < tpage.startPage + tpage.totoalpage) {
            return tpage;
        }
    }
    return nil;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
//    self.currentPage = self.currentPage;
    [self caculateCurrentPage:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    self.currentPage = self.currentPage;
    [self caculateCurrentPage:scrollView];
}

- (void)setCurrentPage:(TTInputSourcePage *)currentPage {
    if (currentPage != _currentPage) {
        _currentPage.selected = NO;
    }
    currentPage.selected= YES;
    _currentPage = currentPage;
    self.pageControl.numberOfPages = currentPage.totoalpage;
    if (currentPage.totoalpage <= 1) {
        self.pageControl.hidden = YES;
    }else {
        self.pageControl.hidden = NO;
    }
}

- (void)pageCaculated {
    NSArray *pages = self.pages;
    self.pages = nil;
    NSInteger pagenumber = 0;
    for (TTInputSourcePage *page in pages) {
        [self addPage:page];
        pagenumber += page.totoalpage;
    }
    
    if (pagenumber == 1) {
        self.pageControl.hidden = YES;
    }else {
        self.pageControl.hidden = NO;
    }
    self.currentPage = self.currentPage;
}

#pragma mark - util

- (void)addPage:(TTInputSourcePage *)page {
    if (!self.pages) {
        self.pages = [NSMutableArray array];
    }      
    page.datasource = self.datasouce;
    TTInputSourcePage *lastpage = [self.pages lastObject];
    page.startPage = lastpage.startPage + lastpage.totoalpage;
    [(NSMutableArray *)self.pages addObject:page];
}

#pragma mark - menu 菜单栏

- (void)menuItemPageIconClicked:(TTInputSourcePage *)page {
    if (self.currentPage != page) {
        self.currentPage.selected = NO;
        self.currentPage = page;
        page.selected = YES;
        
        CGFloat width = CGRectGetWidth(self.contentView.bounds);
        CGFloat off = width * page.startPage;
//        self.animateLock = YES;
//        [UIView animateWithDuration:0.3 animations:^{
//            self.contentView.contentOffset = CGPointMake(off, 0);
////                   [self.contentView setContentOffset:CGPointMake(off, 0) animated:YES];
//        } completion:^(BOOL finished) {
//            self.animateLock = NO;
//        }];
        [self.contentView setContentOffset:CGPointMake(off, 0) animated:NO];
        self.pageControl.currentPage = 0;
    }
}

- (void)reloadPage:(TTInputSourcePage *)page {
//    page.isSizeCaculated = NO;
    [self reloadPages];
    
//    [self.layout caculateContentSizeForSource];
}
@end
