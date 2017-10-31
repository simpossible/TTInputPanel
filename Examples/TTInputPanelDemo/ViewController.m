//
//  ViewController.m
//  TTInputPanelDemo
//
//  Created by simp on 2017/9/20.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "ViewController.h"
#import <TTInput.h>
#import <Masonry.h>
#import <TTInputSource.h>

@interface ViewController ()<UIScrollViewDelegate,TTInputProtocol>

@property (nonatomic, strong) UITableView * chatTableView;

@property (nonatomic, strong) TTInput *input;

@property (nonatomic, strong) NSMutableArray * emojs;

@end

@implementation ViewController

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialData];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"input" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    if (data) {
//        TTInput *input = [TTInput inputFromJsonData:data];
        TTInput *input = [[TTInput alloc] initWithDataSource:self];
        self.input = input;
//        TTInputPanel *panel = [[TTInputPanel alloc] initWithInput:input];
        [self.view addSubview:input];
        
        [input mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }
    
    [self initialUI];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initialUI {
    self.chatTableView = [[UITableView alloc] init];
    [self.view insertSubview:self.chatTableView atIndex:0];
    [self.chatTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.input.mas_top);
    }];
    
    self.chatTableView.delegate = self;
    self.chatTableView.backgroundColor = [UIColor orangeColor];
}

- (void)initialData {
    [self initialEmoj];
}


- (void)initialEmoj {
    
    self.emojs = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:TTInputBundle ofType:@"bundle"];
    NSString *emojname = @"Expression";
    for (int i = 0 ; i < 100; i ++) {
        NSString *currentName = [NSString stringWithFormat:@"%@/%@_%d@2x.png",path,emojname,i];
        UIImage *imge = [UIImage imageNamed:currentName];
        if (imge) {
            TTInputSourceItem *item = [[TTInputSourceItem alloc] init];
            item.itemImg = imge;
            [self.emojs addObject:item];
        }
    }
}

#pragma mark - input
- (NSInteger)numberOfSourceForInput {
    return 3;
}

- (NSInteger)numberOfPageForSource:(TTInputSource *)source {
    if ([source.tag isEqualToString:@"a"]) {
        return 1;
    }else {
        return 0;
    }
}

- (NSInteger)itemNumerInPageIndex:(NSInteger)index atSource:(TTInputSource *)source {
    if ([source.tag isEqualToString:@"a"]) {
        if (index == 0) {
            return self.emojs.count;
        }
    }
    return 0;
}

- (TTInputSource *)sourceAtIndex:(NSInteger)index {
    switch (index) {
        case 0:{
            TTInputSource *source = [TTInputSource normalSource];
            source.barItemSize = CGSizeMake(30, 30);
            source.barItemMargin = UIEdgeInsetsMake(5, 10, 5, 10);
            source.tag = @"a";
            source.foucesHeight = 200;
            return source;
        }
        case 1:
        {
            TTInputSource *source = [TTInputSource textInputSource];
            source.tag = @"b";
            source.barItemSize = CGSizeMake(100, 30);
            source.barItemMargin = UIEdgeInsetsMake(5, 10, 5, 10);
            return source;
        }
        case 2:
        {
            TTInputSource *source = [TTInputSource normalSource];
            source.barItemSize = CGSizeMake(30, 30);
            source.barItemMargin = UIEdgeInsetsMake(5, 10, 5, 10);
            source.tag = @"c";
            return source;
        }
        default:
            return [TTInputSource normalSource];
            break;
    }
}

- (UIEdgeInsets)marginForPageIndex:(NSInteger)index atSource:(TTInputSource *)source {
    return UIEdgeInsetsMake(10, 20, 10, 20);
}

- (UIEdgeInsets)itemMarginForPageIndex:(NSInteger)index atSource:(TTInputSource *)source {
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (CGSize)itemSizeForPageAtIndex:(NSInteger)index atSource:(TTInputSource *)source {
    return CGSizeMake(24, 24);
}

- (TTInputSourceItem *)itemForPageAtIndex:(TTInputIndex)index atSource:(TTInputSource *)source {
    if ([source.tag isEqualToString:@"a"]) {
        if (index.page == 0) {
            return [self.emojs objectAtIndex:index.row];
        }
    }
    return 0;
}

- (void)itemSelected:(TTInputSourceItem *)item atIndex:(TTInputIndex)index forsource:(TTInputSource *)source {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.input landingPanel];
}

@end
