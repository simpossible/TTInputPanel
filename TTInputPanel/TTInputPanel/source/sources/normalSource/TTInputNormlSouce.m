//
//  TTInputNormlSouce.m
//  TTInputPanel
//
//  Created by simp on 2017/10/18.
//

#import "TTInputNormlSouce.h"
#import "TTPageNormalLayout.h"
#import "TTInputNomalCell.h"

@interface TTInputNormlSouce ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIControl * barView;

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
        [super setFocusState:focusState];
        if ([self.delegate respondsToSelector:@selector(foucusChangedForSource:)]) {
            [self.delegate foucusChangedForSource:self];
        }
    }else {
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

#pragma mark - baritem
- (void)genrateBarView {
    self.barView = [[UIControl alloc] init];
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
    return page.sourceItems.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTInputNomalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"aaa" forIndexPath:indexPath];
    TTInputSourcePage *page = [self.pages objectAtIndex:indexPath.section];
    TTInputSourceItem *item = [page.sourceItems objectAtIndex:indexPath.row];
    cell.item = item;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTInputSourcePage *page = [self.pages objectAtIndex:indexPath.section];
    TTInputSourceItem *item = [page.sourceItems objectAtIndex:indexPath.row];
    return item.itemSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 30, 10, 40);
}


@end
