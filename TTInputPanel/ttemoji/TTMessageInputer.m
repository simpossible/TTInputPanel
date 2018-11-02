//
//  TTMessageInputer.m
//  TT
//
//  Created by simp on 2018/10/18.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import "TTMessageInputer.h"

#import "TTInput.h"
#import "TTInputSource.h"
#import "TTEmojiSourceItem.h"
//#import "EmojiUtil.h"
#import "TTEmojiNormalLayout.h"
#import "TTEmojiDeleteNomalCell.h"

//#import "EmojiHelper.h"
#import "TTInputTextSource.h"
#import "TTEmoji.h"
#import "TTInputFuncCell.h"
#import "TTFuncSourceItem.h"
#import "TTFuncSourceItem.h"
#import "TTInputVoiceSource.h"
#import <Masonry/Masonry.h>

#import "TTInputCustomPage.h"
#import "TTCustomEmojiPackage.h"
#import "TTInputMyEmojiEditItem.h"
#import "TTMyEmojiEditor.h"
#import "TTInputCusSourceItem.h"
#import "UIColor+Extension.h"
#import <SDWebImage/SDWebImageManager.h>

NSString * const TTINPUTEmojiName = @"emoj";
NSString * const TTINPUTFUNCName = @"func";
NSString * const TTINPUTVOICEName = @"voice";

@interface TTMessageInputer()<TTInputProtocol,TTInputSourceProtocol,TTInputNormalSourceProtocol>

@property (nonatomic, strong) UITableView * chatTableView;

@property (nonatomic, strong) TTInput *input;

@property (nonatomic, strong) NSMutableArray * emojs;

@property (nonatomic, strong) NSMutableArray * emojAs;

@property (nonatomic, strong) NSMutableArray * ttemojes;

@property (nonatomic, strong) NSMutableArray * functionEmojs;

@property (nonatomic, weak) TTInputTextSource * textSource;

@property (nonatomic, weak) TTInputNormlSouce * emojiSource;

@property (nonatomic, copy) NSString * account;

@property (nonatomic, strong) TTInputVoiceSource * voiceSource;

/**表情包 - 一个包 对应 表情source page的 */
@property (nonatomic, strong) NSMutableDictionary * pakages;

@property (nonatomic, weak)  TTInputCustomPage * myCustomPage;

@property (nonatomic, weak) UIView * iphonexBottomView;


@end

@implementation TTMessageInputer

- (instancetype)initWithAccount:(NSString *)account {
    if (self = [super init]) {
        self.account = account;
        [self initialData];
    }
    return self;
}

- (void)initialData {
    
    [self initialEmoj];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    self.pakages = dic;
//    [GET_SERVICE(EmojiService) getCustomEmojiPackageList:^(NSArray<TTCustomEmojiPackage *> *list) {
//        for (int i = 0; i < list.count; i ++) {
//            TTCustomEmojiPackage *package = [list objectAtIndex:i];
//            [self.pakages setObject:package forKey:@(i)];
//        }
//        [self.emojiSource reloadPages];
//    }];

    self.input = [[TTInput alloc] initWithDataSource:self];
    self.input.backgroundColor = [UIColor ARGB:0xF8F8F8];
    self.input.shouldObserveHeightChange = YES;
}

- (void)setDelegate:(id<TTMessageInputerProtocol>)delegate {
    _delegate = delegate;
    [self generateVoiceView];
}

- (void)generateVoiceView {
    
    UIButton *button = [[UIButton alloc] init];
    self.voiceSource.voiceButton = button;
    [button setTitleColor:[UIColor ARGB:0xA6A6A6] forState:UIControlStateNormal];
    [self.textSource.barView addSubview:self.voiceSource.voiceButton];
    button.layer.cornerRadius = 6;
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [button setTitle:@"按住 说话" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [button setBackgroundColor:[UIColor colorWithRed:237/255.0f green:237/255.0f blue:237/255.0f alpha:1]];

    [button addTarget:self.delegate action:@selector(startRecording:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self.delegate action:@selector(dragInsideRecording:) forControlEvents:UIControlEventTouchDragInside];
    [button addTarget:self.delegate action:@selector(dragOutsideRecording:) forControlEvents:UIControlEventTouchDragOutside];
    [button addTarget:self.delegate  action:@selector(stopRecording:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self.delegate action:@selector(cancelRecording:) forControlEvents:UIControlEventTouchUpOutside];
    button.hidden = YES;
}


- (void)initialEmoj {
    
    NSArray *array = nil;//[GET_SERVICE(EmojiService) getEmojiListByCateloyName:@"base"];
    self.ttemojes = [NSMutableArray array];
    
    for (int i = 0 ; i < array.count; i ++) {
        TTEmoji *tmoji = [array objectAtIndex:i];
        TTEmojiSourceItem *item = [[TTEmojiSourceItem alloc] initWIthEmoji:tmoji];
//        item.itemImg = [EmojiHelper getFaceImage:tmoji.thumb];
        item.itemSize = CGSizeMake(30, 30);
        item.margin = UIEdgeInsetsMake(7.5, 7.5, 7.5, 7.5);
        [self.ttemojes addObject:item];
    }
    
    [self initialFunctions];
//
   
//
//    NSString *path = [[NSBundle mainBundle] pathForResource:TTInputBundle ofType:@"bundle"];
//    NSString *emojname = @"Expression";
//    self.emojAs = [NSMutableArray array];
//    NSString *ename = @"emojA";
//
//    for (int i = 0 ; i < 22; i ++) {
//        NSString *currentName = [NSString stringWithFormat:@"%@/%@%d.jpg",path,ename,i];
//        UIImage *imge = [UIImage imageNamed:currentName];
//        if (imge) {
//            TTInputSourceItem *item = [[TTInputSourceItem alloc] init];
//            item.itemImg = imge;
//            item.itemSize = CGSizeMake(56, 56);
//            item.margin = inset;
//            [self.emojAs addObject:item];
//        }
//    }
}

- (void)initialFunctions {
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    //56 * 56 的大表情
    CGFloat space =  (width - 40 - 56 * 4)/6;
    UIEdgeInsets inset = UIEdgeInsetsMake(10, space, 10, space);
    NSMutableArray * funcArray = [NSMutableArray array];
    //
    CGFloat funcWidth = width/4;
    TTFuncSourceItem *item = [TTFuncSourceItem itemWithType:TTFuncTypePicture];
    [funcArray addObject:item];
    
    item = [TTFuncSourceItem itemWithType:TTFuncTypeTakePhoto];
    [funcArray addObject:item];
   
    item = [TTFuncSourceItem itemWithType:TTFuncTypeIMUnMute];
    
    [funcArray addObject:item];
    
    item = [TTFuncSourceItem itemWithType:TTFuncTypeRoom];
    [funcArray addObject:item];
    
    
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
            TTInputVoiceSource *source = [[TTInputVoiceSource alloc] init];
            source.barItemSize = CGSizeMake(32, 32);
            source.barItemMargin = UIEdgeInsetsMake(8, 5, 8, 5);
            source.tag = TTINPUTVOICEName;
            source.datasouce = self;
            source.foucesHeight = 0;
            self.voiceSource = source;
            return source;
        }
        case 1:
        {
            TTInputSource *source = [TTInputSource textInputSource];
            source.tag = @"b";
            source.datasouce = self;
            source.barItemSize = CGSizeMake(100, 32);
            source.barItemMargin = UIEdgeInsetsMake(8, 5, 8, 5);
            self.textSource = source;
            return source;
        }
            
        case 2:{
            
            TTInputSource *source = [TTInputSource normalSource];
            source.barItemSize = CGSizeMake(32, 32);
            source.barItemMargin = UIEdgeInsetsMake(8, 5, 8, 5);
            source.tag = TTINPUTEmojiName;
            source.datasouce = self;
            source.foucesHeight = 214;
            self.emojiSource = source;
            return source;
        }
        case 3:
        {
            TTInputSource *source = [TTInputSource normalSource];
            source.datasouce = self;
            source.barItemSize = CGSizeMake(32, 32);
            source.barItemMargin = UIEdgeInsetsMake(8, 5, 8, 5);
            source.tag = TTINPUTFUNCName;
            source.foucesHeight = 214;
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

/**表情包*/

- (TTInputSourcePage *)inputNormalPageForSource:(TTInputSource *)source atIndex:(NSInteger)index {
    if ([source.tag isEqualToString:TTINPUTEmojiName]) {//表情
        if (index != 0) {//第一个是普通表情用默认的就好了
            CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
            NSInteger numberPerPage = width > 400?5:4;
            CGFloat space = (width - 40- 56 * numberPerPage)/(numberPerPage*2 - 2);
            NSInteger intwdith = width;
            NSInteger number = intwdith / 56 - 1;
            CGFloat space1 = fmod((width -40), 56) / numberPerPage * 2;
            TTCustomEmojiPackage *package = [self.pakages objectForKey:@(index-1)];
            TTInputCustomPage * cusPage = [[TTInputCustomPage alloc] initWithPackage:package];
            cusPage.margin = UIEdgeInsetsMake(6, 20, 64, 20 );
            cusPage.itemMargin = UIEdgeInsetsMake(10, space, 10, space);
            cusPage.itemSize = CGSizeMake(56, 56);
            cusPage.iconSize =  CGSizeMake(50, 44);
            NSString *key = [package iconKey];
            UIImage * image =nil;//[IMAttachmentHelper imageForKey: key];
            if (image) {
                cusPage.pageIcon = image;
            }else {
                __weak TTInputCustomPage *wpage = cusPage;
                [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:package.coverUrl] options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                    wpage.pageIcon = image;
//                    [IMAttachmentHelper saveImage:image withData:data forKey:key];
                    wpage.selected = wpage.selected;
                }];
            }
            if ([package isMyEmoji]) {
                self.myCustomPage = cusPage;
            }
            return cusPage;
        }
    }
    return nil;
}

/**小表情*/
- (NSArray<NSString *> *)normalCellIdentifiersForSource:(TTInputSource *)source {
    if ([source.tag isEqualToString:TTINPUTEmojiName]) {
        return @[@"TTEmojiDeleteNomalCell",@"TTInputCustomEmojiCell",@"TTInputMyEmojiEditCell"];
    }else if ([source.tag isEqualToString:TTINPUTFUNCName]) {
        return @[@"TTInputFuncCell"];
    }
    return nil;
}

- (CGFloat)ttinputNormalSourceMenuHeight {
    return 44;
}


- (NSInteger)numberOfPageForSource:(TTInputSource *)source {
    if ([source.tag isEqualToString:TTINPUTVOICEName]) {
        return 0;
    }else if ([source.tag isEqualToString:TTINPUTEmojiName]) {
        return 1 + self.pakages.count;
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
        }else {
            TTCustomEmojiPackage *package = [self.pakages objectForKey:@(index)];
            return package.totalCount;
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
        CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
        width = width - 30;//剩下n-1的表情有多少
        width =  fmod(width, 45);
        if (width < 15) {//不能太小了 边缘
            width = 30 + width;
        }
        if (index == 0) {
            return UIEdgeInsetsMake(15, width/2, 64, width/2);
        }else {
            return UIEdgeInsetsMake(2, 20, 60, 20);
        }
    }else if ([source.tag isEqualToString:TTINPUTFUNCName]) {
        //功能
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(12, 17, 27, 17);
}


- (TTInputSourceItem *)itemForPageAtIndex:(TTInputIndex)index atSource:(TTInputSource *)source {
    if ([source.tag isEqualToString:TTINPUTEmojiName]) {
        if (index.page == 0) {
            return [self.ttemojes objectAtIndex:index.row];
        }else {
            return nil;
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
    if ([source.tag isEqualToString:TTINPUTEmojiName]) {
        return [[TTEmojiNormalLayout alloc] initWithSource:source];
    }else {
        return nil;
    }
}

- (UIImage *)focusImageForSourcceBarItem:(TTInputSource *)source {
    if ([source.tag isEqualToString:TTINPUTVOICEName]) {
        return [UIImage imageNamed:@"ic_im_keyboard_default"];
    } else if ([source.tag isEqualToString:TTINPUTEmojiName]) {
        return [UIImage imageNamed:@"ic_im_keyboard_default"];
    }else if ([source.tag isEqualToString:TTINPUTFUNCName]) {
        return [UIImage imageNamed:@"ic_im_more_default"];
    }
    return [UIImage imageNamed:TTINPUTEmojiName];
}

- (UIImage *)unFocusImageForSourceBarItem:(TTInputSource *)source {
    if ([source.tag isEqualToString:TTINPUTVOICEName]) {
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
      
    }
    return nil;
}

- (CGSize)pageIconSizeForMenu:(TTInputSource *)source atIndex:(NSInteger)index {
    return CGSizeMake(50, 44);
}

/**焦点事件*/
- (BOOL)sourceShouldDeFocus:(TTInputSource *)souce {
    if ([souce.tag isEqualToString:TTINPUTEmojiName]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.textSource becomeFoucus];
        });
        return NO;
    }else if ([souce.tag isEqualToString:TTINPUTVOICEName]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.textSource becomeFoucus];
           [self.textSource barItemRecover];
        });
        return NO;
    }
    return YES;
}

- (BOOL)sourceDidBeFocus:(TTInputSource *)souce {
    
    BOOL canBefous = YES;
    if ([self.delegate respondsToSelector:@selector(inputcanBeFocus)]) {
        canBefous = [self.delegate inputcanBeFocus];
    }
    if (canBefous) {
        if ([souce.tag isEqualToString:TTINPUTVOICEName]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.textSource barItemToDefault];
                self.iphonexBottomView.backgroundColor = [UIColor ARGB:0xF8F8F8];
            });
        }else {
            if ([souce.tag isEqualToString:TTINPUTEmojiName]) {
                self.iphonexBottomView.backgroundColor = [UIColor ARGB:0xF5F5F5];
            }else {
                self.iphonexBottomView.backgroundColor = [UIColor ARGB:0xF8F8F8];
            }
            [self.textSource barItemRecover];
        }
    }
  
    return canBefous;
}

#pragma mark - 点击事件

- (void)itemSelected:(TTInputSourceItem *)item atIndex:(TTInputIndex)index forsource:(TTInputSource *)source {
    if ([item isKindOfClass:[TTEmojiSourceItem class]]) {
        [self dealForEmojiItem:(TTEmojiSourceItem *)item];
    }else if ([item isKindOfClass:[TTFuncSourceItem class]]){
        [self daelForFuncTion:(TTFuncSourceItem *)item];
    }else if ([item isKindOfClass:[TTInputMyEmojiEditItem class]]) {
        [self toEditEmoji:(TTInputMyEmojiEditItem *)item];
    }else if ([item isKindOfClass:[TTInputCusSourceItem class]]) {
        [self dealForCustomEmojiItem:item];
    }
}

- (void)toEditEmoji:(TTInputMyEmojiEditItem *)editItem {
    TTMyEmojiEditor *editor = [[TTMyEmojiEditor alloc] init];
    if ([self.delegate respondsToSelector:@selector(inputerController)]) {
        UIViewController *vc= [self.delegate inputerController];
        [vc.navigationController pushViewController:editor animated:YES];
    }
    
    __weak typeof(self)wself = self;
    [editor setRereshBlock:^{
        [wself reloadMyCustomEmoji];
    }];
}

/**处理表情相关*/
- (void)dealForEmojiItem:(TTEmojiSourceItem *)eitem {
    if (eitem.type < TTEmojiItemTypeDelete) {
        [self insertEmoji:eitem.emoji];
    }else if (eitem.type == TTEmojiItemTypeDelete) {
        [self deleteLastCharacters];
    }else if (eitem.type == TTEmojiItemTypeSend) {
        [self send];
    }
}

- (void)dealForCustomEmojiItem:(TTInputCusSourceItem *)eitem {
    if ([self.delegate respondsToSelector:@selector(inputerSendCustomEmojiWithItem:)]) {
        [self.delegate inputerSendCustomEmojiWithItem:eitem];
    }
}

- (void)send {
    if ([self.delegate respondsToSelector:@selector(sendMsg:)]) {
       NSAttributedString * str = [self textView].attributedText;
        [self.delegate sendMsg:str];
        [self textView].attributedText = nil;
        [self.textSource textViewDidChanged];
    }
}

- (UITextView *)textView {
    return  self.textSource.textView;
}

- (void)insertEmoji:(TTEmoji *)emoji{
    UIFont *font = [self textView].font;
    
    NSAttributedString *text = nil;
    
//    if ([emoji isClassical]) {
//        TTClassicalEmojiAttachment *classicalEmojiAttachment = [[TTClassicalEmojiAttachment alloc] initWithEmojiText:emoji.md5];
//        classicalEmojiAttachment.bounds = CGRectMake(0, -5, 18, 18);
//        text = [NSAttributedString attributedStringWithAttachment:classicalEmojiAttachment];
//    }else{
//        TTEmojiAttachment *emojiAttachment = [[TTEmojiAttachment alloc] initWithEmoji:emoji];
//        emojiAttachment.bounds = CGRectMake(0, -5, 18, 18);
//        text = [NSAttributedString attributedStringWithAttachment:emojiAttachment];
//    }
    
    [[self textView].textStorage beginEditing];
    NSRange oldRange = [self textView].selectedRange;
    [[self textView].textStorage insertAttributedString:text atIndex:[self textView].selectedRange.location];
    [[self textView].textStorage endEditing];
    [self textView].selectedRange = NSMakeRange(oldRange.location+1, 0);
    [self textView].font = font;
    [self.textSource dissMissPlaceHolder];
    [self.textSource textViewDidChanged];
    
}

- (void)deleteLastCharacters{
    NSRange selectedRange = [self textView].selectedRange;
    
    if (selectedRange.location == 0 ) {
        return;
    }
    
    NSRange backwardRange = NSMakeRange(selectedRange.location-1, 1);
    
    [[self textView].textStorage beginEditing];
    [[self textView].textStorage deleteCharactersInRange:backwardRange];
    [[self textView].textStorage endEditing];
    
}

- (void)textSourceEndEdit:(TTInputSource *)source {
    [self send];
}

#pragma mark - 功能相关

- (void)daelForFuncTion:(TTFuncSourceItem *)func {
    if (func.type == TTFuncTypePicture) {
        [self toTakePicTure];
    }else if (func.type == TTFuncTypeTakePhoto) {
        [self toTakePhoto];
    }else if (func.type == TTFuncTypeRoom) {
        [self tomyRoom];
    }else if (func.type == TTFuncTypeIMMute || func.type == TTFuncTypeIMUnMute) {
        [self toMuteWithItem:func];
    }
}

- (void)toTakePicTure {
    if ([self.delegate respondsToSelector:@selector(inputerToTakePhoto)]) {
        [self.delegate inputerToTakePicture];
    }
}

- (void)toTakePhoto {
    if ([self.delegate respondsToSelector:@selector(inputerToTakePhoto)]) {
        [self.delegate inputerToTakePhoto];
    }
}

- (void)tomyRoom {
    if ([self.delegate respondsToSelector:@selector(inputerToMyRoom)]) {
        [self.delegate inputerToMyRoom];
    }
}

- (void)toMuteWithItem:(TTFuncSourceItem *)sourceItem {
    if ([self.delegate respondsToSelector:@selector(inputerToMuteGroup:)]) {
        [self.delegate inputerToMuteGroup:sourceItem];
    }
}

- (void)landing {
    if (![self.input.focusSource.tag isEqualToString:TTINPUTVOICEName]) {
        [self.input landingPanel];
    }
    self.iphonexBottomView.backgroundColor = [UIColor ARGB:0xF8F8F8];
}

- (void)landingText {
    if (self.textSource.focusState == TTIInputSoureFocusStateFoucus) {
        [self landing];
        self.iphonexBottomView.backgroundColor = [UIColor ARGB:0xF8F8F8];
    }
}

- (void)inputLayouted {
    if ([self.delegate respondsToSelector:@selector(inputerLayouted)]) {
        [self.delegate inputerLayouted];
    }
}

- (void)inputWillChangeToHeight:(CGFloat)height {
    if ([self.delegate respondsToSelector:@selector(inputWillChangeToHeight:)]) {
        [self.delegate inputWillChangeToHeight:height];
    }
}

- (void)inputWillChangeByHeight:(CGFloat)height {
    if ([self.delegate respondsToSelector:@selector(inputWillChangeToHeight:)]) {
        [self.delegate inputWillChangeByHeight:height];
    }
}

- (void)inputHeightChangingFrom:(CGFloat)oheight toHeight:(CGFloat)nheight {
    if (!self.input.islanded) {
        if ([self.delegate respondsToSelector:@selector(inputHeightChangingFrom:toHeight:)]) {
            [self.delegate inputHeightChangingFrom:oheight toHeight:nheight];
        }
    }
//    if (nheight > oheight) {//只有在增加的时候才实时变化
//    }
}


#pragma mark -刷新我的表情
- (void)reloadMyCustomEmoji {
    __weak typeof(self)wself = self;
//    [GET_SERVICE(EmojiService) getCustomEmojiPackageList:^(NSArray<TTCustomEmojiPackage *> *list) {
//        for (int i = 0; i < list.count; i ++) {
//            TTCustomEmojiPackage *package = [list objectAtIndex:i];
//            [wself.pakages setObject:package forKey:@(i)];
//        }
        [wself.emojiSource reloadPages];
//    }];
//    [self.emojiSource reloadPage:self.myCustomPage];
}

- (void)setDraftForText:(NSAttributedString *)attr {
    self.textSource.textView.attributedText = attr;
    self.textSource.textView.font = [UIFont systemFontOfSize:16];
    [self.textSource textViewDidChanged];
}

- (NSAttributedString *)draftAttr {
    return self.textSource.textView.attributedText;
}

- (void)registIphonexBottomView:(UIView *)view {
    self.iphonexBottomView = view;
}

- (NSString *)textSourceText {
    return [self textView].text;
}

- (void)setTextSoureceText:(NSString *)text {
    [self textView].text = text;
}

- (void)textView:(UITextView *)textView willTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([self.delegate respondsToSelector:@selector(textView:willTextInRange:replacementText:)]) {
        [self.delegate textView:textView willTextInRange:range replacementText:text];
    }
}
@end
