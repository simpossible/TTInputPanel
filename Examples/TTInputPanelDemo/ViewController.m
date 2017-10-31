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

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UITableView * chatTableView;

@property (nonatomic, strong) TTInput *input;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"input" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    if (data) {
        TTInput *input = [TTInput inputFromJsonData:data];
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
