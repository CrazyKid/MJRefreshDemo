//
//  PresentVC.m
//  MJRefreshDemo
//
//  Created by jjyy on 16/9/27.
//  Copyright © 2016年 Arthur. All rights reserved.
//

#import "PresentVC.h"

@implementation PresentVC

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor redColor];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0+i*width/2.f, 0+i*height/2.f, width/2.f, 100)];
        btn.backgroundColor = [UIColor whiteColor];
        btn.accessibilityIdentifier = [NSString stringWithFormat:@"%d",i];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }

}

- (void)btnAction:(UIButton*)btn {
    if ([btn.accessibilityIdentifier intValue]) {
        PresentVC *vc = [[PresentVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
//        UIViewController *vc = [[UIViewController alloc] init];
//        vc.view.backgroundColor = [UIColor greenColor];
//        [_navi pushViewController:vc animated:YES];
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
//        label.text = @"third";
//        [vc.view addSubview:label];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
