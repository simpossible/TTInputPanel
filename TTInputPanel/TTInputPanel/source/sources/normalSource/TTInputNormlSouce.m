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

@interface TTInputNormlSouce ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) TTInputNormalBarItem * barView;

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
    [super dealSourceDic:dic];
    self.foucesHeight = [[dic objectForKey:@"focusheight"] integerValue];
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
    TTPageNormalLayout *flow = [[TTPageNormalLayout alloc] initWithSource:self];
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    collection.pagingEnabled = YES;
    self.sourceView = collection;
    self.sourceView.backgroundColor = [UIColor colorWithRed:246/255.0f green:246/255.0f blue:246/255.0f alpha:1];
    collection.delegate = self;
    collection.dataSource = self;
    [collection registerClass:[TTInputNomalCell class] forCellWithReuseIdentifier:@"aaa"];

}

#pragma mark - datasource

- (void)setDatasouce:(id<TTInputProtocol>)datasouce {
    [super setDatasouce:datasouce];
    if([self.datasouce respondsToSelector:@selector(focusImageForSourcceBarItem:)]) {
        UIImage *img = [self.datasouce focusImageForSourcceBarItem:self];
        self.barView.focusImage = img;
    }
    
    if([self.datasouce respondsToSelector:@selector(unFocusImageForSourceBarItem:)]) {
        UIImage *unImage = [self.datasouce unFocusImageForSourceBarItem:self];
        self.barView.unfocusImage = unImage;
    }
    self.barView.state = self.focusState;
}

#pragma mark - baritem
- (void)genrateBarView {
    self.barView = [[TTInputNormalBarItem alloc] init];
    self.barView.backgroundColor = [UIColor yellowColor];
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

@end
