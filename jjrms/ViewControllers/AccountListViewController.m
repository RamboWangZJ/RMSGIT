//
//  AccountListViewController.m
//  jjrms
//
//  Created by user on 16/10/20.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "AccountListViewController.h"

@interface AccountListViewController ()

@end

@implementation AccountListViewController
{
    ChildAccountViewController *_table1;
    ChildAccountViewController *_table2;
    UIView *_topView;
    UIButton *_but1;
    UIButton *_but2;
    UIView *_lineView;
    UIView *_lineShu;

    BaseScrollView *_bottomScroll;


}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarView.titleLab.text=NSLocalizedString(@"zhangdan_ac",nil);
    self.view.backgroundColor=[UIColor whiteColor];
    [self initUI];
}

-(void)initUI{
    
    _topView=[[UIView alloc]init];
    _topView.backgroundColor=[UIColor colorWithHexString:@"#fafafa"];
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(640*WSCALE, 80*HSCALE));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
    }];
    
    _lineView=[[UIView alloc]init];
    [_topView addSubview:_lineView];
    _lineView.backgroundColor=[UIColor colorWithHexString:@"#64b8f0"];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(306*WSCALE, 4*HSCALE));
        make.left.mas_equalTo(10*WSCALE);
        make.bottom.mas_equalTo(0);
    }];
    
    _lineShu=[[UIView alloc]init];
    [_topView addSubview:_lineShu];
    _lineShu.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    [_lineShu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1*WSCALE, 60*HSCALE));
        make.centerX.mas_equalTo(_topView.mas_centerX);
        make.bottom.mas_equalTo(-10);
    }];
    
    
    _but1=[UIButton buttonWithType:UIButtonTypeCustom];
    [_but1 setTitle:NSLocalizedString(@"shouru_ac",nil) forState:UIControlStateNormal];
    [_but1 addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    [_but1 setTitleColor:[UIColor colorWithHexString:@"#343b47"] forState:UIControlStateNormal];
    _but1.tag=1002;
    _but1.titleLabel.font=[UIFont systemFontOfSize:15];
    [_but1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_topView addSubview:_but1];
    [_but1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300*WSCALE, 30*HSCALE));
        make.left.mas_equalTo(20*WSCALE);
        make.centerY.mas_equalTo(_topView.mas_centerY);
    }];
    
    
    _but2=[UIButton buttonWithType:UIButtonTypeCustom];
    [_but2 setTitle:NSLocalizedString(@"zhichu_ac",nil) forState:UIControlStateNormal];
    [_but2 addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    [_but2 setTitleColor:[UIColor colorWithHexString:@"#343b47"] forState:UIControlStateNormal];
    _but2.tag=1003;
    _but2.titleLabel.font=[UIFont systemFontOfSize:15];
    [_but2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_topView addSubview:_but2];
    [_but2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300*WSCALE, 30*HSCALE));
        make.left.mas_equalTo(340*WSCALE);
        make.centerY.mas_equalTo(_topView.mas_centerY);
    }];
    
    _bottomScroll=[[BaseScrollView alloc]init];
    _bottomScroll.contentSize=CGSizeMake(SCREEN_WIDTH*2, SCREEN_HEIGHT-80*HSCALE-64);
    _bottomScroll.pagingEnabled=YES;
    _bottomScroll.bounces=NO;
    _bottomScroll.delegate=self;
    [self.view addSubview:_bottomScroll];
    [_bottomScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    _table1 = [[ChildAccountViewController alloc] init];
    //_table1.acc_status=1;
    [self addChildViewController:_table1];
    [_table1.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [_bottomScroll addSubview:_table1.view];
    
    _table2 = [[ChildAccountViewController alloc] init];
    //_table2.acc_status=-1;
    [self addChildViewController:_table2];
    [_table2.view setFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [_bottomScroll addSubview:_table2.view];

}


-(void)but1Chang {
    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*WSCALE);
    }];
    [_but1 setTitleColor:[UIColor colorWithHexString:@"#64b8f0"] forState:UIControlStateNormal];
    [_but2 setTitleColor:[UIColor colorWithHexString:@"#343b47"] forState:UIControlStateNormal];
    _bottomScroll.contentOffset=CGPointMake(0, 0);
    
}
-(void)but2Chang {
    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(324*WSCALE);
    }];
    [_but1 setTitleColor:[UIColor colorWithHexString:@"#343b47"] forState:UIControlStateNormal];
    [_but2 setTitleColor:[UIColor colorWithHexString:@"#64b8f0"] forState:UIControlStateNormal];
    _bottomScroll.contentOffset=CGPointMake(SCREEN_WIDTH, 0);
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    if (scrollView==_bottomScroll) {
        if (scrollView.contentOffset.x==0) {
            [self but1Chang];
        }else if (scrollView.contentOffset.x==SCREEN_WIDTH){
            [self but2Chang];
        }else {
            
        }
    }
}

-(void)butAction:(UIButton *)but{
    switch (but.tag) {

        case 1002:
            [self but1Chang];
            break;
        case 1003:
            [self but2Chang];
            break;
        default:
            break;
    }
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
