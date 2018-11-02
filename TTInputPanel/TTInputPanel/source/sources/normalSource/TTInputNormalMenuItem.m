//
//  TTInputNormalMenuItem.m
//  TTInputPanel
//
//  Created by simp on 2017/11/1.
//

#import "TTInputNormalMenuItem.h"
#import "TTInputNormalPageCell.h"
#import "TTInputSourcePage.h"
#import <Masonry/Masonry.h>
#import "UIColor+Extension.h"

@interface TTInputNormalMenuItem()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * contentView;

@end

@implementation TTInputNormalMenuItem

@synthesize contentView = _contentView;

- (instancetype)initWithWidth:(CGFloat)width flex:(TTInputLayoutFlex)flex content:(UIView *)contentView {
    if (self = [super initWithWidth:width flex:flex content:contentView]) {
        
    }
    return self;
}

- (void)initialContentView {
    

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [collection registerClass:[TTInputNormalPageCell class] forCellWithReuseIdentifier:@"TTPage"];
    collection.dataSource = self;
    collection.delegate = self;
    collection.backgroundColor = [UIColor ARGB:0xF5F5F5];
    collection.scrollIndicatorInsets = UIEdgeInsetsZero;
    _contentView = collection;
    
    [self addSubview:_contentView];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.source.pages.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTInputSourcePage *page = [self.source.pages objectAtIndex:indexPath.row];
    TTInputNormalPageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TTPage" forIndexPath:indexPath];
    cell.page = page;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTInputSourcePage *page = [self.source.pages objectAtIndex:indexPath.row];
    return page.iconSize;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TTInputSourcePage *page = [self.source.pages objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(menuItemPageIconClicked:)]) {
        [self.delegate menuItemPageIconClicked:page];
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.contentView.contentSize.width < self.bounds.size.width) {
        self.contentView.contentSize = CGSizeMake(self.bounds.size.width, self.contentView.contentSize.height);
    }
}

- (void)reload {
    [self.contentView reloadData];
}
@end
