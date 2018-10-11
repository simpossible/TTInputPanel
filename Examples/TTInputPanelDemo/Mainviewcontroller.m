//
//  Mainviewcontroller.m
//  TTInputPanelDemo
//
//  Created by simp on 2018/10/11.
//  Copyright © 2018年 simp. All rights reserved.
//

#import "Mainviewcontroller.h"
#import <Masonry.h>
#import "ViewController.h"
#import "TTViewController.h"

@interface Mainviewcontroller ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableview;

@property (nonatomic, strong) NSArray<NSString *> * datas;

@end

@implementation Mainviewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableview];
    
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    self.datas = @[@"微信样式",@"TT样式"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma makr - uitableview


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hehe"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hehe"];
    }
    NSString * name = [self.datas objectAtIndex:indexPath.row];
    cell.textLabel.text = name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString * name = [self.datas objectAtIndex:indexPath.row];
    if ([name isEqualToString:@"微信样式"]) {
        ViewController *vc = [[ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([name isEqualToString:@"TT样式"]) {
        TTViewController *tvc = [[TTViewController alloc] init];
        [self.navigationController pushViewController:tvc animated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
