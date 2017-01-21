//
//  TestVC.h
//  MJRefreshDemo
//
//  Created by jjyy on 16/10/10.
//  Copyright © 2016年 Arthur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeakView.h"
@interface TestVC : UIViewController
@property (nonatomic,weak)WeakView *vi;
@end
