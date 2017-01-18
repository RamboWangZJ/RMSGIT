//
//  BaseViewController.m
//  jjrms
//
//  Created by user on 16/9/6.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //UIBarButtonItem *backItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fanhui"] style:UIBarButtonItemStylePlain target:nil action:nil];
    //self.navigationItem.backBarButtonItem=backItem;
    
    //self.navigationController.interactivePopGestureRecognizer.delegate=(id<UIGestureRecognizerDelegate>)self;
    
    //UINavigationBar *navBar = [UINavigationBar appearance];
    //[navBar setBackgroundImage:[UIImage imageNamed:@"navblack"] forBarMetrics:UIBarMetricsDefault];
    
    
    /*1.0
    self.navBarView=[[NavBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.navBarView.backBut addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navBarView];
    */

    self.navBarView=[[NavBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 256*HSCALE)];
    [self.navBarView.backBut addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navBarView.backBut.hidden=YES;
    [self.view addSubview:self.navBarView];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
}

/*
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //导航的rootViewController关闭右滑返回功能
    if (self.navigationController.viewControllers.count == 1)
    {
        return NO;
    }
    return NO;
}
*/


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
