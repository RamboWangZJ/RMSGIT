//
//  LoginViewController.m
//  jjrms
//
//  Created by user on 16/9/23.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "LoginViewController.h"
#import "UserLoginModel.h"
@interface LoginViewController ()

@end

static NSString *COLOR_text=@"#444444";

@implementation LoginViewController
{
    
    //2.0
    LoginBarView *_barView;
    UIButton *_forgetBtn;
    UIButton *_signBtn;
    UILabel *_dian;
    
    UILabel *_telLab;//电话
    UILabel *_passwordLab;//密码
    UIButton *_showButton;//显示密码
    UITextField *_nameTextField;//电话
    UITextField *_passwordTextField;//密码
    UIView *_lineone;//细线
    UIView *_linetwo;//细线
    //UIView *_lineshu;//竖线
    UIButton *_loginButton;//登录
    UIImageView *_checkNameImgV;//名字验证
    UIImageView *_checkPasswordImgV;//密码验证
    UILabel *_telLabel;//联系电话
    UIButton *_telButton;//电话
    UILabel *_errorLab;
    UILabel *_errorInfo;
    
    UIScrollView *_backScroll;//背景scroll
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navBarView.hidden=YES;
    
    
    [self initUI2];
    
    //是否需要强制登录
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:FORCIBLY_LOGIN];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //状态栏
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor whiteColor];
    }

}




//2.0初始化ui
-(void)initUI2{
    self.view.backgroundColor=[UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    
    _backScroll=[[UIScrollView alloc]init];
    _backScroll.backgroundColor=[UIColor whiteColor];
    _backScroll.contentSize=CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+100);
    _backScroll.bounces=NO;
    _backScroll.showsVerticalScrollIndicator=NO;//垂直
    [self.view addSubview:_backScroll];
    [_backScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    UITapGestureRecognizer *whiteViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap)];
    // 设置触控对象
    //[whiteViewTap setNumberOfTouchesRequired:1];
    // 设置轻拍的次数
    //[whiteViewTap setNumberOfTapsRequired:1];
    // 给创建好的视图添加手势 (一个视图可以添加多个手势，但是一个手势只能添加到一个视图上）
    [_backScroll addGestureRecognizer:whiteViewTap];

    
    
    _barView=[[LoginBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 256*HSCALE)];
    _barView.backBut.hidden=YES;
    _barView.titleLab.text=NSLocalizedString(@"login_lg",nil);
    [_backScroll addSubview:_barView];

    
    
    _forgetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_forgetBtn setTitle:NSLocalizedString(@"Forget_lg",nil) forState:UIControlStateNormal];
    [_forgetBtn addTarget:self action:@selector(forgetAction) forControlEvents:UIControlEventTouchUpInside];
    [_forgetBtn setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
    _forgetBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [_forgetBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_barView addSubview:_forgetBtn];
    [_forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-50*WSCALE);
        make.top.mas_equalTo(70*HSCALE-20);
    }];
    
    
    _signBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_signBtn setTitle:NSLocalizedString(@"zhuce_lg",nil) forState:UIControlStateNormal];
    [_signBtn addTarget:self action:@selector(signAction) forControlEvents:UIControlEventTouchUpInside];
    [_signBtn setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
    _signBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [_signBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_barView addSubview:_signBtn];
    [_signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_forgetBtn.mas_left).offset(-20*WSCALE);
        make.top.mas_equalTo(70*HSCALE-20);
    }];
    
    
    _dian=[[UILabel alloc]init];
    _dian.text=@"·";
    _dian.textColor=[UIColor colorWithHexString:@"#444444"];
    [_dian setFont:[UIFont systemFontOfSize:15]];
    _dian.textAlignment=NSTextAlignmentCenter;
    [_backScroll addSubview:_dian];
    [_dian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_signBtn.mas_centerY);
        make.left.mas_equalTo(_signBtn.mas_right);
        make.width.mas_equalTo(20*WSCALE);
    }];
    
    
    
    _telLab=[[UILabel alloc]init];
    _telLab.text=NSLocalizedString(@"tellab_lg",nil);
    _telLab.textColor=[UIColor colorWithHexString:COLOR_text];
    [_telLab setFont:[UIFont systemFontOfSize:15]];
    _telLab.textAlignment=NSTextAlignmentCenter;
    [_backScroll addSubview:_telLab];
    [_telLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(304*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
        make.height.mas_equalTo(30*HSCALE);
    }];
    
    
    _telZoneButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_telZoneButton setTitle:@"+86" forState:UIControlStateNormal];
    [_telZoneButton addTarget:self action:@selector(telCheck) forControlEvents:UIControlEventTouchUpInside];
    [_telZoneButton setTitleColor:[UIColor colorWithHexString:@"#00A6A6"] forState:UIControlStateNormal];
    _telZoneButton.titleLabel.font=[UIFont systemFontOfSize:18];
    [_telZoneButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_backScroll addSubview:_telZoneButton];
    _telZoneButton.layer.cornerRadius=2.0f;
    _telZoneButton.layer.borderWidth=1.0f;
    _telZoneButton.layer.borderColor=[[UIColor colorWithHexString:@"#00A6A6"] CGColor];
    [_telZoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50*WSCALE);
        make.top.mas_equalTo(_telLab.mas_bottom).offset(36*HSCALE);
        make.width.mas_equalTo(100*WSCALE);
    }];

    _nameTextField=[[UITextField alloc]init];
    //_nameTextField.placeholder=NSLocalizedString(@"LoginNamePlaceholder_lg",nil);
    _nameTextField.textColor=[UIColor colorWithHexString:@"#444444"];
    _nameTextField.font=[UIFont systemFontOfSize:24];
    _nameTextField.adjustsFontSizeToFitWidth=YES;
    _nameTextField.delegate=self;
    _nameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_backScroll addSubview:_nameTextField];
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(474*WSCALE - 100*WSCALE);
        make.centerY.mas_equalTo(_telZoneButton.mas_centerY);
        make.left.mas_equalTo(_telZoneButton.mas_right).offset(20*WSCALE);
    }];
    

    
    
    _checkNameImgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zhengque"]];
    [_backScroll addSubview:_checkNameImgV];
    [_checkNameImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(38*WSCALE, 26*HSCALE));
        make.right.mas_equalTo(-50*WSCALE);
        make.left.mas_equalTo(SCREEN_WIDTH-(38+50)*WSCALE);
        
        make.centerY.equalTo(_nameTextField.mas_centerY);
        
    }];
    _checkNameImgV.hidden=YES;
    
    
    _lineone=[[UIView alloc]init];
    _lineone.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [_backScroll addSubview:_lineone];
    [_lineone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(540*WSCALE, 2*HSCALE));
        make.left.mas_equalTo(50*WSCALE);
        make.top.mas_equalTo(_nameTextField.mas_bottom).offset(28*HSCALE);
    }];

    
    _passwordLab=[[UILabel alloc]init];
    _passwordLab.text=NSLocalizedString(@"mima_lg",nil);
    _passwordLab.textColor=[UIColor colorWithHexString:COLOR_text];
    [_passwordLab setFont:[UIFont systemFontOfSize:15]];
    _passwordLab.textAlignment=NSTextAlignmentCenter;
    [_backScroll addSubview:_passwordLab];
    [_passwordLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lineone.mas_bottom).offset(50*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
        make.height.mas_equalTo(30*HSCALE);
    }];
    
    
    _showButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_showButton setTitle:NSLocalizedString(@"xianshi_lg",nil) forState:UIControlStateNormal];
    [_showButton setTitle:NSLocalizedString(@"yincang_lg",nil) forState:UIControlStateSelected];
    [_showButton addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
    [_showButton setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
    _showButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [_showButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [_backScroll addSubview:_showButton];
    [_showButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120*WSCALE);
        make.height.mas_equalTo(40*HSCALE);
        make.right.mas_equalTo(_lineone.mas_right);
        make.centerY.mas_equalTo(_passwordLab.mas_centerY);
    }];

    
    
    
    _passwordTextField=[[UITextField alloc]init];
    //_passwordTextField.placeholder=NSLocalizedString(@"LoginPasswordPlaceholder_lg",nil);
    _passwordTextField.secureTextEntry=YES;
    //_passwordTextField.clearsOnBeginEditing = YES;
    _passwordTextField.adjustsFontSizeToFitWidth=YES;
    _passwordTextField.font=[UIFont systemFontOfSize:23];
    _passwordTextField.textColor=[UIColor colorWithHexString:@"#444444"];
    _passwordTextField.delegate=self;
    [_backScroll addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(474*WSCALE);
        make.left.mas_equalTo(60*WSCALE);
        make.top.mas_equalTo(_passwordLab.mas_bottom).offset(46*HSCALE);
    }];
    
    
    _checkPasswordImgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zhengque"]];
    [_backScroll addSubview:_checkPasswordImgV];
    [_checkPasswordImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(38*WSCALE, 26*HSCALE));
        make.centerY.equalTo(_passwordTextField.mas_centerY);
        make.right.mas_equalTo(-50*WSCALE);
        make.left.mas_equalTo(SCREEN_WIDTH-(38+50)*WSCALE);
    }];
    _checkPasswordImgV.hidden=YES;
    
    
    _linetwo=[[UIView alloc]init];
    _linetwo.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [_backScroll addSubview:_linetwo];
    [_linetwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(540*WSCALE, 2*HSCALE));
        make.left.mas_equalTo(50*WSCALE);
        make.top.mas_equalTo(_passwordTextField.mas_bottom).offset(28*HSCALE);
    }];
    
    
    
    _telLabel=[[UILabel alloc]init];
    [_telLabel setFont:[UIFont systemFontOfSize:15]];
    _telLabel.textColor=[UIColor colorWithHexString:@"#777777"];
    _telLabel.text=NSLocalizedString(@"tel_lg",nil);
    [_backScroll addSubview:_telLabel];
    [_telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_linetwo.mas_bottom).offset(50*HSCALE);
        //make.height.mas_equalTo(26*HSCALE);
        make.left.mas_equalTo(54*WSCALE);
    }];
    
    
    _telButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _telButton.titleLabel.numberOfLines=0;
    [_telButton setTitle:@"400-821-3917" forState:UIControlStateNormal];
    _telButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [_telButton addTarget:self action:@selector(telAction) forControlEvents:UIControlEventTouchUpInside];
    [_telButton setTitleColor:[UIColor colorWithHexString:@"#00A6A6"] forState:UIControlStateNormal];
    [_telButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_backScroll addSubview:_telButton];
    [_telButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_telLabel.mas_right).offset(12*WSCALE);
        make.centerY.mas_equalTo(_telLabel.mas_centerY);
        make.right.mas_equalTo(-50*HSCALE);
    }];
    
    
    _errorLab=[[UILabel alloc]init];
    _errorLab.numberOfLines=0;
    [_errorLab setFont:[UIFont systemFontOfSize:15]];
    _errorLab.textColor=[UIColor colorWithHexString:@"#F16666"];
    _errorLab.text=NSLocalizedString(@"cuowu_lg",nil);
    [_backScroll addSubview:_errorLab];
    [_errorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_linetwo.mas_bottom).offset(50*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
        make.width.mas_equalTo(70*WSCALE);
    }];
    _errorLab.hidden=YES;
    
    
    _errorInfo=[[UILabel alloc]init];
    _errorInfo.numberOfLines=0;
    _errorInfo.textAlignment=NSTextAlignmentLeft;
    _errorInfo.lineBreakMode = NSLineBreakByCharWrapping;// Wrap at character boundaries
    [_errorInfo setFont:[UIFont systemFontOfSize:15]];
    _errorInfo.textColor=[UIColor colorWithHexString:@"#444444"];
    _errorInfo.text=NSLocalizedString(@"dengluxinxi_lg",nil);
    [_backScroll addSubview:_errorInfo];
    [_errorInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_linetwo.mas_bottom).offset(50*HSCALE);
        make.left.mas_equalTo(_errorLab.mas_right).offset(12*WSCALE);
        make.right.mas_equalTo(-50*WSCALE-122*WSCALE);
    }];
    _errorInfo.hidden=YES;
    
    
    
    
    _loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_loginButton setBackgroundImage:[UIImage imageNamed:@"ji"] forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [_backScroll addSubview:_loginButton];
    //masory 布局 这个控件显示不出来。
//    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(102*WSCALE, 102*HSCALE));//
//        //make.right.mas_equalTo(-48*WSCALE);
//        //make.bottom.mas_equalTo(-24*HSCALE);
//        //make.left.mas_equalTo(0*WSCALE);
//        make.right.mas_equalTo(0*WSCALE);
//        make.top.mas_equalTo(100*HSCALE);
//    }];
    _loginButton.frame=CGRectMake(SCREEN_WIDTH-48*WSCALE-102*WSCALE, SCREEN_HEIGHT-24*HSCALE-102*HSCALE, 102*WSCALE, 102*HSCALE);
    //_loginButton.alpha=0.3;
    [_loginButton setBackgroundImage:[UIImage imageNamed:@"notji"] forState:UIControlStateNormal];

    _loginButton.userInteractionEnabled=NO;
    
    
    [_nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    
}


-(void)textFieldDidChange:(UITextField *)textField{
    if (_nameTextField.text.length>0 && _passwordTextField.text.length>0) {
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"ji"] forState:UIControlStateNormal];
        _loginButton.userInteractionEnabled=YES;

    }else{
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"notji"] forState:UIControlStateNormal];
        _loginButton.userInteractionEnabled=NO;
    }
    
    
    if (textField.text.length>0) {
        if (textField==_nameTextField) {
            _checkNameImgV.hidden=NO;
        }
        if (textField==_passwordTextField) {
            _checkPasswordImgV.hidden=NO;
        }
    }else{
        if (textField==_nameTextField) {
            _checkNameImgV.hidden=YES;
        }
        if (textField==_passwordTextField) {
            _checkPasswordImgV.hidden=YES;
        }
    }
}



-(void)telCheck{
    [_nameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];

    CGFloat y=SCREEN_HEIGHT-24*HSCALE-102*HSCALE;
    _loginButton.frame =CGRectMake(SCREEN_WIDTH-48*WSCALE-102*WSCALE, y, 102*WSCALE, 102*HSCALE);
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:ACCESS_TOKEN]) {
        TelCheckViewController *vc=[[TelCheckViewController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];

    }else{
        [[httpManager sharedManager]httpWithURL:@"user/accesstoken" method:GET param:nil timeString:nil sign:nil success:^(NSDictionary *responseDic) {
            NSDictionary *dic=responseDic;
            NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
            if (status==1) {
                NSDictionary *infoDic=[dic objectForKey:@"info"];
                NSString *access_token=[infoDic objectForKey:@"access_token"];
                [[NSUserDefaults standardUserDefaults]setValue:access_token forKey:ACCESS_TOKEN];
                
                TelCheckViewController *vc=[[TelCheckViewController alloc]init];
                
                [self.navigationController pushViewController:vc animated:YES];

            }
            
        } failure:^(NSError *error) {
            
        }];
    }

    }


//显示密码
-(void)showAction:(UIButton *)but{
    but.selected=!but.selected;
    if (but.isSelected) {
        _passwordTextField.secureTextEntry = NO;
    }else{
        _passwordTextField.secureTextEntry = YES;
    }
}

#pragma textFiled
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.5 animations:^{
        //执行的动画
        _backScroll.contentOffset = CGPointMake(0, 0);
        
        CGFloat y=SCREEN_HEIGHT-24*HSCALE-102*HSCALE;
        _loginButton.frame =CGRectMake(SCREEN_WIDTH-48*WSCALE-102*WSCALE, y, 102*WSCALE, 102*HSCALE);
    }completion:^(BOOL finished) {
        //动画执行完毕后的操作
    }];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.5 animations:^{
        //执行的动画
        _backScroll.contentOffset = CGPointMake(0, 100);
        
        //CGFloat y=SCREEN_HEIGHT-[DataProcessing sharedManager].keyBoard_H-20*HSCALE;

        CGFloat y=_telButton.frame.origin.y + _telButton.frame.size.height + 20;
        //[DataProcessing sharedManager].keyBoard_H
        _loginButton.frame =CGRectMake(SCREEN_WIDTH-48*WSCALE-102*WSCALE, y, 102*WSCALE, 102*HSCALE);

    }completion:^(BOOL finished) {
        //动画执行完毕后的操作
    }];

}


-(void)clickTap{
    [_nameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

//联系电话
-(void)telAction {
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:@"tel:400-821-3917"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
}

//用户注册
-(void)signAction{
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:ACCESS_TOKEN]) {
        CreateNameViewController *vc=[[CreateNameViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [[httpManager sharedManager]httpWithURL:@"user/accesstoken" method:GET param:nil timeString:nil sign:nil success:^(NSDictionary *responseDic) {
            NSDictionary *dic=responseDic;
            NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
            if (status==1) {
                NSDictionary *infoDic=[dic objectForKey:@"info"];
                NSString *access_token=[infoDic objectForKey:@"access_token"];
                [[NSUserDefaults standardUserDefaults]setValue:access_token forKey:ACCESS_TOKEN];
                
                CreateNameViewController *vc=[[CreateNameViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        } failure:^(NSError *error) {
            
        }];
    }

   
}

-(void)forgetAction{
    if ([[NSUserDefaults standardUserDefaults]valueForKey:ACCESS_TOKEN]) {
        ForgrtPasswordViewController *vc=[[ForgrtPasswordViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    }else{
        [[httpManager sharedManager]httpWithURL:@"user/accesstoken" method:GET param:nil timeString:nil sign:nil success:^(NSDictionary *responseDic) {
            NSDictionary *dic=responseDic;
            NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
            if (status==1) {
                NSDictionary *infoDic=[dic objectForKey:@"info"];
                NSString *access_token=[infoDic objectForKey:@"access_token"];
                [[NSUserDefaults standardUserDefaults]setValue:access_token forKey:ACCESS_TOKEN];
                
                ForgrtPasswordViewController *vc=[[ForgrtPasswordViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];

            }
            
        } failure:^(NSError *error) {
            
        }];
    }

    }

//登录
//获取 accesstoken
-(void)loginAction {
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:ACCESS_TOKEN]) {
        [self LoginAC];
    }else{
        [[httpManager sharedManager]httpWithURL:@"user/accesstoken" method:GET param:nil timeString:nil sign:nil success:^(NSDictionary *responseDic) {
            NSDictionary *dic=responseDic;
            NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
            if (status==1) {
                NSDictionary *infoDic=[dic objectForKey:@"info"];
                NSString *access_token=[infoDic objectForKey:@"access_token"];
                [[NSUserDefaults standardUserDefaults]setValue:access_token forKey:ACCESS_TOKEN];
                [self LoginAC];
            }
        } failure:^(NSError *error) {
            
        }];
    }

}


//获取 user_sn
-(void)LoginAC{
    NSDictionary *dic=@{@"phone":_nameTextField.text,@"password":_passwordTextField.text};
    
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"user/login"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"user/login" method:POST param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        if (status==1){
            
            UserLoginModel *model=[[UserLoginModel alloc]init];
            model=[UserLoginModel objectWithKeyValues:[responseDic objectForKey:@"info"]];
            [[NSUserDefaults standardUserDefaults]setValue:model.user_sn forKey:USER_SN];
            [self jpushSetTag];
            [self setjpushID];
            [[UIApplication sharedApplication].delegate window];
            [[BaseService shareBase] showTabBarController:[[UIApplication sharedApplication].delegate window]];
            
        }
        else{
            
            //_telLabel.textColor=[UIColor colorWithHexString:@"#F16666"];
            //_telLabel.text=NSLocalizedString(@"cuowu_lg",nil);
            //[_telButton setTitle:NSLocalizedString(@"dengluxinxi_lg",nil) forState:UIControlStateNormal];
            //[_telButton setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
            _telLabel.hidden=YES;
            _telButton.hidden=YES;
            _errorInfo.hidden=NO;
            _errorLab.hidden=NO;
            
            [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(changeText) userInfo:nil repeats:NO];

        }
        
    } failure:^(NSError *error) {
        
        
    }];
}


-(void)changeText{
    //_telLabel.textColor=[UIColor colorWithHexString:@"#777777"];
    //_telLabel.text=NSLocalizedString(@"tel_lg",nil);
    //[_telButton setTitle:@"400-821-3917" forState:UIControlStateNormal];
    //[_telButton setTitleColor:[UIColor colorWithHexString:@"#00A6A6"] forState:UIControlStateNormal];
    _telLabel.hidden=NO;
    _telButton.hidden=NO;
    _errorLab.hidden=YES;
    _errorInfo.hidden=YES;
}


//登录成功  设置极光推送标签
//极光标签设置
-(void)jpushSetTag{
    
    NSDictionary *dic=@{@"landlord_sn":[[NSUserDefaults standardUserDefaults]valueForKey:USER_SN]};
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"landlord/pushlabel"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"landlord/pushlabel" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        if (status==1){
            
            JPushSetModel *model=[[JPushSetModel alloc]init];
            model=[JPushSetModel objectWithKeyValues:[responseDic objectForKey:@"info"]];
            NSSet *tags = [[NSSet alloc] initWithObjects:model.country,model.sex, model.city, model.province, nil];
            [JPUSHService setTags:tags alias:@"" callbackSelector:nil object:nil];
            
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

//登录成功  设置极光推送id
-(void)setjpushID{
    
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功...：%@",registrationID);
            NSDictionary *dic=@{@"registration_id":registrationID};
            NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
            NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"landlord/updateregistration"timeString:dateStr];
            [[httpManager sharedManager]httpWithURL:@"landlord/updateregistration" method:POST param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
                
                NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
                if (status==1){
                    
                }
                
            } failure:^(NSError *error) {
                
                
            }];
            
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
}



- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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
