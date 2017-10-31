//
//  TTInput.m
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInput.h"


NSString * const TTInputName = @"name";

NSString * const TTInputSources = @"sources";

@interface TTInput ()<TTInputSourceProtocol>

@property (nonatomic, copy) NSString * name;

@property (nonatomic, strong) UIView * sourceContainerView;

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


- (instancetype)initWithDicTionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.sources = [NSMutableArray array];
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

- (void)source:(TTInputSource *)source willChangeStateTo:(TTIInputSoureFocusState)state {
    if (source == self.focusSource) {//如果是当前的surce
        if (state == TTIInputSoureFocusStateNone){
            [source disappearSource];
            self.focusSource = nil;
        }
    }else {
        if (state == TTIInputSoureFocusStateFoucus) {
            self.focusSource = source;
        }
    }
}


#pragma mark - UI

- (void)initialUI {
    
    [self initialContainerViewWithHeight:0];
    [self initialBar];
}

- (void)initialBar {
    UIView *bar = self.inpurtBar;
    bar.backgroundColor = [UIColor redColor];
    [self addSubview:bar];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bar.mas_top);
    }];
    
    [bar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(self.barHeight);
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
    }
    [self.sourceContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    
    self.sourceContainerView.backgroundColor = [UIColor blueColor];
}
#pragma mark - 设置代理

- (void)becomeListener {
    
}

#pragma mark - 高度变化
- (void)toChangeSourceHeight:(CGFloat)height time:(CGFloat)time animateOption:(UIViewAnimationOptions)options {
    
    __weak typeof(self)wself = self;
    [UIView animateWithDuration:time animations:^{
        [self  initialContainerViewWithHeight:height];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [wself showSourceView];
    }];
    
}

#pragma mark - sourceview show

- (void)showSourceView {
    UIView *sourceView = self.focusSource.sourceView;
    if (sourceView) {
        [self.sourceContainerView addSubview:sourceView];
        [sourceView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sourceContainerView.mas_bottom);
            make.left.equalTo(self.sourceContainerView.mas_left);
            make.right.equalTo(self.sourceContainerView.mas_right);
            make.height.equalTo(self.sourceContainerView.mas_height);
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^{
                [sourceView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.sourceContainerView.mas_top);
                    make.left.equalTo(self.sourceContainerView.mas_left);
                    make.right.equalTo(self.sourceContainerView.mas_right);
                    make.height.equalTo(self.sourceContainerView.mas_height);
                }];
                [sourceView layoutIfNeeded];
            }];
        });
        
    }
    
}

- (void)toChangeBarHeigth:(CGFloat)height animateTime:(CGFloat)time {
    [UIView animateWithDuration:time delay:time options:0 animations:^{
        [self  initialContainerViewWithHeight:height];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)sourceToBecomeFocus:(id)source {
    
}

- (void)landingPanel {
    self.focusSource.focusState = TTIInputSoureFocusStateNone;
}

#pragma mark - panelbaritemProtocol

- (void)itemFoucusChanged {
    
}

@end
