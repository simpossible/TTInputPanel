//
//  TTInputSourcePage.m
//  TTInputPanel
//
//  Created by simp on 2017/10/22.
//

#import "TTInputSourcePage.h"
#import "TTInputSourceItem.h"
#import "TTInputUtil.h"

@interface TTInputSourcePage()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * pageCollectionView;

@property (nonatomic, strong) NSArray<TTInputSourceItem *> *sourceItems;	

@end

@implementation TTInputSourcePage

- (instancetype)initFromDic:(NSDictionary *)dic {
    if(self = [super init]) {
        [self dealpageDic:dic];
    }
    return self;
}

- (void)dealpageDic:(NSDictionary *)dic {
  
 
    self.lineSpace = [[dic objectForKey:@"linespace"] floatValue];
    self.margin = [TTInputUtil marginFromDic:[dic objectForKey:TTInputMargin]];
    self.itemMargin = [TTInputUtil marginFromDic:[dic objectForKey:@"defaultitemmargin"]];
    self.itemSize = [TTInputUtil sizeFromDic:[dic objectForKey:@"defaultItemSize"]];
    
    NSArray *items = [dic objectForKey:@"items"];
    NSMutableArray *ttItems = [NSMutableArray array];
    
    for (NSDictionary *itemDic in items) {
        TTInputSourceItem *sItem = [[TTInputSourceItem alloc] initFromDic:itemDic];
        sItem.itemSize = self.itemSize;
        sItem.margin = self.itemMargin;
        [ttItems addObject:sItem];
    }
    self.sourceItems = ttItems;
    

}

- (CGFloat)itemBoxWidth {
    return _itemMargin.left + _itemMargin.right + _itemSize.width;
}

- (CGFloat)itemBoxHeight {
    return _itemMargin.top + _itemMargin.bottom + _itemSize.height;
}


- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if ([self.delegate respondsToSelector:@selector(pageSelectedChanged)]) {
        [self.delegate pageSelectedChanged];
    }
}


- (void)loadItems {
    if (!self.sourceItems) {
        NSMutableArray *arary = [NSMutableArray array];
        
        for (int i = 0; i < self.itemCount; i ++ ) {
            TTInputIndex index;
            index.page = self.index;
            index.row = i;
            TTInputSourceItem *item = [self.datasource itemForPageAtIndex:index atSource:self.source];
            [arary addObject:item];
        }
        
        self.sourceItems = arary;
        
    }
}

@end
