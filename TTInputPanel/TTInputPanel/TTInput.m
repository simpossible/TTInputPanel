//
//  TTInput.m
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInput.h"
#import <Masonry/Masonry.h>

NSString * const TTInputName = @"name";

NSString * const TTInputSources = @"sources";

@interface TTInput ()<TTInputSourceProtocol>

@property (nonatomic, copy) NSString * name;

@property (nonatomic, strong) UIView * sourceContainerView;

@property (nonatomic, assign) CGFloat recordHeight;

/**记录不需要回调的第一帧*/
@property (nonatomic, assign) CGFloat tempHeight;

/**是否已经收起*/
@property (nonatomic, assign) BOOL islanded;


@end

@implementation TTInput


+ (instancetype)inputFromJsonData:(NSData *)data {
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (!error) {
        return  [[self alloc] initWithDicTionary:dic];
    }else {
        NSAssert(false, @"文件错误");
        return nil;
    }    
}

- (instancetype)initWithDataSource:(id<TTInputProtocol>)dataSource {
    if (self = [super init]) {
         _sources = [NSMutableArray array];
        self.dataSource = dataSource;
        [self initialFromDataSource];
        self.backgroundColor = [UIColor clearColor];
        self.recordHeight = 0;
     
    }
    return self;
}




#pragma mark - 通过dic 创建
- (instancetype)initWithDicTionary:(NSDictionary *)dic {
    if (self = [super init]) {
        _sources = [NSMutableArray array];
        [self dealJsonObject:dic];
        [self initialUI];
    }
    return self;
}


- (void)dealJsonObject:(NSDictionary *)dic {
    self.name = [dic objectForKey:TTInputName];
    NSArray *sources = [dic objectForKey:TTInputSources];
    if (sources) {
        [self dealSourcesaArray:sources];
    }
    
    NSDictionary *barSetting = [dic objectForKey:@"bar"];
    
    CGFloat height = [[barSetting objectForKey:@"barHeight"] floatValue];
    self.barHeight = height;
    
    [self.inpurtBar setParameterWithJson:barSetting];
}


- (void)dealSourcesaArray:(NSArray *)array {
    
    for (NSDictionary *dic in array) {
        TTInputSource *source = [TTInputSource sourcesFromDic:dic];
        source.delegate = self;
        [self.sources addObject:source];
    }
    TTInputBar *bar = [[TTInputBar alloc] initWithSources:self.sources];
    self.inpurtBar = bar;
}

#pragma mark - 通过代理初始化

- (void)initialFromDataSource {
    NSInteger numberOfsource = 0;
    
   
    if ([self.dataSource respondsToSelector:@selector(numberOfSourceForInput)]) {
        numberOfsource = [self.dataSource numberOfSourceForInput];
    }
    for (int i = 0 ; i < numberOfsource; i ++) {
        TTInputSource * source = nil;
        if ([self.dataSource respondsToSelector:@selector(sourceAtIndex:)]) {
            source = [self.dataSource sourceAtIndex:i];
//            [self initialPageFromdataSourceForSource:source];
//            source.datasouce = self.dataSource;
            source.delegate = self;
            [_sources addObject:source];
            [source initialData];
            [source initialUI];
        }
    }
    
    self.barHeight = 50;
    if ([self.dataSource respondsToSelector:@selector(TTInputBarHeight)]) {
        self.barHeight = [self.dataSource TTInputBarHeight];
    }
    
    TTInputBar *bar = [[TTInputBar alloc] initWithSources:self.sources];
    bar.layoutType = TTInputBarLayoutTypeNormal;
    
    
    self.inpurtBar = bar;
    [self initialUI];
}

/**初始化page 的各种参数*/


#pragma mark - source的代理

- (void)foucusChangedForSource:(TTInputSource *)soure {
    
    if (soure.focusState == TTIInputSoureFocusStateFoucus) {
        //这里需要先判断是否需要自动调整高度 text 的高度需要由text source 自己进行调整
        TTInputSource *currentFocus = self.focusSource;
        [currentFocus.sourceView removeFromSuperview];
        self.focusSource = soure;
        currentFocus.focusState = TTIInputSoureFocusStateNone;
    }else {
        if (self.focusSource == soure) {//如果是当前的焦点变化 那么变为0
            self.focusSource = nil;
            [self toChangeSourceHeight:0 time:0.5 animateOption:0];
        }
    }
}

//- (void)source:(TTInputSource *)source willChangeStateTo:(TTIInputSoureFocusState)state {
//    if (source == self.focusSource) {//如果是当前的surce
//        if (state == TTIInputSoureFocusStateNone){
//            [source disappearSource];
//            self.focusSource = nil;
//        }
//    }else {
//        if (state == TTIInputSoureFocusStateFoucus) {
//            self.focusSource = source;
//        }
//    }
//}

- (BOOL)source:(TTInputSource *)source canChangeStateTo:(TTIInputSoureFocusState)state {
    if (self.focusSource != source) {
        if (state == TTIInputSoureFocusStateFoucus) {            
            self.islanded = NO;
            BOOL shouldLanded = YES;
            if ([self.dataSource respondsToSelector:@selector(sourceDidBeFocus:)]) {
               shouldLanded = [self.dataSource sourceDidBeFocus:source];
            }
            if (shouldLanded) {
                self.focusSource.focusState = TTIInputSoureFocusStateNone;
                self.focusSource = source;
            }
            return shouldLanded;
        }
      
    }else {
        if (state == TTIInputSoureFocusStateNone) {
            //回调给外部 看外部需要做什么操作了 暂时直接消失
            BOOL shouldDiss = YES;
            if ([self.dataSource respondsToSelector:@selector(sourceShouldDeFocus:)]) {
                shouldDiss = [self.dataSource sourceShouldDeFocus:source];
            }            
            if (shouldDiss) {
                [source disappearSource];
            }
        }
    }
    return YES;
}

#pragma mark - UI

- (void)initialUI {
    
    [self initialContainerViewWithHeight:0];
    [self initialBar];
}

- (void)initialBar {
    UIView *bar = self.inpurtBar;
    [self addSubview:bar];
    if ([self.dataSource respondsToSelector:@selector(TTInputBarColor)]) {
        bar.backgroundColor = [self.dataSource TTInputBarColor];
    }
    
    [bar setContentHuggingPriority:777 forAxis:UILayoutConstraintAxisVertical];
    [self setContentHuggingPriority:776 forAxis:UILayoutConstraintAxisVertical];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bar.mas_top).priority(776);
    }];
    
    [bar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_greaterThanOrEqualTo(self.barHeight);
        make.bottom.equalTo(self.sourceContainerView.mas_top);
    }];
    
}

- (void)initialContainerViewWithHeight:(CGFloat)height {
    
    if (!self.sourceContainerView) {
        self.sourceContainerView = [[UIView alloc] init];
        [self addSubview:self.sourceContainerView];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.sourceContainerView.mas_bottom);
        }];
        self.sourceContainerView.backgroundColor = [UIColor clearColor];
    }
    [self.sourceContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];        
}

#pragma mark - 设置代理

- (void)becomeListener {
    
}

#pragma mark - 高度变化
- (void)toChangeSourceHeight:(CGFloat)height time:(CGFloat)time animateOption:(UIViewAnimationOptions)options {
  
    __weak typeof(self)wself = self;
    CADisplayLink *displayLink;
//    if (self.shouldObserveHeightChange) {
//        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(disPlayLinkChanged)];
//        displayLink.frameInterval = 3;
      
//    }
    
    
    CGFloat barheight = CGRectGetHeight(self.inpurtBar.bounds);
    CGFloat cHeight = CGRectGetHeight(self.bounds);
    CGFloat endHeight = barheight + height;
    [UIView animateWithDuration:time
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
//        NSRunLoopMode mode = (self.recordHeight > height)?NSDefaultRunLoopMode:NSRunLoopCommonModes;;
                         [self  initialContainerViewWithHeight:height];
                         [self layoutIfNeeded];
                         self.tempHeight = self.sourceContainerView.layer.presentationLayer.bounds.size.height;
                         CGFloat offHeight = cHeight - endHeight;
                         if ([self.dataSource respondsToSelector:@selector(inputWillChangeByHeight:)]) {
                             [self.dataSource inputWillChangeByHeight:offHeight];
                         }
                         if ([self.dataSource respondsToSelector:@selector(inputWillChangeToHeight:)]) {
                             [self.dataSource inputWillChangeToHeight:endHeight];
                         }
    } completion:^(BOOL finished) {
        [wself showSourceView];
//        if (self.shouldObserveHeightChange) {
//            [self disPlayLinkChanged];
//        }
        
        [wself reportLayout];
//        [displayLink invalidate];
    }];
    
}

- (void)disPlayLinkChanged {
    CGFloat newWidth = self.sourceContainerView.layer.presentationLayer.bounds.size.height;
    if (self.tempHeight == newWidth) {
        return;
    }
    if ([self.dataSource respondsToSelector:@selector(inputHeightChangingFrom:toHeight:)]) {
        [self.dataSource inputHeightChangingFrom:self.recordHeight toHeight:newWidth];
    }
    self.recordHeight = newWidth;
}

- (void)reportLayout {
    for (TTInputSource *source in self.sources) {
        if (source != self.focusSource) {
            source.sourceView.hidden = YES;
        }
    }
    if ([self.dataSource respondsToSelector:@selector(inputLayouted)]) {
        [self.dataSource inputLayouted];
    }
}

#pragma mark - sourceview show

- (void)showSourceView {
    UIView *sourceView = self.focusSource.sourceView;
    
    if (sourceView.superview == self.sourceContainerView) {
        [self.sourceContainerView bringSubviewToFront:sourceView];
//        [sourceView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.sourceContainerView.mas_bottom);
//            make.left.equalTo(self.sourceContainerView.mas_left);
//            make.right.equalTo(self.sourceContainerView.mas_right);
////            make.height.equalTo(self.sourceContainerView.mas_height);
//            [sourceView layoutIfNeeded];
//        }];
    }else {
        if (sourceView) {
            [self.sourceContainerView addSubview:sourceView];
            [sourceView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.sourceContainerView.mas_top);
                make.left.equalTo(self.sourceContainerView.mas_left);
                make.right.equalTo(self.sourceContainerView.mas_right);
//                make.height.equalTo(self.sourceContainerView.mas_height);
            }];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [UIView animateWithDuration:0.5 animations:^{
//                    [sourceView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                        make.top.equalTo(self.sourceContainerView.mas_top);
//                        make.left.equalTo(self.sourceContainerView.mas_left);
//                        make.right.equalTo(self.sourceContainerView.mas_right);
////                        make.height.equalTo(self.sourceContainerView.mas_height);
//                    }];
//                    [self.sourceContainerView layoutIfNeeded];
//                }];
//            });
            
        }
    }
}

- (void)toChangeBarHeigth:(CGFloat)height animateTime:(CGFloat)time {
    [UIView animateWithDuration:time delay:time options:0 animations:^{
        [self  initialContainerViewWithHeight:height];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)barHeightWillChangeTo:(CGFloat)height from:(CGFloat)old {
    if ([self.dataSource respondsToSelector:@selector(inputWillChangeByHeight:)]) {
        [self.dataSource inputWillChangeByHeight:(old - height)];
    }
}

- (void)sourceToBecomeFocus:(id)source {
    
}

- (void)landingPanel {
    self.islanded = YES;
    [self.focusSource disappearSource];
    self.focusSource = nil;
}

#pragma mark - panelbaritemProtocol

- (void)itemFoucusChanged {
    
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
}

- (CGFloat)realBarHeight {
    CGFloat barheight = CGRectGetHeight(self.inpurtBar.bounds);
    if (barheight == 0) {
        [self.inpurtBar layoutIfNeeded];
        barheight = CGRectGetHeight(self.inpurtBar.bounds);
    }
    return barheight;
    
    
}

@end
