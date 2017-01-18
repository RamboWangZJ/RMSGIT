//
//  BaseService.m
//  jjrms
//
//  Created by user on 16/9/6.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseService.h"



#import "LoginViewController.h"
#import "HomeViewController.h"
#import "MineViewController.h"

#import "OrdersViewController.h"
#import "HousesViewController.h"
#import "CalsViewController.h"
#import "MsgViewController.h"
#import "MinesViewController.h"

@implementation BaseService
{
    FirstViewController *_firstVC;
    
        
    OnboardingContentViewController *_page1;
    OnboardingContentViewController *_page2;
    OnboardingContentViewController *_page3;
    OnboardingViewController *_onboardingVC;
    
}

__strong static BaseService *sharedObject;

+ (instancetype)shareBase {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}



- (void)initRootViewControllerWithWindow:(UIWindow *)window {
    
    //把返回按钮的'<'去掉
    [[UINavigationBar appearance] setBackIndicatorImage:[[UIImage alloc]init]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[[UIImage alloc] init]];
    
    //当前版本号
    NSString *version =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    //
    if ([[NSUserDefaults standardUserDefaults]boolForKey:version]) {
        if ([[NSUserDefaults standardUserDefaults]valueForKey:ACCESS_TOKEN] && [[NSUserDefaults standardUserDefaults]valueForKey:USER_SN]) {//免登录
            [self showTabBarController:window];
        }else{
            [self showLogin:window];
        }
    }else{
        
        [self loadBootPage:window];
        
    }

    /*
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"bootPaged"]==YES) {
        
        if ([[NSUserDefaults standardUserDefaults]valueForKey:ACCESS_TOKEN] && [[NSUserDefaults standardUserDefaults]valueForKey:USER_SN]) {//免登录
            [self showTabBarController:window];
        }else{
            [self showLogin:window];
        }
        
    }else{
        
        [self loadBootPage:window];

    }
    */
}




-(void)showLogin:(UIWindow *)window{
    
    LoginViewController *login=[[LoginViewController alloc]init];
    UINavigationController *NaVC1=[[UINavigationController alloc]initWithRootViewController:login];
    window.rootViewController=NaVC1;
    [window makeKeyAndVisible];
}


- (void)showTabBarController:(UIWindow *)window {
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica" size:12.0f],NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#00A6A6"], NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica" size:12.0f],NSFontAttributeName,nil] forState:UIControlStateSelected];
    

    
    OrdersViewController *v1=[[OrdersViewController alloc]init];
    UINavigationController *NaVC1=[[UINavigationController alloc]initWithRootViewController:v1];
    NaVC1.tabBarItem=[[UITabBarItem alloc]initWithTitle:NSLocalizedString(@"order_tab",nil) image:nil selectedImage:nil];
    NaVC1.tabBarItem.image=[[UIImage imageNamed:@"dingdan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NaVC1.tabBarItem.selectedImage=[[UIImage imageNamed:@"dingdan3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIOffset titleOffset=UIOffsetMake(0, -4);
    [NaVC1.tabBarItem setTitlePositionAdjustment:titleOffset];
    
    
    HousesViewController *v2=[[HousesViewController alloc]init];
    UINavigationController *NaVC2=[[UINavigationController alloc]initWithRootViewController:v2];
    NaVC2.tabBarItem=[[UITabBarItem alloc]initWithTitle:NSLocalizedString(@"fangyuan_tab",nil) image:nil selectedImage:nil];
    NaVC2.tabBarItem.image=[[UIImage imageNamed:@"fangyuan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NaVC2.tabBarItem.selectedImage=[[UIImage imageNamed:@"fangyuan1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [NaVC2.tabBarItem setTitlePositionAdjustment:titleOffset];
    
    CalsViewController *v3=[[CalsViewController alloc]init];
    UINavigationController *NaVC3=[[UINavigationController alloc]initWithRootViewController:v3];
    NaVC3.tabBarItem=[[UITabBarItem alloc]initWithTitle:NSLocalizedString(@"rili_tab",nil) image:nil selectedImage:nil];
    NaVC3.tabBarItem.image=[[UIImage imageNamed:@"rili"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NaVC3.tabBarItem.selectedImage=[[UIImage imageNamed:@"rili1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [NaVC3.tabBarItem setTitlePositionAdjustment:titleOffset];
    
    
    MsgViewController *v4=[[MsgViewController alloc]init];
    UINavigationController *NaVC4=[[UINavigationController alloc]initWithRootViewController:v4];
    NaVC4.tabBarItem=[[UITabBarItem alloc]initWithTitle:NSLocalizedString(@"xiaoxi_tab",nil) image:nil selectedImage:nil];
    NaVC4.tabBarItem.image=[[UIImage imageNamed:@"xiaoxi"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NaVC4.tabBarItem.selectedImage=[[UIImage imageNamed:@"xiaoxi1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [NaVC4.tabBarItem setTitlePositionAdjustment:titleOffset];
    
    MinesViewController *v5=[[MinesViewController alloc]init];
    UINavigationController *NaVC5=[[UINavigationController alloc]initWithRootViewController:v5];
    NaVC5.tabBarItem=[[UITabBarItem alloc]initWithTitle:NSLocalizedString(@"my_tab",nil) image:nil selectedImage:nil];
    NaVC5.tabBarItem.image=[[UIImage imageNamed:@"wode"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NaVC5.tabBarItem.selectedImage=[[UIImage imageNamed:@"wode1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [NaVC5.tabBarItem setTitlePositionAdjustment:titleOffset];
    

    
    UITabBarController *tab=[[UITabBarController alloc]init];
    tab.viewControllers=[NSArray arrayWithObjects:NaVC1,NaVC2,NaVC3,NaVC4,NaVC5,nil];
    
    
    window.rootViewController=tab;
    [window makeKeyAndVisible];

}





- (void)loadBootPage:(UIWindow *)window {
    NSLog(@"bbb");
    
    _page1=[[OnboardingContentViewController alloc]initWithImage:[UIImage imageNamed:[self getImageWithImageArr:@[@"320x480 1.png",@"640x960 1.png",@"640x1136 1.png",@"750x1334 1.png",@"1242x2208 1.png"]]] buttonText:nil action:^{
    }];
    _page2=[[OnboardingContentViewController alloc]initWithImage:[UIImage imageNamed:[self getImageWithImageArr:@[@"320x480 2.png",@"640x960 2.png",@"640x1136 2.png",@"750x1334 2.png",@"1242x2208 2.png"]]] buttonText:nil action:^{
    }];
    _page3=[[OnboardingContentViewController alloc]initWithImage:[UIImage imageNamed:[self getImageWithImageArr:@[@"320x480 3.png",@"640x960 3.png",@"640x1136 3.png",@"750x1334 3.png",@"1242x2208 3.png"]]] buttonText:@"开始" action:^{
        
        [window.rootViewController dismissViewControllerAnimated:YES completion:^{
            //[[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"bootPaged"];
            //当前版本号
            NSString *version =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:version];
            
            //登录过
            if ([[NSUserDefaults standardUserDefaults]valueForKey:ACCESS_TOKEN] && [[NSUserDefaults standardUserDefaults]valueForKey:USER_SN]) {
                [self showTabBarController:window];
            }else{
                LoginViewController *login=[[LoginViewController alloc]init];
                UINavigationController *NaVC1=[[UINavigationController alloc]initWithRootViewController:login];
                window.rootViewController=NaVC1;
            }

        }];
        
    }];

    _onboardingVC=[[OnboardingViewController alloc] initWithBackgroundImage:nil contents:@[_page1,_page2,_page3]];
    [window.rootViewController presentViewController:_onboardingVC animated:YES completion:nil];

}

//取不同分辨率下的图片
- (NSString *)getImageWithImageArr:(NSArray *)imageArr {
    if (iPhone4) {
        return imageArr[1];
    }else if (iPhone5) {
        return imageArr[2];
    }else if (iPhone6) {
        return imageArr[3];
    }else if (iPhone6Plus) {
        return imageArr[4];
    }else{
        return imageArr[4];
    }
}

@end
