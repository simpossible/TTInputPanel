//
//  TTInputSourcePage.m
//  TTInputPanel
//
//  Created by simp on 2017/10/22.
//

#import "TTInputSourcePage.h"
#import "TTInputSourceItem.h"

@interface TTInputSourcePage()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * pageCollectionView;

@end

@implementation TTInputSourcePage

- (instancetype)initFromDic:(NSDictionary *)dic {
    if(self = [super init]) {
        [self dealpageDic:dic];
    }
    return self;
}

- (void)dealpageDic:(NSDictionary *)dic {
    NSArray *items = [dic objectForKey:@"items"];

    NSMutableArray *ttItems = [NSMutableArray array];
    for (NSDictionary *itemDic in items) {
        TTInputSourceItem *sItem = [[TTInputSourceItem alloc] initFromDic:itemDic];
        [ttItems addObject:sItem];
    }
    self.sourceItems = ttItems;
    [self generateView];
}

- (void)generateView {
    self.pageView = [[UIView alloc] init];
    [self initialPageCollection];
    
}

- (void)initialPageCollection {
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.pageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    [self.pageView addSubview:self.pageCollectionView];
    
    [self.pageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    
    self.pageCollectionView.delegate = self;
    self.pageCollectionView.dataSource = self;
    [self.pageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"aaa"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sourceItems.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"aaa" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}
@end
