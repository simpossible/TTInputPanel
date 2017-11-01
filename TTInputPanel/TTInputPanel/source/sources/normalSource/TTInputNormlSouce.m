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

@interface TTInputNormlSouce ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) TTInputNormalBarItem * barView;

@property (nonatomic, strong) TTInputMenu * menu;

/**自己的menuitem*/
@property (nonatomic, strong) TTinputMenuItem * menuItem;

@property (nonatomic, strong) UICollectionView * contentView;

@property (nonatomic, weak) TTInputSourcePage * currentPage;


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
        
        if ([self.delegate respondsToSelector:@selector(source:willChangeStateTo:)]) {//判断消失逻辑
            [self.delegate source:self willChangeStateTo:focusState];
        }
        
        [super setFocusState:focusState];
        if (focusState == TTIInputSoureFocusStateFoucus) {//这里是由不是焦点变为了焦点 则到指定高度
            if ([self.delegate respondsToSelector:@selector(toChangeSourceHeight:time:animateOption:)]) {//直接进行动画
                [self.delegate toChangeSourceHeight:self.foucesHeight time:0.5 animateOption:0];
            }
        }
        
        self.barView.state = focusState;//改变显示状态
    }
    
}

- (void)disappearSource {
    if ([self.delegate respondsToSelector:@selector(toChangeSourceHeight:time:animateOption:)]) {//直接进行动画
        [self.delegate toChangeSourceHeight:0 time:0.5 animateOption:0];
    }
}

- (void)generateView {
    UIView *containView = [[UIView alloc] init];
    self.sourceView = containView;
    containView.backgroundColor = [UIColor colorWithRed:246/255.0f green:246/255.0f blue:246/255.0f alpha:1];
    
    
    TTPageNormalLayout *flow = [[TTPageNormalLayout alloc] initWithSource:self];
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    collection.pagingEnabled = YES;
    collection.delegate = self;
    collection.dataSource = self;
    [collection registerClass:[TTInputNomalCell class] forCellWithReuseIdentifier:@"aaa"];
    self.contentView = collection;
    collection.backgroundColor = [UIColor colorWithRed:246/255.0f green:246/255.0f blue:246/255.0f alpha:1];
    
    [containView addSubview:collection];
    
    [collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];

}

#pragma mark - datasource

- (void)setDatasouce:(id<TTInputProtocol>)datasouce {
    [super setDatasouce:datasouce];
    
    [self initialPageFromdataSourceForSource];
    
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
    
    [self.contentView reloadData];
}

/**初始化pages*/
- (void)initialPageFromdataSourceForSource {
    NSInteger numberOfPage = 0;
    if ([self.datasouce respondsToSelector:@selector(numberOfPageForSource:)]) {
        numberOfPage = [self.datasouce numberOfPageForSource:self];
        for (int i = 0 ; i < numberOfPage; i ++) {
            TTInputSourcePage *page = [[TTInputSourcePage alloc] init];
            
            if ([self.datasouce respondsToSelector:@selector(marginForPageIndex:atSource:)]) {
                page.margin = [self.datasouce marginForPageIndex:i atSource:self];
            }
            
            if ([self.datasouce respondsToSelector:@selector(itemSizeForPageAtIndex:atSource:)]) {
                page.itemSize = [self.datasouce itemSizeForPageAtIndex:i atSource:self];
            }
            
            if ([self.datasouce respondsToSelector:@selector(itemMarginForPageIndex:atSource:)]) {
                page.itemMargin = [self.datasouce itemMarginForPageIndex:i atSource:self];
            }
            
            if ([self.datasouce respondsToSelector:@selector(itemNumerInPageIndex:atSource:)]) {
                page.itemCount = [self.datasouce itemNumerInPageIndex:i atSource:self];
            }
            
            if ([self.datasouce respondsToSelector:@selector(pageIconForMenu:atIndex:)]) {
                page.pageIcon = [self.datasouce pageIconForMenu:self atIndex:i];
            }
            
            [self addPage:page];
        }
    }
    
    if (self.pages.count > 0) {
        self.currentPage = [self.pages objectAtIndex:0];
        self.currentPage.selected = YES;
    }
    
}

- (void)generateMenu {
    
    TTInputNormalMenuItem * item  = [[TTInputNormalMenuItem alloc] initWithWidth:100 flex:TTInputLayoutFlexGreater content:nil];
    item.source = self;

    
    NSArray *currentItem = @[item];

    if ([self.datasouce respondsToSelector:@selector(itemsForMenuForSource:withExsitItems:)]) {
        NSArray *dataItems = [self.datasouce itemsForMenuForSource:self withExsitItems:currentItem];
        currentItem = dataItems;
    }
    
    self.menu = [[TTInputMenu alloc] initWithItems:currentItem];
    self.menu.backgroundColor = [UIColor yellowColor];

    [self.sourceView addSubview:self.menu];
    
    [self.menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sourceView.mas_bottom);
        make.left.equalTo(self.sourceView.mas_left);
        make.right.equalTo(self.sourceView.mas_right);
        make.height.mas_equalTo(37);
    }];
        
}



#pragma mark - baritem
- (void)genrateBarView {
    self.barView = [[TTInputNormalBarItem alloc] init];

    [self.barView addTarget:self action:@selector(barItemClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)barItemClicked:(UIControl *)sender {
    if (self.focusState == TTIInputSoureFocusStateNone) {
        self.focusState = TTIInputSoureFocusStateFoucus;
    }else {
        self.focusState = TTIInputSoureFocusStateNone;
    }
}


#pragma mark - sources
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.pages.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    TTInputSourcePage *page = [self.pages objectAtIndex:section];
    return page.itemCount;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTInputNomalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"aaa" forIndexPath:indexPath];
//    TTInputSourcePage *page = [self.pages objectAtIndex:indexPath.section];
    if ([self.datasouce respondsToSelector:@selector(itemForPageAtIndex:atSource:)]) {
        TTInputIndex index;
        index.page = indexPath.section;
        index.row = indexPath.row;
        
        TTInputSourceItem *item = [self.datasouce itemForPageAtIndex:index atSource:self];
        cell.item = item;
        return cell;
    }else {
        return nil;
    }
   
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTInputSourcePage *page = [self.pages objectAtIndex:indexPath.section];
    TTInputSourceItem *item = [page.sourceItems objectAtIndex:indexPath.row];
    return item.itemSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 30, 10, 40);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.datasouce respondsToSelector:@selector(itemSelected:atIndex:forsource:)]) {
        TTInputIndex i = indexForPage(indexPath.section, indexPath.row);
        TTInputNomalCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        [self.datasouce itemSelected:cell.item atIndex:i forsource:self];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    TTInputSourcePage *page = [self.pages objectAtIndex:indexPath.section];
    if (page != self.currentPage) {
        page.selected = YES;
        self.currentPage.selected = NO;
        self.currentPage = page;
    }
}

#pragma mark - util

- (void)addPage:(TTInputSourcePage *)page {
    if (!self.pages) {
        self.pages = [NSMutableArray array];
    }
    [(NSMutableArray *)self.pages addObject:page];
}
@end
