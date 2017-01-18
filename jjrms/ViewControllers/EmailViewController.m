//
//  EmailViewController.m
//  jjrms
//
//  Created by user on 2016/12/7.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "EmailViewController.h"

@interface EmailViewController ()

@end

@implementation EmailViewController
{
    UIScrollView *_backScroll;
    LoginBarView *_barView;
    UILabel *_emailLab;
    UITextField *_emailTF;
    UITextField *_emailTF2;
    UILabel *_aite;
    UIView *_lineone;
    UIView *_linetwo;
    UIImageView *_checkNameImgV;
    //UILabel *_errorLab;
    //UILabel *_errorInfo;
    UIButton *_nextBtn;

    
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
    _barView.titleLab.text=NSLocalizedString(@"buyaowangjiyouxiang_lg",nil);
    [_backScroll addSubview:_barView];
    
    
    
    _emailLab=[[UILabel alloc]init];
    [_emailLab setFont:[UIFont systemFontOfSize:15]];
    _emailLab.textColor=[UIColor colorWithHexString:@"#555555"];
    _emailLab.text=NSLocalizedString(@"dianyoudizi_lg",nil);
    [_backScroll addSubview:_emailLab];
    [_emailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_barView.mas_bottom).offset(110*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
        make.right.mas_equalTo(-50*WSCALE);
        make.width.mas_equalTo(SCREEN_WIDTH-100*WSCALE);
    }];
    
    
    _emailTF=[[UITextField alloc]init];
    //_nameTextField.placeholder=NSLocalizedString(@"LoginNamePlaceholder_lg",nil);
    _emailTF.textColor=[UIColor colorWithHexString:@"#555555"];
    _emailTF.font=[UIFont systemFontOfSize:24];
    _emailTF.adjustsFontSizeToFitWidth=YES;
    _emailTF.delegate=self;
    //_nameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_backScroll addSubview:_emailTF];
    [_emailTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(260*WSCALE);
        make.top.mas_equalTo(_emailLab.mas_bottom).offset(28*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
    }];
    
    
    _aite=[[UILabel alloc]init];
    _aite.text=@"@";
    [_aite setFont:[UIFont systemFontOfSize:24]];
    _aite.textColor=[UIColor colorWithHexString:@"#f06464"];
    [_backScroll addSubview:_aite];
    [_aite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_emailTF.mas_centerY);
        make.left.mas_equalTo(_emailTF.mas_right).offset(10*WSCALE);
    }];
    
    _emailTF2=[[UITextField alloc]init];
    //_nameTextField.placeholder=NSLocalizedString(@"LoginNamePlaceholder_lg",nil);
    _emailTF2.textColor=[UIColor colorWithHexString:@"#555555"];
    _emailTF2.font=[UIFont systemFontOfSize:24];
    _emailTF2.adjustsFontSizeToFitWidth=YES;
    _emailTF2.delegate=self;
    //_nameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_backScroll addSubview:_emailTF2];
    [_emailTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(190*WSCALE);
        make.centerY.mas_equalTo(_emailTF.mas_centerY);
        make.left.mas_equalTo(_aite.mas_right).offset(20*WSCALE);
    }];
    
    
    _checkNameImgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zhengque"]];
    [_backScroll addSubview:_checkNameImgV];
    [_checkNameImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(38*WSCALE, 26*HSCALE));
        make.right.mas_equalTo(-40*WSCALE);
        make.centerY.equalTo(_emailTF.mas_centerY);
    }];
    _checkNameImgV.hidden=YES;
    
    
    _lineone=[[UIView alloc]init];
    _lineone.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [_backScroll addSubview:_lineone];
    [_lineone mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(CGSizeMake(540*WSCALE, 2*HSCALE));
        make.width.mas_equalTo(_emailTF.mas_width);
        make.height.mas_equalTo(2*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
        make.top.mas_equalTo(_emailTF.mas_bottom).offset(28*HSCALE);
    }];
    
    _linetwo=[[UIView alloc]init];
    _linetwo.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [_backScroll addSubview:_linetwo];
    [_linetwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_emailTF2.mas_width);
        make.height.mas_equalTo(2*HSCALE);
        make.left.mas_equalTo(_emailTF2.mas_left);
        make.top.mas_equalTo(_emailTF.mas_bottom).offset(28*HSCALE);
    }];
    
    
//    _errorLab=[[UILabel alloc]init];
//    [_errorLab setFont:[UIFont systemFontOfSize:15]];
//    
//    _errorLab.textColor=[UIColor colorWithHexString:@"#F16666"];
//    _errorLab.text=NSLocalizedString(@"cuowu_lg",nil);
//    [_backScroll addSubview:_errorLab];
//    [_errorLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_lineone.mas_bottom).offset(50*HSCALE);
//        make.left.mas_equalTo(54*WSCALE);
//    }];
//    _errorLab.hidden=YES;
//    
//    
//    _errorInfo=[[UILabel alloc]init];
//    [_errorInfo setFont:[UIFont systemFontOfSize:15]];
//    _errorInfo.textColor=[UIColor colorWithHexString:@"#444444"];
//    _errorInfo.text=NSLocalizedString(@"yanzhengmacuowu_lg",nil);
//    [_backScroll addSubview:_errorInfo];
//    [_errorInfo mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(_errorLab.mas_centerY);
//        make.left.mas_equalTo(_errorLab.mas_right).offset(20*WSCALE);
//    }];
//    _errorInfo.hidden=YES;
    
    
    _nextBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setBackgroundImage:[UIImage imageNamed:@"ji"] forState:UIControlStateNormal];
    [_nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [_backScroll addSubview:_nextBtn];
    
    _nextBtn.frame=CGRectMake(SCREEN_WIDTH-48*WSCALE-102*WSCALE, SCREEN_HEIGHT-24*HSCALE-102*HSCALE, 102*WSCALE, 102*HSCALE);
    [_nextBtn setBackgroundImage:[UIImage imageNamed:@"notji"] forState:UIControlStateNormal];
    _nextBtn.userInteractionEnabled=NO;
    
    
    [_emailTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_emailTF2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

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
    BOOL isEmail = [[DataProcessing sharedManager]isValidateEmail:[NSString stringWithFormat:@"%@@%@",_emailTF.text,_emailTF2.text]];
    if (_emailTF.text.length>0 && _emailTF2.text.length>0 && isEmail) {
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"ji"] forState:UIControlStateNormal];
        _nextBtn.userInteractionEnabled=YES;
        _checkNameImgV.hidden=NO;
    }else{
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"notji"] forState:UIControlStateNormal];
        _nextBtn.userInteractionEnabled=NO;
        _checkNameImgV.hidden=YES;
    }

}










-(void)nextAction{
    NSString *email=[NSString stringWithFormat:@"%@@%@",_emailTF.text,_emailTF2.text];
    [DataProcessing sharedManager].email=email;
    [_emailTF resignFirstResponder];
    [_emailTF2 resignFirstResponder];
    CGFloat y=SCREEN_HEIGHT-24*HSCALE-102*HSCALE;
    _nextBtn.frame =CGRectMake(SCREEN_WIDTH-48*WSCALE-102*WSCALE, y, 102*WSCALE, 102*HSCALE);
    PasswordViewController *vc= [[PasswordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickTap{
    [_emailTF resignFirstResponder];
    [_emailTF2 resignFirstResponder];
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
