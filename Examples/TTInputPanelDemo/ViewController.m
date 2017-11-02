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

@property (nonatomic, strong) NSMutableArray * emojAs;

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
    
//    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://itunes.apple.com/lookup?id=1116383008"]];
//    NSURLResponse *rep = nil;
//    NSError *error;
//    NSData *dataa = [NSURLConnection sendSynchronousRequest:req returningResponse:&rep error:&error];
//    if (!error) {
//        //打印的服务端返回的信息以及错误信息
//        NSLog(@"%@",[[NSString alloc]initWithData:dataa encoding:NSUTF8StringEncoding]);
//        NSLog(@"%@",error);
//    }

    
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
    
    
    self.emojAs = [NSMutableArray array];
     NSString *ename = @"emojA";
    for (int i = 0 ; i < 50; i ++) {
        NSString *currentName = [NSString stringWithFormat:@"%@/%@%d.jpg",path,ename,i];
        UIImage *imge = [UIImage imageNamed:currentName];
        if (imge) {
            TTInputSourceItem *item = [[TTInputSourceItem alloc] init];
            item.itemImg = imge;
            [self.emojAs addObject:item];
        }
    }
}

#pragma mark - input
- (NSInteger)numberOfSourceForInput {
    return 3;
}

- (NSInteger)numberOfPageForSource:(TTInputSource *)source {
    if ([source.tag isEqualToString:@"c"]) {
        return 2;
    }else {
        return 0;
    }
}

- (NSInteger)itemNumerInPageIndex:(NSInteger)index atSource:(TTInputSource *)source {
    if ([source.tag isEqualToString:@"c"]) {
        if (index == 0) {
            return self.emojs.count;
        }
        if (index == 1) {
            return self.emojAs.count;
        }
    }
    return 0;
}

- (TTInputSource *)sourceAtIndex:(NSInteger)index {
    switch (index) {
        case 0:{
            TTInputSource *source = [TTInputSource normalSource];
            source.barItemSize = CGSizeMake(30, 30);
            source.barItemMargin = UIEdgeInsetsMake(10, 5, 10, 5);
            source.tag = @"a";
            source.foucesHeight = 200;
            return source;
        }
        case 1:
        {
            TTInputSource *source = [TTInputSource textInputSource];
            source.tag = @"b";
            source.barItemSize = CGSizeMake(100, 36);
            source.barItemMargin = UIEdgeInsetsMake(10, 5, 6, 5);
            return source;
        }
        case 2:
        {
            TTInputSource *source = [TTInputSource normalSource];
            source.barItemSize = CGSizeMake(30, 30);
            source.barItemMargin = UIEdgeInsetsMake(10, 5, 10, 5);
            source.tag = @"c";
             source.foucesHeight = 223;
            return source;
        }
        default:
            return [TTInputSource normalSource];
            break;
    }
}

- (UIEdgeInsets)marginForPageIndex:(NSInteger)index atSource:(TTInputSource *)source {

    return UIEdgeInsetsMake(15, 17, 27, 17);
}

- (UIEdgeInsets)itemMarginForPageIndex:(NSInteger)index atSource:(TTInputSource *)source {
    return UIEdgeInsetsMake(12, 9, 12, 9);
}

- (CGSize)itemSizeForPageAtIndex:(NSInteger)index atSource:(TTInputSource *)source {
    if ([source.tag isEqualToString:@"c"]) {
        if (index == 0) {
             return CGSizeMake(24, 24);
        }
        
        if (index == 1) {
             return CGSizeMake(50, 50);
        }
    }
    return CGSizeMake(24, 24);
}

- (TTInputSourceItem *)itemForPageAtIndex:(TTInputIndex)index atSource:(TTInputSource *)source {
    if ([source.tag isEqualToString:@"c"]) {
        if (index.page == 0) {
            return [self.emojs objectAtIndex:index.row];
        }
        if (index.page == 1) {
            return [self.emojAs objectAtIndex:index.row];
        }
    }
    return 0;
}

- (void)itemSelected:(TTInputSourceItem *)item atIndex:(TTInputIndex)index forsource:(TTInputSource *)source {
    
}

- (UIImage *)focusImageForSourcceBarItem:(TTInputSource *)source {
    if ([source.tag isEqualToString:@"a"]) {
        return [UIImage imageNamed:@"ToolViewInputVoice"];
    }else if ([source.tag isEqualToString:@"c"]) {
         return [UIImage imageNamed:@"ToolViewKeyboard"];
    }
    return [UIImage imageNamed:@"emoj"];
}

- (UIImage *)unFocusImageForSourceBarItem:(TTInputSource *)source {
    if ([source.tag isEqualToString:@"a"]) {
        return [UIImage imageNamed:@"ToolViewKeyboard"];
    }else if ([source.tag isEqualToString:@"c"]) {
         return [UIImage imageNamed:@"ToolViewEmotion"];
    }
    return nil;
}


- (NSArray<TTinputMenuItem *> *)itemsForMenuForSource:(TTInputSource *)source withExsitItems:(NSArray *)items {
    UIButton * moreButton = [[UIButton alloc] init];
    [moreButton setImage:[UIImage imageNamed:@"AddGroupMemberBtnHL"] forState:UIControlStateNormal];
    
    TTinputMenuItem *left = [[TTinputMenuItem alloc] initWithWidth:45 flex:TTInputLayoutFlexFix content:moreButton];
    
    UIButton *sendButton = [[UIButton alloc] init];
//    [sendButton setBackgroundImage:[UIImage imageNamed:@"SendTextViewBkg"] forState:UIControlStateNormal];
    sendButton.backgroundColor = [UIColor whiteColor];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor colorWithRed:143.0f/255 green:143.0f/255 blue:143.0f/255 alpha:1] forState:UIControlStateNormal];
    
    TTinputMenuItem *right = [[TTinputMenuItem alloc] initWithWidth:50 flex:TTInputLayoutFlexFix content:sendButton];
    NSMutableArray *array = [NSMutableArray arrayWithArray:items];
    
    [array insertObject:left atIndex:0];
    [array addObject:right];
    
    return array;
}

- (BOOL)shouldShowMenuForSource:(TTInputSource *)source {
    if ([source.tag isEqualToString:@"c"]) {
        return YES;
    }
    return NO;
}

- (UIImage *)pageIconForMenu:(TTInputSource *)source atIndex:(NSInteger)index {
    if ([source.tag isEqualToString:@"c"]) {
        if (index == 0) {
            return [UIImage imageNamed:@"EmotionsEmojiHL"];
        }
        if (index == 1) {
            return [UIImage imageNamed:@"ToolViewEmotionHL"];
        }
    }
    return nil;
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
