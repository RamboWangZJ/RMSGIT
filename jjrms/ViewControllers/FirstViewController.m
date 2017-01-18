//
//  FirstViewController.m
//  jjrms
//
//  Created by user on 16/11/7.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden=YES;
    
    _scroll=[[UIScrollView alloc]init];
    _scroll.contentSize=CGSizeMake(SCREEN_WIDTH*3, SCREEN_HEIGHT);
    _scroll.pagingEnabled=YES;
    _scroll.bounces=NO;
    _scroll.delegate=self;
    _scroll.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:_scroll];
    [_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
    for (int i=0; i<3; i++) {
        UIImageView *imgV=[[UIImageView alloc]init];
        imgV.backgroundColor=[UIColor lightGrayColor];
        imgV.frame=CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [_scroll addSubview:imgV];
    }
    
    
    _pageControll = [[UIPageControl alloc] init];
    //_pageControll.center = CGPointMake(w * 0.5, h - 20);
    // _pageControll.bounds = CGRectMake(0, 0, 150, 50);
    _pageControll.numberOfPages = 3; // 一共显示多少个圆点（多少页）
    // 设置非选中页的圆点颜色
    _pageControll.pageIndicatorTintColor = [UIColor redColor];
    // 设置选中页的圆点颜色
    _pageControll.currentPageIndicatorTintColor = [UIColor blueColor];
    //禁止默认的点击功能
    _pageControll.enabled = NO;
    [self.view addSubview:_pageControll];
    [_pageControll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30*HSCALE);
        make.left.mas_equalTo(100*WSCALE);
        make.right.mas_equalTo(-100*WSCALE);
        make.bottom.mas_equalTo(-50*HSCALE);
    }];
    
    _cancelbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _cancelbtn.backgroundColor=[UIColor redColor];
    [_cancelbtn setTitle:@"马上开始" forState:UIControlStateNormal];
    [_cancelbtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_scroll addSubview:_cancelbtn];
    _cancelbtn.frame=CGRectMake(SCREEN_HEIGHT*2, 100*HSCALE, 200*WSCALE, 50*HSCALE);
    /*
    [_cancelbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200*WSCALE, 60*HSCALE));
        make.right.mas_equalTo(0*WSCALE);
        make.top.mas_equalTo(100*WSCALE);
    }];
    */
    //NSLog(@"...a%@", _cancelbtn.frame);

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;

    _pageControll.currentPage = page;
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
