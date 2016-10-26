//
//  RootTabbarVC.m
//  房地产项目
//
//  Created by apple on 16/6/22.
//  Copyright © 2016年 apple. All rights reserved.
//   自定义tableBar

#import "RootTabbarVC.h"
#import "SiriusVC.h"
#import "HomePageTableVC.h"
#import "MineTableVC.h"
#import "NavC.h"
#import "ShoppingCartVC.h"
#import "Reachability.h"
#import <UMSocial.h>
#import <UMSocialData.h>
#import <UMSocialSnsData.h>
#import <UMSocialWechatHandler.h>
#import <UMSocialQQHandler.h>
#import <UMSocialSinaSSOHandler.h>

@interface RootTabbarVC ()<UITabBarDelegate>

@property (nonatomic,strong) Reachability *hostReach;
@property (nonatomic, retain) UIAlertController *alertController;

@end

@implementation RootTabbarVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
        self.tabBarController.tabBar.delegate = self;
    
    [self reachability];
    
    [self setTabBarController];
    
    [self setupAPPKEY];
}



+ (void)initialize
{
    //通过appearance属性统一设置文字的属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:31 / 255.0 green:42 / 255.0 blue:70 / 255.0 alpha:1.000];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)setTabBarController
{
    // 首页
    HomePageTableVC *homeVC = [[HomePageTableVC alloc] initWithStyle:(UITableViewStylePlain)];
    NavC *homeNC = [[NavC alloc] initWithRootViewController:homeVC];
    //    [homeNC.navigationBar setBackgroundImage:[UIImage imageNamed:@"home"]  forBarMetrics:(UIBarMetricsDefault)];
    [homeNC.tabBarItem setImage:[[UIImage imageNamed:@"homePage_normal"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
    [homeNC.tabBarItem setSelectedImage:[[UIImage imageNamed:@"homePage_selected"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
        [homeNC.tabBarItem setTitle:@"首页"];
    homeNC.title = @"首页";
        homeVC.title = @"首页";
    
    
    // 天狼星
    SiriusVC *glancedVC = [[SiriusVC alloc] initWithStyle:(UITableViewStylePlain)];
    NavC *glancedNC = [[NavC alloc] initWithRootViewController:glancedVC];
    [glancedNC.tabBarItem setImage:[[UIImage imageNamed:@"shengli_normal"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
    [glancedNC.tabBarItem setSelectedImage:[[UIImage imageNamed:@"shengli_selected"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
    [glancedNC.tabBarItem setTitle:@"天狼星"];
    glancedVC.title = @"天狼星";
    
    
    // 购物车
    ShoppingCartVC *providerVC = [[ShoppingCartVC alloc] init];
    NavC *ProviderNC = [[NavC alloc] initWithRootViewController:providerVC];
    [ProviderNC.tabBarItem setImage:[[UIImage imageNamed:@"supplier_normal"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
    [ProviderNC.tabBarItem setSelectedImage:[[UIImage imageNamed:@"supplier_selected"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
    [ProviderNC.tabBarItem setTitle:@"购物车"];
    providerVC.title = @"购物车";
    
    
    // 我的
    MineTableVC *loginVC = [[MineTableVC alloc] init];
    NavC *ownerNC = [[NavC alloc] initWithRootViewController:loginVC];
    [ownerNC.tabBarItem setImage:[[UIImage imageNamed:@"owner_normal"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
    [ownerNC.tabBarItem setSelectedImage:[[UIImage imageNamed:@"owner_selected"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
    [ownerNC.tabBarItem setTitle:@"我的"];
    loginVC.title = @"我的";
    

    self.viewControllers = @[homeNC,glancedNC,ProviderNC,ownerNC];
    self.tabBar.tintColor = [UIColor colorWithRed:0.993 green:0.673 blue:0.156 alpha:1.000];
}

- (void)setupAPPKEY
{
#pragma mark - 第三方
    [UMSocialData setAppKey:@"57f9dfba67e58e478e000140"];
    
    // 集成QQ开关
    [UMSocialQQHandler setQQWithAppId:@"1105741004" appKey:@"ubXJVcCJx6sZ9cFT" url:@"http://www.umeng.com/social"];
    
    // 集成新浪微博开关
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"889955578" secret:@"3b14da11ce0b93b467643b8cb697b9fb" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    // 集成微信开关
    [UMSocialWechatHandler setWXAppId:@"wxfcf211f147c47159" appSecret:@"5ed5b60b7432d220863b32f25c53e8aa" url:@"http://www.umeng.com/social"];
}



- (void)reachability
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:)name:kReachabilityChangedNotification object:nil];
    
    _hostReach = [Reachability reachabilityForInternetConnection];
    
    [_hostReach startNotifier];
    
}

- (void)reachabilityChanged:(NSNotification *)notify
{
    if ([self.hostReach currentReachabilityStatus] == ReachableViaWiFi) {
        [self addAlertView:@"wifi在线"];
    }
    else if ([self.hostReach currentReachabilityStatus] == ReachableViaWWAN){
        [self addAlertView:@"移动网络在线"];
    }else{
        [self addAlertView:@"亲! 没网了哟～"];
    }
}
// 提示框
- (void)addAlertView:(NSString *)info
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:info delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];

    
    [alert show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    });
}

@end










