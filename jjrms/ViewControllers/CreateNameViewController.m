//
//  CreateNameViewController.m
//  jjrms
//
//  Created by user on 2016/12/7.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "CreateNameViewController.h"

@interface CreateNameViewController ()

@end

@implementation CreateNameViewController
{
    LoginBarView *_barView;
    UIScrollView *_backScroll;//背景scroll
    UILabel *_name;
    UITextField *_nameTextField;
    UIView *_lineone;
    UILabel *_name2;
    UITextField *_nameTextField2;
    UIView *_linetwo;
    UIImageView *_checkNameImgV;
    UIImageView *_checkPasswordImgV;
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
    __weak typeof(self) weakSelf = self;
    
    _backScroll=[[UIScrollView alloc]init];
    _backScroll.backgroundColor=[UIColor whiteColor];
    _backScroll.contentSize=CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+150);
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
    _barView.titleLab.text=NSLocalizedString(@"jiaoshenmemingzi_lg",nil);
    [_backScroll addSubview:_barView];
    
    
    _name=[[UILabel alloc]init];
    _name.text=NSLocalizedString(@"mingzi_lg",nil);
    _name.textColor=[UIColor colorWithHexString:@"#555555"];
    [_name setFont:[UIFont systemFontOfSize:15]];
    _name.textAlignment=NSTextAlignmentCenter;
    [_backScroll addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_barView.mas_bottom).offset(110*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
    }];
    
    _nameTextField=[[UITextField alloc]init];
    //_nameTextField.placeholder=NSLocalizedString(@"LoginNamePlaceholder_lg",nil);
    _nameTextField.textColor=[UIColor colorWithHexString:@"#555555"];
    _nameTextField.font=[UIFont systemFontOfSize:24];
    _nameTextField.adjustsFontSizeToFitWidth=YES;
    _nameTextField.delegate=self;
    //_nameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_backScroll addSubview:_nameTextField];
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(474*WSCALE);
        make.top.mas_equalTo(_name.mas_bottom).offset(35*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
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
    
    
    
    _name2=[[UILabel alloc]init];
    _name2.text=NSLocalizedString(@"xingming_lg",nil);
    _name2.textColor=[UIColor colorWithHexString:@"#555555"];
    [_name2 setFont:[UIFont systemFontOfSize:15]];
    _name2.textAlignment=NSTextAlignmentCenter;
    [_backScroll addSubview:_name2];
    [_name2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lineone.mas_bottom).offset(50*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
    }];
    
    
    _nameTextField2=[[UITextField alloc]init];
    //_passwordTextField.placeholder=NSLocalizedString(@"LoginPasswordPlaceholder_lg",nil);
    //_passwordTextField.secureTextEntry=YES;
    //_passwordTextField.clearsOnBeginEditing = YES;
    _nameTextField2.adjustsFontSizeToFitWidth=YES;
    _nameTextField2.font=[UIFont systemFontOfSize:23];
    _nameTextField2.textColor=[UIColor colorWithHexString:@"#555555"];
    _nameTextField2.delegate=self;
    [_backScroll addSubview:_nameTextField2];
    [_nameTextField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(474*WSCALE);
        make.left.mas_equalTo(50*WSCALE);
        make.top.mas_equalTo(_name2.mas_bottom).offset(28*HSCALE);
    }];
    
    _checkPasswordImgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zhengque"]];
    [_backScroll addSubview:_checkPasswordImgV];
    [_checkPasswordImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(38*WSCALE, 26*HSCALE));
        make.centerY.equalTo(_nameTextField2.mas_centerY);
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
        make.top.mas_equalTo(_nameTextField2.mas_bottom).offset(28*HSCALE);
    }];
    
    
    [_nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_nameTextField2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    _nextBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setBackgroundImage:[UIImage imageNamed:@"ji"] forState:UIControlStateNormal];
    [_nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [_backScroll addSubview:_nextBtn];
    
    _nextBtn.frame=CGRectMake(SCREEN_WIDTH-48*WSCALE-102*WSCALE, SCREEN_HEIGHT-24*HSCALE-102*HSCALE, 102*WSCALE, 102*HSCALE);
    [_nextBtn setBackgroundImage:[UIImage imageNamed:@"notji"] forState:UIControlStateNormal];
    _nextBtn.userInteractionEnabled=NO;
    
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
        _backScroll.contentOffset = CGPointMake(0, 150);
        
        CGFloat y=_linetwo.frame.origin.y + _linetwo.frame.size.height + 20;
        _nextBtn.frame =CGRectMake(SCREEN_WIDTH-48*WSCALE-102*WSCALE, y, 102*WSCALE, 102*HSCALE);
        
    }completion:^(BOOL finished) {
        //动画执行完毕后的操作
    }];
    
}

-(void)textFieldDidChange:(UITextField *)textField{
    if (_nameTextField.text.length>0 && _nameTextField2.text.length>0) {
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"ji"] forState:UIControlStateNormal];
        _nextBtn.userInteractionEnabled=YES;
    }else{
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"notji"] forState:UIControlStateNormal];
        _nextBtn.userInteractionEnabled=NO;
    }
    
    
    if (textField.text.length>0) {
        if (textField==_nameTextField) {
            _checkNameImgV.hidden=NO;
        }
        if (textField==_nameTextField2) {
            _checkPasswordImgV.hidden=NO;
        }
    }else{
        if (textField==_nameTextField) {
            _checkNameImgV.hidden=YES;
        }
        if (textField==_nameTextField2) {
            _checkPasswordImgV.hidden=YES;
        }
    }
}


-(void)backAC{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickTap{
    [_nameTextField resignFirstResponder];
    [_nameTextField2 resignFirstResponder];
}


-(void)nextAction{

    [DataProcessing sharedManager].family_name=_nameTextField.text;
    [DataProcessing sharedManager].last_name=_nameTextField2.text;
    
    [_nameTextField resignFirstResponder];
    [_nameTextField2 resignFirstResponder];
    CGFloat y=SCREEN_HEIGHT-24*HSCALE-102*HSCALE;
    _nextBtn.frame =CGRectMake(SCREEN_WIDTH-48*WSCALE-102*WSCALE, y, 102*WSCALE, 102*HSCALE);
    CreatTelViewController *vc = [[CreatTelViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

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
