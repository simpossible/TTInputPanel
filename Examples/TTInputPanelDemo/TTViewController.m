//
//  TTViewController.m
//  TTInputPanelDemo
//
//  Created by simp on 2018/10/11.
//  Copyright © 2018年 simp. All rights reserved.
//

#import "TTViewController.h"
#import <TTInput.h>
#import <Masonry.h>
#import <TTInputSource.h>
#import "EmojiService.h"

@interface TTViewController ()<TTInputProtocol,TTInputSourceProtocol,TTInputNormalSourceProtocol>


@property (nonatomic, strong) UITableView * chatTableView;

@property (nonatomic, strong) TTInput *input;

@property (nonatomic, strong) NSMutableArray * emojs;

@property (nonatomic, strong) NSMutableArray * emojAs;

@property (nonatomic, strong) NSMutableArray * ttemojes;

@end

@implementation TTViewController

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
    

    NSArray *array = [[EmojiService currentService] getEmojiListByCateloyName:@"base"];
    self.ttemojes = [NSMutableArray arrayWithArray:array];
    
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

#pragma mark - 普通source
- (NSInteger)numberOfSourceForInput {
    return 4;
}

- (NSInteger)numberOfPageForSource:(TTInputSource *)source {
    if ([source.tag isEqualToString:@"emoj"]) {
        return 2;
    }else {
        return 0;
    }
}

- (NSInteger)itemNumerInPageIndex:(NSInteger)index atSource:(TTInputSource *)source {
    if ([source.tag isEqualToString:@"emoj"]) {
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
            source.tag = @"emoj";
            source.datasouce = self;
            source.foucesHeight = 200;
            return source;
        }
        case 1:
        {
            TTInputSource *source = [TTInputSource textInputSource];
            source.tag = @"b";
            source.datasouce = self;
            source.barItemSize = CGSizeMake(100, 36);
            source.barItemMargin = UIEdgeInsetsMake(10, 5, 6, 5);
            return source;
        }
        case 2:
        {
            TTInputSource *source = [TTInputSource normalSource];
            source.datasouce = self;
            source.barItemSize = CGSizeMake(30, 30);
            source.barItemMargin = UIEdgeInsetsMake(10, 5, 10, 5);
            source.tag = @"func";
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
    if ([source.tag isEqualToString:@"emoj"]) {
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
    if ([source.tag isEqualToString:@"emoj"]) {
        if (index.page == 0) {
            return [self.ttemojes objectAtIndex:index.row];
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
    if ([source.tag isEqualToString:@"emoj"]) {
        return [UIImage imageNamed:@"ic_im_expression_default"];
    }else if ([source.tag isEqualToString:@"func"]) {
        return [UIImage imageNamed:@"ic_im_more_default"];
    }
    return [UIImage imageNamed:@"emoj"];
}

- (UIImage *)unFocusImageForSourceBarItem:(TTInputSource *)source {
    if ([source.tag isEqualToString:@"emoj"]) {
        return [UIImage imageNamed:@"ic_im_keyboard_default"];
    }else if ([source.tag isEqualToString:@"func"]) {
        return [UIImage imageNamed:@"ic_im_more_default"];
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
