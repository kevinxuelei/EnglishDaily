//
//  DHTabBarViewController.m
//  每日美语
//
//  Created by lanou3g on 15/10/21.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "DHTabBarViewController.h"
#import "DHArticleViewController.h"
#import "DHRecommendViewController.h"
#import "DHAlbumViewController.h"
#import "DHUserViewController.h"
#import "DHNavigationViewController.h"

@interface DHTabBarViewController ()

@end

@implementation DHTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ows_display_banner_bg"]];
    
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
    
}


/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers{
    
    // 1.美文
    // 通过传过来的vc进行navagationcontroller的封装给tar
    DHArticleViewController *articleVC = [[DHArticleViewController alloc] init];
    [self setupChildViewController:articleVC title:@"美文" imageName:@"iconfont-article-normal" selectedImageName:@"iconfont-article-selected"];
    
    
    // 3.专辑
    DHAlbumViewController *albumVC = [[DHAlbumViewController alloc] init];
    [self setupChildViewController:albumVC title:@"专辑" imageName:@"iconfont-ttpodicon" selectedImageName:@"iconfont-ttpodicon(1)"];
    
    // 2.推荐
    DHRecommendViewController *recommendVC = [[DHRecommendViewController alloc] init];
    [self setupChildViewController:recommendVC title:@"推荐" imageName:@"iconfont-Recom-white" selectedImageName:@"iconfont-Recom-higted"];
    
   
    
    // 4.个人
    DHUserViewController *userVC = [[DHUserViewController alloc] init];
    [self setupChildViewController:userVC title:@"个人" imageName:@"iconfont-geren(2)" selectedImageName:@"iconfont-geren(1)"];
}

- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 2.包装一个导航控制器
    DHNavigationViewController *nav = [[DHNavigationViewController alloc] initWithRootViewController:childVc];

    [self addChildViewController:nav];
}


@end
