//
//  TTInputSourceItem.m
//  TTInputPanel
//
//  Created by simp on 2017/10/22.
//

#import "TTInputSourceItem.h"

@interface TTInputSourceItem()
@property (nonatomic, copy) NSString * itemImgName;

@property (nonatomic, assign) NSInteger tag;

@end


@implementation TTInputSourceItem

- (instancetype)initFromDic:(NSDictionary *)dic {
    if (self = [super init]) {
         [self dealpageDic:dic];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        _identifier = @"TTInputNomalCell";
    }
    return self;
}

- (void)dealpageDic:(NSDictionary *)dic {
//    self.itemImgName = [dic objectForKey:@"itemimg"];
//    self.tag = [[dic objectForKey:@"tag"] integerValue];
//    
//    NSString *path = [[NSBundle mainBundle] pathForResource:TTInputBundle ofType:@"bundle"];
//    if(path){
//        NSString *imgpath = [NSString stringWithFormat:@"%@/%@",path,self.itemImgName];
//        self.itemImg = [UIImage imageNamed:imgpath];
//    }
}

- (void)loadItemImage {
    
}


- (CGFloat)boxWidth {
    return _margin.left + _margin.right + _itemSize.width;
}

- (CGFloat)boxHeight {
    return _margin.top + _margin.bottom + _itemSize.height;
}

- (NSString *)description {
    return self.identifier;
}
@end
