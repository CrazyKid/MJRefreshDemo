//
//  WeakView.m
//  MJRefreshDemo
//
//  Created by jjyy on 16/10/12.
//  Copyright © 2016年 Arthur. All rights reserved.
//

#import "WeakView.h"

@implementation WeakView

- (void)dealloc {
    NSLog(@"view dealloc");
}

- (instancetype)init {

    self = [super initWithFrame:CGRectMake(0, 0, 200, 200)];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

@end
