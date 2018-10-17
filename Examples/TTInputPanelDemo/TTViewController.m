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
#import "TTEmojiSourceItem.h"
#import "EmojiUtil.h"
#import "TTEmojiNormalLayout.h"
#import "TTEmojiDeleteNomalCell.h"

NSString * const TTINPUTEmojiName = @"emoj";
NSString * const TTINPUTFUNCName = @"func";

@interface TTViewController ()<TTInputProtocol,TTInputSourceProtocol,TTInputNormalSourceProtocol>


@property (nonatomic, strong) UITableView * chatTableView;

@property (nonatomic, strong) TTInput *input;

@property (nonatomic, strong) NSMutableArray * emojs;

@property (nonatomic, strong) NSMutableArray * emojAs;

@property (nonatomic, strong) NSMutableArray * ttemojes;

@property (nonatomic, strong) NSMutableArray * functionEmojs;

@end

@implementation TTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialData];
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"input" ofType:@"json"];
//    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
//    if (data) {
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
//    }
    
    [self initialUI];
    
    self.view.backgroundColor = [UIColor greenColor];
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
    
    NSArray *array = [[EmojiService currentService] getEmojiListByCateloyName:@"base"];
    self.ttemojes = [NSMutableArray array];
    
    for (int i = 0 ; i < array.count; i ++) {
        TTEmoji *tmoji = [array objectAtIndex:i];
        TTEmojiSourceItem *item = [[TTEmojiSourceItem alloc] initWIthEmoji:tmoji];
        item.itemImg = [EmojiUtil getFaceImage:tmoji.thumb];
        item.itemSize = CGSizeMake(24, 24);
        item.margin = UIEdgeInsetsMake(10, 9, 10, 9);
        [self.ttemojes addObject:item];

    }
    
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    //56 * 56 的大表情
    CGFloat space =  (width - 40 - 56 * 4)/6;
    UIEdgeInsets inset = UIEdgeInsetsMake(10, space, 10, space);
    NSMutableArray * funcArray = [NSMutableArray array];
//
    TTInputSourceItem *item = [[TTInputSourceItem alloc] init];
    item.itemImg = [UIImage imageNamed:@"ic_im_more_take_photo_default"];
    item.itemSize = CGSizeMake(56, 56);
    item.margin = inset;
    [funcArray addObject:item];
    
    TTInputSourceItem *item1 = [[TTInputSourceItem alloc] init];
    item1.itemImg = [UIImage imageNamed:@"ic_im_more_photo_default"];
    item1.itemSize = CGSizeMake(56, 56);
    item1.margin = inset;
    [funcArray addObject:item1];
    
    TTInputSourceItem *item2 = [[TTInputSourceItem alloc] init];
    item2.itemImg = [UIImage imageNamed:@"ic_im_more_my_room_default"];
    item2.itemSize = CGSizeMake(56, 56);
    item2.margin = inset;
    [funcArray addObject:item2];
    self.functionEmojs = funcArray;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:TTInputBundle ofType:@"bundle"];
    NSString *emojname = @"Expression";
    self.emojAs = [NSMutableArray array];
    NSString *ename = @"emojA";
    
    for (int i = 0 ; i < 22; i ++) {
        NSString *currentName = [NSString stringWithFormat:@"%@/%@%d.jpg",path,ename,i];
        UIImage *imge = [UIImage imageNamed:currentName];
        if (imge) {
            TTInputSourceItem *item = [[TTInputSourceItem alloc] init];
            item.itemImg = imge;
            item.itemSize = CGSizeMake(56, 56);
            item.margin = inset;
            [self.emojAs addObject:item];
        }
    }
}




/**设置高度*/

/**bar 按钮栏 的高度*/

#pragma mark - 全局配置

- (UIColor *)TTInputBarColor {
    return [UIColor colorWithRed:248.0f/255 green:248.0f/255 blue:248.0f/255 alpha:1];
}

- (NSInteger)numberOfSourceForInput {
    return 4;
}


- (TTInputSource *)sourceAtIndex:(NSInteger)index {
    switch (index) {
        case 0: {
            TTInputSource *source = [TTInputSource normalSource];
            source.barItemSize = CGSizeMake(30, 30);
            source.barItemMargin = UIEdgeInsetsMake(10, 5, 10, 5);
            source.tag = @"voice";
            source.datasouce = self;
            source.foucesHeight = 0;
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
            
        case 2:{
            
            TTInputSource *source = [TTInputSource normalSource];
            source.barItemSize = CGSizeMake(30, 30);
            source.barItemMargin = UIEdgeInsetsMake(10, 5, 10, 5);
            source.tag = TTINPUTEmojiName;
            source.datasouce = self;
            source.foucesHeight = 214;
            return source;
        }
        case 3:
        {
            TTInputSource *source = [TTInputSource normalSource];
            source.datasouce = self;
            source.barItemSize = CGSizeMake(30, 30);
            source.barItemMargin = UIEdgeInsetsMake(10, 5, 10, 5);
            source.tag = TTINPUTFUNCName;
            source.foucesHeight = 214;
            return source;
        }
        case 4:{
            
            TTInputSource *source = [TTInputSource normalSource];
            source.barItemSize = CGSizeMake(30, 30);
            source.barItemMargin = UIEdgeInsetsMake(10, 5, 10, 5);
            source.tag = @"text";
            source.datasouce = self;
            source.foucesHeight = 200;
            return source;
        }
            
            
        default:
            return [TTInputSource normalSource];
            break;
    }
}

- (CGFloat)TTInputBarHeight {
    return 48;
}


#pragma mark - input - 普通的source。就是 表情那种

/***/
- (NSArray<NSString *> *)normalCellIdentifiersForSource:(TTInputSource *)source {
    return @[@"TTEmojiDeleteNomalCell"];
}

- (CGFloat)ttinputNormalSourceMenuHeight {
    return 44;
}


- (NSInteger)numberOfPageForSource:(TTInputSource *)source {
    if ([source.tag isEqualToString:@"voice"]) {
        return 0;
    }else if ([source.tag isEqualToString:TTINPUTFUNCName]) {
        return 1;
    }else if ([source.tag isEqualToString:TTINPUTEmojiName]) {
        return 3;
    }else  if ([source.tag isEqualToString:TTINPUTFUNCName]) {
        return 1;
    }
    return 0;
}

- (NSInteger)itemNumerInPageIndex:(NSInteger)index atSource:(TTInputSource *)source {
    if ([source.tag isEqualToString:@"voice"]) {
        return 0;
    }else if ([source.tag isEqualToString:TTINPUTEmojiName]) {
        if (index == 0) {
            return self.ttemojes.count;
        }
        if (index == 1) {
            return self.emojAs.count;
        }
        if (index == 2) {
            return self.emojAs.count;
        }
    }
    
    if ([source.tag isEqualToString:TTINPUTFUNCName]) {
        if (index == 0) {
            return self.functionEmojs.count;
        }
    }
    return 0;
}



- (UIEdgeInsets)marginForPageIndex:(NSInteger)index atSource:(TTInputSource *)source {
    if ([source.tag isEqualToString:TTINPUTEmojiName]) {
        if (index == 0) {
            return UIEdgeInsetsMake(12, 17, 27, 17);
        }else {
            return UIEdgeInsetsMake(2, 20, 60, 20);
        }
    }else if ([source.tag isEqualToString:TTINPUTFUNCName]) {
        //功能
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(12, 17, 27, 17);
}

//- (UIEdgeInsets)itemMarginForPageIndex:(NSInteger)index atSource:(TTInputSource *)source {
//    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
//    if ([source.tag isEqualToString:TTINPUTEmojiName]) {
//        if (index == 0) {//小表情
//           return UIEdgeInsetsMake(10, 9, 10, 9);
//        }
//        //56 * 56 的大表情
//        CGFloat space =  (width - 40 - 56 * 4)/6;
//        return UIEdgeInsetsMake(10, space, 10, space);
//
//    }else if ([source.tag isEqualToString:TTINPUTFUNCName]) {
//        //功能
//        return UIEdgeInsetsMake(0, 0, 0, 0);
//    }
//
//    return UIEdgeInsetsMake(10, 9, 10, 9);
//}

//- (CGSize)itemSizeForPageAtIndex:(NSInteger)index atSource:(TTInputSource *)source {
//    if ([source.tag isEqualToString:TTINPUTEmojiName]) {
//        if (index == 0) {
//            return CGSizeMake(24, 24);
//        }
//
//        if (index == 1) {
//            return CGSizeMake(56, 56);
//        }
//        if (index == 2) {
//            return CGSizeMake(56, 56);
//        }
//    }
//    if ([source.tag isEqualToString:TTINPUTFUNCName]) {
//        if (index == 1) {
//            return CGSizeMake(80, 80);
//        }
//    }
//    return CGSizeMake(24, 24);
//}

- (TTInputSourceItem *)itemForPageAtIndex:(TTInputIndex)index atSource:(TTInputSource *)source {
    if ([source.tag isEqualToString:TTINPUTEmojiName]) {
        if (index.page == 0) {
            return [self.ttemojes objectAtIndex:index.row];
        }
        if (index.page == 1) {
            return [self.emojAs objectAtIndex:index.row];
        }
        if (index.page == 2) {
             return [self.emojAs objectAtIndex:index.row];
        }
    }
    if ([source.tag isEqualToString:TTINPUTFUNCName]) {
        if (index.page == 0) {
            return [self.functionEmojs objectAtIndex:index.row];
        }
        
    }
    return 0;
}


- (TTPageNormalLayout *)normalLayouForSource:(TTInputSource *)source {
    return [[TTEmojiNormalLayout alloc] initWithSource:source];
}

- (void)itemSelected:(TTInputSourceItem *)item atIndex:(TTInputIndex)index forsource:(TTInputSource *)source {
    
}

- (UIImage *)focusImageForSourcceBarItem:(TTInputSource *)source {
    if ([source.tag isEqualToString:@"voice"]) {
        return [UIImage imageNamed:@"ic_im_voice_default"];
    } else if ([source.tag isEqualToString:TTINPUTEmojiName]) {
        return [UIImage imageNamed:@"ic_im_keyboard_default"];
    }else if ([source.tag isEqualToString:TTINPUTFUNCName]) {
        return [UIImage imageNamed:@"ic_im_more_default"];
    }
    return [UIImage imageNamed:TTINPUTEmojiName];
}

- (UIImage *)unFocusImageForSourceBarItem:(TTInputSource *)source {
    if ([source.tag isEqualToString:@"voice"]) {
        return [UIImage imageNamed:@"ic_im_voice_default"];
    }else if ([source.tag isEqualToString:TTINPUTEmojiName]) {
        return [UIImage imageNamed:@"ic_im_expression_default"];
    }else if ([source.tag isEqualToString:TTINPUTFUNCName]) {
        return [UIImage imageNamed:@"ic_im_more_default"];
    }
    return nil;
}

- (NSArray<TTinputMenuItem *> *)itemsForMenuForSource:(TTInputSource *)source withExsitItems:(NSArray *)items {
    
//    UIButton * moreButton = [[UIButton alloc] init];
//    [moreButton setImage:[UIImage imageNamed:@"AddGroupMemberBtnHL"] forState:UIControlStateNormal];
//    TTinputMenuItem *left = [[TTinputMenuItem alloc] initWithWidth:45 flex:TTInputLayoutFlexFix content:moreButton];
//    
//    UIButton *sendButton = [[UIButton alloc] init];
//    //    [sendButton setBackgroundImage:[UIImage imageNamed:@"SendTextViewBkg"] forState:UIControlStateNormal];
//    sendButton.backgroundColor = [UIColor whiteColor];
//    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
//    [sendButton setTitleColor:[UIColor colorWithRed:143.0f/255 green:143.0f/255 blue:143.0f/255 alpha:1] forState:UIControlStateNormal];
//
//    TTinputMenuItem *right = [[TTinputMenuItem alloc] initWithWidth:50 flex:TTInputLayoutFlexFix content:sendButton];
//    NSMutableArray *array = [NSMutableArray arrayWithArray:items];
    
//    [array insertObject:left atIndex:0];
//    [array addObject:right];
    return items;
    
//    return array;
}

- (BOOL)shouldShowMenuForSource:(TTInputSource *)source {
    if ([source.tag isEqualToString:TTINPUTEmojiName]) {
        return YES;
    }
    return NO;
}

- (UIImage *)pageIconForMenu:(TTInputSource *)source atIndex:(NSInteger)index {
    if ([source.tag isEqualToString:TTINPUTEmojiName]) {
        if (index == 0) {
            return [UIImage imageNamed:@"ic_im_emoji_tab_emoji"];
        }
        if (index == 1) {
            return [UIImage imageNamed:@"ic_im_emoji_tab_collection"];
        }
        if (index == 2) {
            return [UIImage imageNamed:@"ic_im_emoji_tab_official"];
        }
    }
    return nil;
}

- (CGSize)pageIconSizeForMenu:(TTInputSource *)source atIndex:(NSInteger)index {
    return CGSizeMake(50, 44);
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
