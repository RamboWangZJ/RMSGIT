//
//  DetailViewController.m
//  jjrms
//
//  Created by user on 16/9/7.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "DetailViewController.h"
#import "CalendarDayCell.h"
#import "CalendarMonthHeaderView.h"
#import "CalendarHomeViewController.h"
#import "Commen.h"
#import "HomeSourceModel.h"
#import "CalenViewController.h"
#import "grayChangeView.h"
@interface DetailViewController ()


@end

@implementation DetailViewController
{
    CalendarHomeViewController *_chv;
    UIButton *_but1;
    UIButton *_but2;
    UIView *_lineView;
    UIScrollView *_bottomScroll;
    grayChangeView *_grayView;
}
static NSString *MonthHeader = @"MonthHeaderView";

static NSString *DayCell = @"DayCell";



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarView.titleLab.text=NSLocalizedString(@"fangyuan_hs",nil);
    self.view.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    [self initUI];
}



-(void)initUI{
    //top
    HomeTableViewCell  *houseCell=[[HomeTableViewCell alloc]init];
    houseCell.model=self.topModel;
    [self.view addSubview:houseCell];
    [houseCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 188*HSCALE));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
    }];

    
    
    _but1=[UIButton buttonWithType:UIButtonTypeCustom];
    [_but1 setTitle:NSLocalizedString(@"rili_ca",nil) forState:UIControlStateNormal];
    [_but1 setBackgroundColor:[UIColor whiteColor]];
    [_but1 setTitleColor:[UIColor colorWithHexString:@"#343b47"] forState:UIControlStateNormal];
    _but1.titleLabel.font=[UIFont systemFontOfSize:15];
    [_but1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.view addSubview:_but1];
    [_but1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 80*HSCALE));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo((238+64)*HSCALE);
    }];

    
    self.homeCal = [[CalenViewController alloc] init];
    self.homeCal.homeModel=self.topModel;
    [self addChildViewController:self.homeCal];
    [self.view addSubview:self.homeCal.view];
    [self.homeCal.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_but1.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.mas_equalTo(0);
    }];
     
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
