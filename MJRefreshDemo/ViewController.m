//
//  ViewController.m
//  MJRefreshDemo
//
//  Created by jjyy on 16/9/26.
//  Copyright © 2016年 Arthur. All rights reserved.
//

#import "ViewController.h"
//#import "MJRefresh.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import "TestVC.h"

#define XZDEBUG
#ifdef XZDEBUG
#define TestLog(fmt, ...)   NSLog((@"\nFile : %@\nmethod : %s\nLine : %zd\n" fmt), \
                            [[NSString stringWithFormat:@"%s",__FILE__] lastPathComponent], \
                            __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define TestLog(fmt,...)    
#endif


@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic,strong)UIButton *testView;
@property (nonatomic,strong)UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];

    [self _createSubviews];
    
    
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(200, 200, 200, 200)];
    NSMutableArray *images = [NSMutableArray array];
    [images addObject:[UIImage imageNamed:@"x"]];
    [images addObject:[UIImage imageNamed:@"o"]];
    [images addObject:[UIImage imageNamed:@"k"]];
    view.animationImages = images;
    view.animationDuration = images.count * 0.1;
//    view.animationRepeatCount = 10;
//    [view startAnimating];
    [self.view addSubview:view];
    
    
    
    
    
    
    

#if defined(__LP64__) && __LP64__       //64位,iPhone5s及以上
//    ((void (*)(id, SEL,id))objc_msgSend)(self,@selector(test),self);
#else                                   //32位,iPhone5及以下
//    objc_msgSend(self,@selector(test),self);
#endif
}

void swizzledMethod (Class class, SEL originalSel, SEL swizzledSel) {

    Method originMethod = class_getInstanceMethod(class, originalSel);
    Method swizzleMethod = class_getInstanceMethod(class, swizzledSel);
    
    //给 class 加上名为 `originalSel` 的方法,如果已经 class 中已经存在了该方法,返回值为 NO
    BOOL isExistingFlag = class_addMethod(class, originalSel, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    
    
    if (isExistingFlag) {
        //class 中原本不存在 `originalSel` 方法,通过上面的操作加上的
        //此时的 `originalSel` 中指向的是 `swizzledSel` 的实现,
        //所以通过 `class_replaceMethod` 来达到
        //
        
        
        class_replaceMethod(class, swizzledSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzleMethod);
    }
}

- (void)_createSubviews {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width, _scrollView.bounds.size.height*2);
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    _testView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [_testView addTarget:self action:@selector(test1) forControlEvents:UIControlEventTouchUpInside];
    _testView.backgroundColor = [UIColor greenColor];
    [_scrollView addSubview:_testView];
}

- (void)test {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor yellowColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)test1 {
    [self.navigationController pushViewController:[[TestVC alloc] init] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"will appear:%f",_scrollView.contentInset.top);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"will dis:%f",_scrollView.contentInset.top);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"did appear:%f",_scrollView.contentInset.top);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"did dis:%f",_scrollView.contentInset.top);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scroll contentOffset:%@",NSStringFromCGPoint(scrollView.contentOffset));;
    NSLog(@"scroll contentSize:%@",NSStringFromCGSize(scrollView.contentSize));
    NSLog(@"scroll contentInset:%@",NSStringFromUIEdgeInsets(scrollView.contentInset));
//    NSLog(@"scroll delegate:%f",scrollView.contentInset.top);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
