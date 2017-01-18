//
//  Withdraw2ViewController.m
//  jjrms
//
//  Created by user on 2016/11/21.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "Withdraw2ViewController.h"
#import "QuerymoneyModel.h"
@interface Withdraw2ViewController ()

@end

@implementation Withdraw2ViewController
{
    UILabel *_tit;
    UIButton *_confirm;
    UIView *_line;
    
    UILabel *_detail;
    UILabel *_money;
    UITextField *_input;
    UIAlertView *_alert;
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
    _tit.text=NSLocalizedString(@"tixianjine_tit",nil);
    
    
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
    
    
    _detail=[[UILabel alloc]init];
    _detail.textColor=[UIColor colorWithHexString:@"#555555"];
    [_detail setFont:[UIFont systemFontOfSize:16]];
    _detail.textAlignment=NSTextAlignmentCenter;
    _detail.numberOfLines=0;
    [self.view addSubview:_detail];
    [_detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(196*2*HSCALE);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.left.mas_equalTo(50*WSCALE);
        make.right.mas_equalTo(-50*WSCALE);
    }];
    NSString *lang=[[NSUserDefaults standardUserDefaults]valueForKey:LANGUAGE];
    if ([lang isEqualToString:@"zh-Hans"] || [lang isEqualToString:@"zh-Hans-CN"]) {
        _detail.text=[NSString stringWithFormat:@"可提现到%@(%@)金额", self.model.pay_channel, self.model.pay_account];
    }else{
        _detail.text=[NSString stringWithFormat:@"Maximum Amount of Withdraw To %@(%@)金额", self.model.pay_channel, self.model.pay_account];
    }

    
    
    
    _money=[[UILabel alloc]init];
    _money.textColor=[UIColor colorWithHexString:@"#555555"];
    [_money setFont:[UIFont systemFontOfSize:16]];
    _money.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_money];
    [_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_detail.mas_bottom).offset(24*HSCALE);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
    }];
    
    
    _input=[[UITextField alloc]init];
    _input.backgroundColor=[UIColor colorWithHexString:@"#F0F0F0"];
    _input.placeholder=@"0";
    _input.textAlignment=NSTextAlignmentCenter;
    //_input.adjustsFontSizeToFitWidth=YES;
    _input.keyboardType = UIKeyboardTypeNumberPad;
    _input.font=[UIFont fontWithName:CUTI size:24];
    _input.textColor=[UIColor colorWithHexString:@"#F06464"];
    [self.view addSubview:_input];
    [_input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(150*2*WSCALE);
        make.height.mas_equalTo(100*HSCALE);
        make.top.mas_equalTo(_money.mas_bottom).offset(22*HSCALE);
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

    
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    dic=@{@"user_sn":[[NSUserDefaults standardUserDefaults] valueForKey:USER_SN]};
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"account/querymoney"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"account/querymoney" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        if (status==1){
            NSDictionary *info=[responseDic objectForKey:@"info"];
            NSArray *listArr=[info objectForKey:@"list"];
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            arr = [QuerymoneyModel objectArrayWithKeyValuesArray:listArr];
            
            for (int i=0; i<arr.count; i++) {
                
                QuerymoneyModel *model=arr[i];
                
                double availablemoney = model.availablemoney.doubleValue/100;
                
                if ([model.currency isEqualToString:self.type]){
                    _money.text=[NSString stringWithFormat:@"%@  %.0f",self.type, availablemoney];
                }

            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];

    
}

-(void)confirmAction{

        NSString *m=_input.text;
        NSNumber *moneyNSN=[[NSNumber alloc]initWithDouble:m.doubleValue*100];
        NSString *acid=self.model.id;
        NSDictionary *dic=[[NSDictionary alloc]init];
        if (acid) {
            dic=@{@"cash_account_id":acid,@"currency":self.type,@"money":moneyNSN};
        }
        NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
        NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"cashapproval/create" timeString:dateStr];
        [[httpManager sharedManager]httpWithURL:@"cashapproval/create" method:POST param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
            NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
            
            //提现成功
            if (status==1){

                NSString *msg=[responseDic objectForKey:@"msg"];
                _alert=[[UIAlertView alloc]initWithTitle:@"" message:msg delegate:self cancelButtonTitle:NSLocalizedString(@"queren",nil) otherButtonTitles:nil, nil];
                [_alert show];
                
            }else{
                NSString *msg=[responseDic objectForKey:@"msg"];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:self cancelButtonTitle:NSLocalizedString(@"queren",nil) otherButtonTitles:nil, nil];
                [alert show];
            }
            
        } failure:^(NSError *error) {
            
        }];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView == _alert) {
        if (buttonIndex==0) {
            
            [_input resignFirstResponder];

            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[WalletViewController class]]) {
                    WalletViewController *VC=(WalletViewController *)controller;
                    VC.isRloadAccount=YES;
                    [self.navigationController popToViewController:VC animated:YES];
                }
            }
        }
    }
    
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
