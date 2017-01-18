//
//  AddAccount2ViewController.m
//  jjrms
//
//  Created by user on 2016/11/21.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "AddAccount2ViewController.h"
#import "WalletViewController.h"
@interface AddAccount2ViewController ()

@end

@implementation AddAccount2ViewController
{
    UIButton *_loginButton;//登录
    UILabel *_zhanghuLB;
    UILabel *_zhanghaoLB;
    UITextField *_zhanghuTF;
    UITextField *_zhanghaoTF;
    UIView *_lin1;
    UIView *_lin2;
    UIAlertView *_alert;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self.type isEqualToString:@"AliPay"]) {
        self.navBarView.titleLab.text=NSLocalizedString(@"zhifubao_tit",nil);
    }else{
        self.navBarView.titleLab.text=NSLocalizedString(@"paypal_tit",nil);
    }
    self.navBarView.lineView.hidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    self.navBarView.backBut.hidden=NO;
    
    [self initUI];
}

-(void)initUI{
    
    
    _zhanghuLB=[[UILabel alloc]init];
    _zhanghuLB.text=NSLocalizedString(@"zhanghuming_ac",nil);
    _zhanghuLB.textColor=[UIColor blackColor];
    _zhanghuLB.font=[UIFont systemFontOfSize:15];
    _zhanghuLB.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:_zhanghuLB];
    [_zhanghuLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50*WSCALE);
        make.top.mas_equalTo(304*HSCALE);
    }];
    
    _zhanghaoLB=[[UILabel alloc]init];
    _zhanghaoLB.text=NSLocalizedString(@"zhanghao_ac",nil);
    _zhanghaoLB.textColor=[UIColor blackColor];
    _zhanghaoLB.font=[UIFont systemFontOfSize:15];
    _zhanghaoLB.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:_zhanghaoLB];
    [_zhanghaoLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50*WSCALE);
        make.top.mas_equalTo(500*HSCALE);
    }];
    //[_zhanghaoLB setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];//
    
    
    _zhanghuTF=[[UITextField alloc]init];
    _zhanghuTF.placeholder=NSLocalizedString(@"qingshuruzhanghuming",nil);
    _zhanghuTF.textColor=[UIColor colorWithHexString:@"#343b47"];
    _zhanghuTF.font=[UIFont systemFontOfSize:24];
    _zhanghuTF.adjustsFontSizeToFitWidth=YES;
    [self.view addSubview:_zhanghuTF];
    [_zhanghuTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(46*HSCALE);
        make.right.mas_equalTo(-60*WSCALE);
        make.left.mas_equalTo(60*WSCALE);
        make.top.mas_equalTo(_zhanghuLB.mas_bottom).offset(38*HSCALE);

    }];
    
    
    _zhanghaoTF=[[UITextField alloc]init];
    _zhanghaoTF.placeholder=NSLocalizedString(@"qingshuruzhanghao",nil);
    _zhanghaoTF.textColor=[UIColor colorWithHexString:@"#343b47"];
    _zhanghaoTF.font=[UIFont systemFontOfSize:24];
    _zhanghaoTF.adjustsFontSizeToFitWidth=YES;
    [self.view addSubview:_zhanghaoTF];
    [_zhanghaoTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(46*HSCALE);
        make.right.mas_equalTo(-60*WSCALE);
        make.left.mas_equalTo(60*WSCALE);
        make.top.mas_equalTo(_zhanghaoLB.mas_bottom).offset(38*HSCALE);
    }];
    
    _lin1=[[UIView alloc]init];
    _lin1.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [self.view addSubview:_lin1];
    [_lin1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(540*WSCALE, 2*HSCALE));
        make.left.mas_equalTo(50*WSCALE);
        make.top.mas_equalTo(_zhanghuTF.mas_bottom).offset(30*HSCALE);
        
    }];

    _lin2=[[UIView alloc]init];
    _lin2.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [self.view addSubview:_lin2];
    [_lin2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(540*WSCALE, 2*HSCALE));
        make.left.mas_equalTo(50*WSCALE);
        make.top.mas_equalTo(_zhanghaoTF.mas_bottom).offset(30*HSCALE);
        
    }];
    
    
    _loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_loginButton setBackgroundImage:[UIImage imageNamed:@"ji"] forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(102*WSCALE, 102*HSCALE));
        make.right.mas_equalTo(-48*WSCALE);
        make.bottom.mas_equalTo(-24*HSCALE);
    }];
    
    if ([_whichShow isEqualToString:@"review"]) {
        //_loginButton.alpha=0.1;
        _zhanghuTF.text=_model.pay_account_name;
        _zhanghaoTF.text=self.model.pay_account;
    }
}

#pragma 修改和添加
-(void)loginAction{
    
    if ([_whichShow isEqualToString:@"review"]) {
        
        //修改
        
        NSDictionary *dic=[[NSDictionary alloc]init];
        dic=@{@"pay_account":_zhanghaoTF.text,@"pay_account_name":_zhanghuTF.text,@"pay_channel":_model.pay_channel,@"id":_model.id};
        NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
        NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"cashaccount/update" timeString:dateStr];
        [[httpManager sharedManager]httpWithURL:@"cashaccount/update" method:POST param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
            NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
            
            //添加账户
            if (status==1){
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[WalletViewController class]]) {
                        WalletViewController *VC=(WalletViewController *)controller;
                        VC.isRloadList=YES;
                        [self.navigationController popToViewController:VC animated:YES];
                    }
                }
                NSString *msg=[responseDic objectForKey:@"msg"];
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:msg delegate:self cancelButtonTitle:NSLocalizedString(@"queren",nil) otherButtonTitles:nil, nil];
                [alert show];
            }
            
        } failure:^(NSError *error) {
            
        }];

        
        
    }else{
        //添加
        
        NSDictionary *dic=[[NSDictionary alloc]init];
        dic=@{@"pay_account":_zhanghaoTF.text,@"pay_account_name":_zhanghuTF.text,@"pay_channel":_type};
        NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
        NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"cashaccount/create" timeString:dateStr];
        [[httpManager sharedManager]httpWithURL:@"cashaccount/create" method:POST param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
            NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
            
            //添加账户
            if (status==1){
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[WalletViewController class]]) {
                        WalletViewController *VC=(WalletViewController *)controller;
                        [self.navigationController popToViewController:VC animated:YES];
                        VC.isRloadList=YES;
                    }
                }
                NSString *msg=[responseDic objectForKey:@"msg"];
                _alert=[[UIAlertView alloc]initWithTitle:@"" message:msg delegate:self cancelButtonTitle:NSLocalizedString(@"queren",nil) otherButtonTitles:nil, nil];
                [_alert show];
            }
            
        } failure:^(NSError *error) {
            
        }];

    }
    
    
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_zhanghaoTF resignFirstResponder];
    [_zhanghuTF resignFirstResponder];
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
