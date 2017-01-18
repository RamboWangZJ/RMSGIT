//
//  PasswordViewController.m
//  jjrms
//
//  Created by user on 2016/12/8.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "PasswordViewController.h"

@interface PasswordViewController ()

@end

@implementation PasswordViewController
{
    UIScrollView *_backScroll;
    LoginBarView *_barView;
    UILabel *_infoLab;
    UILabel *_passwordLab;
    UIButton *_showButton;
    UITextField *_passwordTextField;
    UIImageView *_checkPasswordImgV;
    UIView *_linetwo;
    UIButton *_nextBtn;
    
    UILabel *_errorLab;
    UILabel *_errorInfo;
    
    UIAlertView *_alert;
    UIView *_grayView;
 
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBarView.hidden=YES;
    [self initUI];
}

-(void)initUI{
    self.view.backgroundColor=[UIColor whiteColor];
    
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
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        
    }];
    UITapGestureRecognizer *whiteViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap)];
    [_backScroll addGestureRecognizer:whiteViewTap];
    
    
    
    _barView=[[LoginBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 256*HSCALE)];
    [_barView.backBut addTarget:self action:@selector(backAC) forControlEvents:UIControlEventTouchUpInside];
    _barView.titleLab.text=NSLocalizedString(@"chuanjianmima_lg",nil);
    [_backScroll addSubview:_barView];
    
    
    
    _infoLab=[[UILabel alloc]init];
    [_infoLab setFont:[UIFont systemFontOfSize:20]];
    _infoLab.textColor=[UIColor colorWithHexString:@"#555555"];
    _infoLab.text=NSLocalizedString(@"mimajianyi_lg",nil);
    _infoLab.numberOfLines=0;
    [_backScroll addSubview:_infoLab];
    [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_barView.mas_bottom).offset(50*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
        make.right.mas_equalTo(-50*WSCALE);
        make.width.mas_equalTo(SCREEN_WIDTH-100*WSCALE);
        //make.height.mas_equalTo(100*HSCALE);
    }];
    //_infoLab.backgroundColor=[UIColor redColor];
    
    
    
    
    _passwordLab=[[UILabel alloc]init];
    _passwordLab.text=NSLocalizedString(@"mima_lg",nil);
    _passwordLab.textColor=[UIColor colorWithHexString:@"#555555"];
    [_passwordLab setFont:[UIFont systemFontOfSize:15]];
    _passwordLab.textAlignment=NSTextAlignmentCenter;
    [_backScroll addSubview:_passwordLab];
    [_passwordLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_infoLab.mas_bottom).offset(110*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
    }];
    
    
    _showButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_showButton setTitle:NSLocalizedString(@"xianshi_lg",nil) forState:UIControlStateNormal];
    [_showButton setTitle:NSLocalizedString(@"yincang_lg",nil) forState:UIControlStateSelected];
    [_showButton addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
    [_showButton setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
    _showButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [_showButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [_backScroll addSubview:_showButton];
    [_showButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120*WSCALE);
        make.right.mas_equalTo(-50*WSCALE);
        make.centerY.mas_equalTo(_passwordLab.mas_centerY);
    }];
    
    
    
    
    _passwordTextField=[[UITextField alloc]init];
    _passwordTextField.placeholder=NSLocalizedString(@"LoginPasswordPlaceholder_lg",nil);
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
    
    
    _nextBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setBackgroundImage:[UIImage imageNamed:@"ji"] forState:UIControlStateNormal];
    [_nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [_backScroll addSubview:_nextBtn];
    
    _nextBtn.frame=CGRectMake(SCREEN_WIDTH-48*WSCALE-102*WSCALE, SCREEN_HEIGHT-24*HSCALE-102*HSCALE, 102*WSCALE, 102*HSCALE);
    [_nextBtn setBackgroundImage:[UIImage imageNamed:@"notji"] forState:UIControlStateNormal];
    _nextBtn.userInteractionEnabled=NO;
    
    
    _errorLab=[[UILabel alloc]init];
    [_errorLab setFont:[UIFont systemFontOfSize:15]];
    _errorLab.textColor=[UIColor colorWithHexString:@"#F16666"];
    _errorLab.text=NSLocalizedString(@"cuowu_lg",nil);
    [_backScroll addSubview:_errorLab];
    [_errorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_linetwo.mas_bottom).offset(50*HSCALE);
        make.left.mas_equalTo(54*WSCALE);
        make.width.mas_equalTo(70*WSCALE);
    }];
    _errorLab.hidden=YES;
    
    
    _errorInfo=[[UILabel alloc]init];
    _errorInfo.textAlignment=NSTextAlignmentLeft;
    //_errorInfo.lineBreakMode = NSLineBreakByCharWrapping;// Wrap at character boundaries
    [_errorInfo setFont:[UIFont systemFontOfSize:15]];
    _errorInfo.textAlignment=NSTextAlignmentLeft;
    _errorInfo.textColor=[UIColor colorWithHexString:@"#444444"];
    _errorInfo.numberOfLines=0;
    [_backScroll addSubview:_errorInfo];
    [_errorInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_linetwo.mas_bottom).offset(50*HSCALE);
        make.left.mas_equalTo(_errorLab.mas_right).offset(20*WSCALE);
        make.right.mas_equalTo(-50*WSCALE-122*WSCALE);
    }];
    _errorInfo.hidden=YES;
    
    
    [_passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

#pragma textFiled
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.5 animations:^{
        //执行的动画
        _backScroll.contentOffset = CGPointMake(0, 0);
        
        CGFloat y=SCREEN_HEIGHT-24*HSCALE-102*HSCALE;
        _nextBtn.frame =CGRectMake(SCREEN_WIDTH-48*WSCALE-102*WSCALE, y, 102*WSCALE, 102*HSCALE);
    }completion:^(BOOL finished) {
        //动画执行完毕后的操作
    }];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.5 animations:^{
        //执行的动画
        _backScroll.contentOffset = CGPointMake(0, 100);
        
        CGFloat y=_linetwo.frame.origin.y + _linetwo.frame.size.height + 20;
        _nextBtn.frame =CGRectMake(SCREEN_WIDTH-48*WSCALE-102*WSCALE, y, 102*WSCALE, 102*HSCALE);
        
    }completion:^(BOOL finished) {
        //动画执行完毕后的操作
    }];
    
}

-(void)textFieldDidChange:(UITextField *)textField{
    if (_passwordTextField.text.length>0) {
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"ji"] forState:UIControlStateNormal];
        _nextBtn.userInteractionEnabled=YES;
        _checkPasswordImgV.hidden=NO;
    }else{
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"notji"] forState:UIControlStateNormal];
        _nextBtn.userInteractionEnabled=NO;
        _checkPasswordImgV.hidden=YES;
    }
}


//用户注册

-(void)nextAction{
    NSDictionary *dic=@{@"family_name":[DataProcessing sharedManager].family_name
,@"last_name":[DataProcessing sharedManager].last_name,@"phone":[DataProcessing sharedManager].phone,@"email":[DataProcessing sharedManager].email,@"password":_passwordTextField.text,@"repeat_pwd":_passwordTextField.text,@"country":[DataProcessing sharedManager].country,@"sms_code":[DataProcessing sharedManager].sms_code};
    
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"landlord/register"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"landlord/register" method:POST param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){

            _grayView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
            _grayView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapClick:)];
            tap.delegate=self;
            [_grayView addGestureRecognizer:tap];
            [[UIApplication sharedApplication].keyWindow addSubview:_grayView];
            
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:NSLocalizedString(@"zhanghuchuangjiansc_lg",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"queren",nil) otherButtonTitles:nil, nil];
            [alert show];

        }else{
            _errorLab.hidden=NO;
            _errorInfo.hidden=NO;
            NSString *msg=[responseDic objectForKey:@"msg"];
            _errorInfo.text=msg;
            [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(changeText) userInfo:nil repeats:NO];
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

-(void)changeText{
    _errorLab.hidden=YES;
    _errorInfo.hidden=YES;
}


-(void)TapClick:(UIGestureRecognizer *)tap{
    [_grayView removeFromSuperview];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [_grayView removeFromSuperview];
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[LoginViewController class]]) {
            
            LoginViewController *VC=(LoginViewController *)controller;
            
            [self.navigationController popToViewController:VC animated:YES];
        }
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



-(void)clickTap{
    [_passwordTextField resignFirstResponder];
}

-(void)backAC{
    [self.navigationController popViewControllerAnimated:YES];
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
