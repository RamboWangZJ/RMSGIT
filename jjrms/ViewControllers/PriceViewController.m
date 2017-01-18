//
//  PriceViewController.m
//  jjrms
//
//  Created by user on 2016/11/23.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "PriceViewController.h"

@interface PriceViewController ()

@end

@implementation PriceViewController
{
    UILabel *_tit;
    UIButton *_confirm;
    UIView *_line;
    
    UILabel *_priceDetail;
    UITextField *_input;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navBarView.backBut.hidden=NO;
    
    [self initUI];

}

-(void)initUI{
    
    __weak typeof(self) weakSelf = self;
    
    _tit=[[UILabel alloc]init];
    _tit.textColor=[UIColor colorWithHexString:@"#555555"];
    [_tit setFont:[UIFont fontWithName:CUTI size:16]];
    _tit.textAlignment=NSTextAlignmentCenter;
    [self.navBarView addSubview:_tit];
    [_tit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.navBarView.backBut.mas_centerY);
        make.centerX.mas_equalTo(weakSelf.navBarView.mas_centerX);
    }];
    _tit.text=NSLocalizedString(@"bianjijiage_ca",nil);
    
    
    _line=[[UIView alloc]init];
    [self.navBarView addSubview:_line];
    _line.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 2*HSCALE));
        make.left.mas_equalTo(0*WSCALE);
        make.top.mas_equalTo(64);
    }];
    
    _confirm=[UIButton buttonWithType:UIButtonTypeCustom];
    [_confirm setTitle:NSLocalizedString(@"queren",nil) forState:UIControlStateNormal];
    _confirm.titleLabel.font=[UIFont systemFontOfSize:15];
    [_confirm addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [_confirm setTitleColor:[UIColor colorWithHexString:@"#00A6A6"] forState:UIControlStateNormal];
    [_confirm setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.navBarView addSubview:_confirm];
    [_confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-50*WSCALE);
        make.centerY.mas_equalTo(_tit.mas_centerY);
    }];
    _confirm.userInteractionEnabled=NO;
    _confirm.alpha=0.3;

    
    
    _dateLab=[[UILabel alloc]init];
    _dateLab.textColor=[UIColor colorWithHexString:@"#555555"];
    [_dateLab setFont:[UIFont systemFontOfSize:16]];
    _dateLab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_dateLab];
    [_dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(196*2*HSCALE);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
    }];
    _dateLab.text=_datetext;
    //_dateLab.text=[NSString stringWithFormat:@"可提现到%@(%@)金额", self.model.pay_channel, self.model.pay_account];
    
    
    
    _priceDetail=[[UILabel alloc]init];
    _priceDetail.text=NSLocalizedString(@"meiwanjiage_ca",nil);
    _priceDetail.textColor=[UIColor colorWithHexString:@"#555555"];
    [_priceDetail setFont:[UIFont systemFontOfSize:16]];
    _priceDetail.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_priceDetail];
    [_priceDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_dateLab.mas_bottom).offset(22*HSCALE);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
    }];
    
    
    _input=[[UITextField alloc]init];
    _input.backgroundColor=[UIColor colorWithHexString:@"#F0F0F0"];
    _input.placeholder=@"0";
    _input.textAlignment=NSTextAlignmentCenter;
    _input.keyboardType = UIKeyboardTypeNumberPad;
    _input.font=[UIFont fontWithName:CUTI size:24];
    _input.textColor=[UIColor colorWithHexString:@"#F06464"];
    [self.view addSubview:_input];
    [_input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(150*2*WSCALE);
        make.height.mas_equalTo(100*HSCALE);
        make.top.mas_equalTo(_priceDetail.mas_bottom).offset(22*HSCALE);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
    }];
    
    _input.leftViewMode=UITextFieldViewModeAlways;
    _input.rightViewMode=UITextFieldViewModeAlways;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40*WSCALE, 100*HSCALE)];
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake((216-40)*WSCALE, 0, 40*WSCALE, 100*HSCALE)];
    view.backgroundColor=[UIColor colorWithHexString:@"#F0F0F0"];
    view2.backgroundColor=[UIColor colorWithHexString:@"#F0F0F0"];
    _input.leftView=view;
    _input.rightView=view2;
    
    [_input addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}


-(void)confirmAction{
    self.returnTextBlock(_input.text);
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)returnCALText:(returnCALTextBlock)textBlock
{
    self.returnTextBlock = textBlock;
}



-(void)textFieldDidChange:(UITextField *)textField{
    if (textField.text.length>0) {
        _confirm.userInteractionEnabled=YES;;
        _confirm.alpha=1;
    }else{
        _confirm.userInteractionEnabled=NO;;
        _confirm.alpha=0.3;
    }
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_input resignFirstResponder];
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
