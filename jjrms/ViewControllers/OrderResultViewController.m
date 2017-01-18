//
//  OrderResultViewController.m
//  jjrms
//
//  Created by user on 16/10/13.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "OrderResultViewController.h"
#import "OrderViewController.h"
@interface OrderResultViewController ()

@end

@implementation OrderResultViewController
{
    UIImageView *_icon;
    UILabel *_resultLabel;
    UIButton *_backDetail;
    UIButton *_backList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=NSLocalizedString(@"dingdan_ho",nil);
    
    [self initUI];
}


-(void)initUI{
    
    __weak typeof(self) weakSelf = self;
    
    _icon=[[UIImageView alloc]init];
    [self.view addSubview:_icon];
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(88*WSCALE, 88*HSCALE));
        make.centerX.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(140*HSCALE+64);
    }];
    
    _resultLabel=[[UILabel alloc]init];
    _resultLabel.textAlignment=NSTextAlignmentCenter;
    _resultLabel.textColor=[UIColor colorWithHexString:@"#aaaaaa"];
    _resultLabel.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:_resultLabel];
    [_resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_icon.mas_bottom).offset(30*HSCALE);
        make.centerX.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(36*HSCALE);
    }];
    
    /*
    _backDetail=[UIButton buttonWithType:UIButtonTypeCustom];
    [_backDetail setTitle:NSLocalizedString(@"fanhui_or",nil) forState:UIControlStateNormal];
    [_backDetail addTarget:self action:@selector(backDetail) forControlEvents:UIControlEventTouchUpInside];
    _backDetail.backgroundColor=[UIColor colorWithHexString:@"#64b8f0"];
    [_backDetail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _backDetail.titleLabel.font=[UIFont systemFontOfSize:18];
    [_backDetail setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    _backDetail.layer.masksToBounds=YES;
    _backDetail.layer.cornerRadius=6;
    [self.view addSubview:_backDetail];
    [_backDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(440*WSCALE, 80*HSCALE));
        make.left.mas_equalTo(100*WSCALE);
        make.top.mas_equalTo(_resultLabel.mas_bottom).offset(120*HSCALE);
    }];
    */
    
    _backList=[UIButton buttonWithType:UIButtonTypeCustom];
    [_backList setTitle:NSLocalizedString(@"fanhuidingdan_or",nil) forState:UIControlStateNormal];
    [_backList addTarget:self action:@selector(backList) forControlEvents:UIControlEventTouchUpInside];
    _backList.backgroundColor=[UIColor colorWithHexString:@"#64b8f0"];
    [_backList setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _backList.titleLabel.font=[UIFont systemFontOfSize:18];
    [_backList setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    _backList.layer.masksToBounds=YES;
    _backList.layer.cornerRadius=6;
    [self.view addSubview:_backList];
    [_backList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(440*WSCALE, 80*HSCALE));
        make.left.mas_equalTo(100*WSCALE);
        make.top.mas_equalTo(_resultLabel.mas_bottom).offset(120*HSCALE);
    }];
    
    if (self.isSuc) {
        _icon.image=[UIImage imageNamed:@"chenggong"];
        _resultLabel.text=NSLocalizedString(@"chenggong_ac",nil);
        _resultLabel.textColor=[UIColor colorWithHexString:@"#2ecc70"];
    }else{
        _icon.image=[UIImage imageNamed:@"shibai"];
        _resultLabel.text=NSLocalizedString(@"shibai_ac",nil);
        _resultLabel.textColor=[UIColor colorWithHexString:@"#aaaaaa"];
    }
}

-(void)backDetail{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backList{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[OrderViewController class]]) {
            
            OrderViewController *orderVC=(OrderViewController *)controller;
            //orderVC.table2
            [self.navigationController popToViewController:orderVC animated:YES];
        }
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
