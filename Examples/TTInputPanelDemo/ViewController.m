//
//  ViewController.m
//  TTInputPanelDemo
//
//  Created by simp on 2017/9/20.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "ViewController.h"
#import <TTInput.h>
#import <TTInputPanel.h>
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) UITableView * chatTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"input" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    if (data) {
        TTInput *input = [TTInput inputFromJsonData:data];
        TTInputPanel *panel = [[TTInputPanel alloc] initWithInput:input];
        [self.view addSubview:panel];
        
        [panel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initialUI {
    self.chatTableView = [[UITableView alloc] init];
}

- (void)initialData {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
