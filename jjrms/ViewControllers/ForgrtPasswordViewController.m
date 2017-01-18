//
//  ForgrtPasswordViewController.m
//  jjrms
//
//  Created by user on 2016/12/8.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "ForgrtPasswordViewController.h"

@interface ForgrtPasswordViewController ()

@end

@implementation ForgrtPasswordViewController
{
    UILabel *_infoLab;
    UILabel *_Tel;
    UITextField *_TelTextField;
    UIView *_lineone;
    UIImageView *_checkNameImgV;
    
    UIButton *_nextBtn;
    UIScrollView *_backScroll;//背景scroll
    LoginBarView *_barView;
    
    UILabel *_errorLab;
    UILabel *_errorInfo;

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
    }];
    UITapGestureRecognizer *whiteViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap)];
    [_backScroll addGestureRecognizer:whiteViewTap];
    
    
    
    _barView=[[LoginBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 256*HSCALE)];
    [_barView.backBut addTarget:self action:@selector(backAC) forControlEvents:UIControlEventTouchUpInside];
    _barView.titleLab.text=NSLocalizedString(@"wangjimima_lg",nil);
    [_backScroll addSubview:_barView];
    
    
    
    _infoLab=[[UILabel alloc]init];
    [_infoLab setFont:[UIFont systemFontOfSize:20]];
    _infoLab.textColor=[UIColor colorWithHexString:@"#555555"];
    _infoLab.text=NSLocalizedString(@"wangjimimatishi_lg",nil);
    _infoLab.numberOfLines=0;
    [_backScroll addSubview:_infoLab];
    [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_barView.mas_bottom).offset(50*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
        make.right.mas_equalTo(-50*WSCALE);
        make.width.mas_equalTo(SCREEN_WIDTH-100*WSCALE);
    }];
    
    
    _Tel=[[UILabel alloc]init];
    _Tel.text=NSLocalizedString(@"dianhuahaoma_lg",nil);
    _Tel.textColor=[UIColor colorWithHexString:@"#555555"];
    [_Tel setFont:[UIFont systemFontOfSize:15]];
    _Tel.textAlignment=NSTextAlignmentCenter;
    [_backScroll addSubview:_Tel];
    [_Tel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_infoLab.mas_bottom).offset(110*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
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
        make.top.mas_equalTo(_Tel.mas_bottom).offset(30*HSCALE);
        make.width.mas_equalTo(100*WSCALE);
    }];
    
    
    
    _TelTextField=[[UITextField alloc]init];
    //_nameTextField.placeholder=NSLocalizedString(@"LoginNamePlaceholder_lg",nil);
    _TelTextField.textColor=[UIColor colorWithHexString:@"#555555"];
    _TelTextField.font=[UIFont systemFontOfSize:24];
    _TelTextField.adjustsFontSizeToFitWidth=YES;
    _TelTextField.delegate=self;
    _TelTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_backScroll addSubview:_TelTextField];
    [_TelTextField mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.centerY.equalTo(_TelTextField.mas_centerY);
    }];
    _checkNameImgV.hidden=YES;
    
    
    _lineone=[[UIView alloc]init];
    _lineone.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [_backScroll addSubview:_lineone];
    [_lineone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(540*WSCALE, 2*HSCALE));
        make.left.mas_equalTo(50*WSCALE);
        make.top.mas_equalTo(_TelTextField.mas_bottom).offset(28*HSCALE);
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
        make.top.mas_equalTo(_lineone.mas_bottom).offset(50*HSCALE);
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
        make.top.mas_equalTo(_lineone.mas_bottom).offset(50*HSCALE);
        make.left.mas_equalTo(_errorLab.mas_right).offset(20*WSCALE);
        make.right.mas_equalTo(-50*WSCALE-122*WSCALE);
    }];
    _errorInfo.hidden=YES;

    
    
    [_TelTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
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
        
        CGFloat y=_lineone.frame.origin.y + _lineone.frame.size.height + 20;
        _nextBtn.frame =CGRectMake(SCREEN_WIDTH-48*WSCALE-102*WSCALE, y, 102*WSCALE, 102*HSCALE);
        
    }completion:^(BOOL finished) {
        //动画执行完毕后的操作
    }];
    
}

-(void)textFieldDidChange:(UITextField *)textField{
    if (_TelTextField.text.length>0) {
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"ji"] forState:UIControlStateNormal];
        _nextBtn.userInteractionEnabled=YES;
        _checkNameImgV.hidden=NO;
        
    }else{
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"notji"] forState:UIControlStateNormal];
        _nextBtn.userInteractionEnabled=NO;
        _checkNameImgV.hidden=YES;
    }
}

-(void)telCheck{
    [_TelTextField resignFirstResponder];
    CGFloat y=SCREEN_HEIGHT-24*HSCALE-102*HSCALE;
    _nextBtn.frame =CGRectMake(SCREEN_WIDTH-48*WSCALE-102*WSCALE, y, 102*WSCALE, 102*HSCALE);
    ForgetTelCheckViewController *vc=[[ForgetTelCheckViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

    
}

-(void)changeText{
    _errorLab.hidden=YES;
    _errorInfo.hidden=YES;
}

-(void)nextAction{
    //CR_phone=_TelTextField.text;
    //NSString *countrycode=[_telZoneButton.titleLabel.text substringFromIndex:1];
    BOOL phone_bool;//是否做了更改
    if ([[DataProcessing sharedManager].phone_reset isEqualToString:_TelTextField.text]) {
        phone_bool=NO;
    }else{
        phone_bool=YES;
    }

    
    
    
    [DataProcessing sharedManager].phone_reset=_TelTextField.text;

    [DataProcessing sharedManager].contry_reset=_telZoneButton.titleLabel.text;

    [_TelTextField resignFirstResponder];
    CGFloat y=SCREEN_HEIGHT-24*HSCALE-102*HSCALE;
    _nextBtn.frame =CGRectMake(SCREEN_WIDTH-48*WSCALE-102*WSCALE, y, 102*WSCALE, 102*HSCALE);

    ForgetSMSViewController *vc=[[ForgetSMSViewController alloc]init];
    vc.telStr=_TelTextField.text;
    vc.contrycode=_telZoneButton.titleLabel.text;
    
    //60秒倒计时没走完 没做修改
    if ([[NSUserDefaults standardUserDefaults]integerForKey:FORGETSECOND]>0 && !phone_bool) {
        
        [self.navigationController pushViewController:vc animated:YES];

    }else{
        
        NSDictionary *dic=[[NSDictionary alloc]init];
        dic=@{@"country_code":_telZoneButton.titleLabel.text,@"mobile":_TelTextField.text,@"use_case":@30};
        NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
        NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"util/sendsms"timeString:dateStr];
        [[httpManager sharedManager]httpWithURL:@"util/sendsms" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
            
            NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
            
            if (status==1){
                
                [self.navigationController pushViewController:vc animated:YES];
                [[NSUserDefaults standardUserDefaults]setInteger:59 forKey:FORGETSECOND];
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
    
    
}

-(void)backAC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)clickTap{
    [_TelTextField resignFirstResponder];
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
