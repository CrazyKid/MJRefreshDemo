//
//  TestVC.m
//  MJRefreshDemo
//
//  Created by jjyy on 16/10/10.
//  Copyright © 2016年 Arthur. All rights reserved.
//

#import "TestVC.h"
#import "MJRefresh.h"


@interface TestVC () <UITableViewDelegate,UITableViewDataSource>

{
    __weak WeakView *_vi;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
//    _vi = [[WeakView alloc] init];
//    [self.view addSubview:_vi];
    [self _createSubviews];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
//    NSLog(@"%@",_vi);
//}

- (void)_createSubviews {

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
}

- (void)refreshAction {
    NSLog(@"refresh");
//    [_tableView.mj_header endRefreshing];
}

#pragma mark - table view delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = [NSString stringWithFormat:@"row : %zd, section : %zd",indexPath.row, indexPath.section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    label.backgroundColor = [UIColor orangeColor];
    label.text = [NSString stringWithFormat:@"section : %zd", section];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scroll contentOffset:%@",NSStringFromCGPoint(scrollView.contentOffset));;
    NSLog(@"scroll contentSize:%@",NSStringFromCGSize(scrollView.contentSize));
    NSLog(@"scroll contentInset:%@",NSStringFromUIEdgeInsets(scrollView.contentInset));
//    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return;
    CGFloat sectionHeaderHeight = 50;
    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
