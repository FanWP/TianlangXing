//
//  NavC.m
//  房地产-新旅行
//
//  Created by xinlvxing on 16/7/18.
//  Copyright © 2016年 apple. All rights reserved.
//  自定义导航栏

#import "NavC.h"


@interface NavC ()

@end

@implementation NavC

//初始化
+(void)initialize
{
    // 当导航栏用在XMGNavigationController中, appearance设置才会生效
    //    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    UINavigationBar *bar = [UINavigationBar appearance];
    //背景
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackground"] forBarMetrics:UIBarMetricsDefault];
    //标题
    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20],               NSForegroundColorAttributeName :[UIColor whiteColor]}];
    
    // 设置item
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // UIControlStateNormal
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    // UIControlStateDisabled
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0 )//如果push 进来的不是第一个控制器
    {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [button setTitle:@"返回" forState:UIControlStateNormal];
//        button.titleLabel.font = [UIFont systemFontOfSize:15];
//        button.size = CGSizeMake(70, 17);
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
        //        button.backgroundColor = [UIColor whiteColor];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;

    }
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
