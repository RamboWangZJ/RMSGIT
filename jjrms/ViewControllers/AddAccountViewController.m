//
//  AddAccountViewController.m
//  jjrms
//
//  Created by user on 16/10/20.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "AddAccountViewController.h"
#import "AccountViewController.h"
#import "AddAccount2ViewController.h"
@interface AddAccountViewController ()<UIAlertViewDelegate>

@end

@implementation AddAccountViewController
{
    
    
    UIButton *_paypal;
    UIButton *_alipay;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarView.titleLab.text=NSLocalizedString(@"xuanzetixian_tit",nil);
    self.view.backgroundColor=[UIColor whiteColor];
    self.navBarView.backBut.hidden=NO;
    self.navBarView.lineView.hidden=YES;
    [self initUI];
}

-(void)initUI{
    
    _paypal=[UIButton buttonWithType:UIButtonTypeCustom];
    [_paypal setTitle:@"paypal" forState:UIControlStateNormal];
    [_paypal addTarget:self action:@selector(querenAction:) forControlEvents:UIControlEventTouchUpInside];
    [_paypal setTitleColor:[UIColor colorWithHexString:@"#00A6A6"] forState:UIControlStateNormal];
    _paypal.titleLabel.font=[UIFont systemFontOfSize:18];
    [_paypal setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.view addSubview:_paypal];
    [_paypal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60*WSCALE);
        make.top.mas_equalTo(268*HSCALE);
    }];
    _paypal.tag=10001;
    
    
    _alipay=[UIButton buttonWithType:UIButtonTypeCustom];
    [_alipay setTitle:@"支付宝" forState:UIControlStateNormal];
    [_alipay addTarget:self action:@selector(querenAction:) forControlEvents:UIControlEventTouchUpInside];
    [_alipay setTitleColor:[UIColor colorWithHexString:@"#00A6A6"] forState:UIControlStateNormal];
    _alipay.titleLabel.font=[UIFont systemFontOfSize:18];
    [_alipay setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.view addSubview:_alipay];
    [_alipay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60*WSCALE);
        make.top.mas_equalTo(173*2*HSCALE);
    }];
    _alipay.tag=10002;

    

    
    
    /*
    //
    _checkV=[[UIView alloc]init];
    [self.view  addSubview:_checkV];
    [_checkV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(600*WSCALE, 98*HSCALE));
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(20*WSCALE);
    }];
    UITapGestureRecognizer *checkVTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkVTopTap)];
    [_checkV addGestureRecognizer:checkVTap];
    
    
    _checkBT=[UIButton buttonWithType:UIButtonTypeCustom];
    [_checkBT addTarget:self action:@selector(xialaAction:) forControlEvents:UIControlEventTouchUpInside];
    [_checkBT setImage:[UIImage imageNamed:@"xiala_TRA"] forState:UIControlStateNormal];
    [_checkBT setImage:[UIImage imageNamed:@"shangla_TRA"] forState:UIControlStateSelected];
    [_checkBT setSelected:NO];
    [_checkV addSubview:_checkBT];
    [_checkBT mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(CGSizeMake(32*WSCALE, 17*HSCALE));
        //make.right.mas_equalTo(-10*WSCALE);
        //make.top.mas_equalTo(44*HSCALE);
        make.size.mas_equalTo(CGSizeMake(60*WSCALE, 60*HSCALE));
        make.right.mas_equalTo(0*WSCALE);
        make.top.mas_equalTo(19*HSCALE);
    }];
    
    
    _checkLB=[[UILabel alloc]init];
    _checkLB.text=NSLocalizedString(@"shoukuanfangshi_ac",nil);
    _checkLB.textColor=[UIColor colorWithHexString:@"#aaaaaa"];
    _checkLB.font=[UIFont systemFontOfSize:16];
    _checkLB.textAlignment=NSTextAlignmentLeft;
    [_checkV addSubview:_checkLB];
    [_checkLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20*WSCALE);
        make.height.mas_equalTo(30*HSCALE);
        make.centerY.mas_equalTo(_checkV.mas_centerY);
    }];
    
    
    
    _typeImage=[[UIImageView alloc]init];
    [_checkV addSubview:_typeImage];
    [_typeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40*WSCALE, 40*HSCALE));
        make.left.mas_equalTo(30*WSCALE);
        make.centerY.mas_equalTo(_checkV.mas_centerY);
    }];
    
    _typeName=[[UILabel alloc]init];
    _typeName.textColor=[UIColor blackColor];
    _typeName.font=[UIFont systemFontOfSize:16];
    _typeName.textAlignment=NSTextAlignmentLeft;
    [_checkV addSubview:_typeName];
    [_typeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_checkV.mas_centerY);
        make.height.mas_equalTo(30*HSCALE);
        make.left.mas_equalTo(_typeImage.mas_right).offset(20*WSCALE);
    }];
    _typeImage.hidden=YES;
    _typeName.hidden=YES;
    
    
    
    

    //
    _zhanghuLB=[[UILabel alloc]init];
    _zhanghuLB.text=NSLocalizedString(@"zhanghuming_ac",nil);
    _zhanghuLB.textColor=[UIColor blackColor];
    _zhanghuLB.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:_zhanghuLB];
    [_zhanghuLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30*WSCALE);
        make.top.mas_equalTo(_line1.mas_bottom).offset(30*HSCALE);
    }];
    
    _zhanghaoLB=[[UILabel alloc]init];
    _zhanghaoLB.text=NSLocalizedString(@"zhanghao_ac",nil);
    _zhanghaoLB.textColor=[UIColor blackColor];
    _zhanghaoLB.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:_zhanghaoLB];
    [_zhanghaoLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30*WSCALE);
        make.top.mas_equalTo(_line2.mas_bottom).offset(30*HSCALE);
    }];
    [_zhanghaoLB setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];//

    
    _zhanghuTF=[[UITextField alloc]init];
    _zhanghuTF.placeholder=NSLocalizedString(@"qingshuruzhanghuming",nil);
    _zhanghuTF.textColor=[UIColor colorWithHexString:@"#343b47"];
    _zhanghuTF.font=[UIFont fontWithName:@"Times New Roman" size:15];
    _zhanghuTF.adjustsFontSizeToFitWidth=YES;
    [self.view addSubview:_zhanghuTF];
    [_zhanghuTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_zhanghuLB.mas_centerY);
        make.height.mas_equalTo(30*HSCALE);
        make.right.mas_equalTo(-30*WSCALE);
        make.leading.mas_equalTo(_zhanghuLB.mas_trailing).offset(30*WSCALE);
    }];
    
    _zhanghaoTF=[[UITextField alloc]init];
    _zhanghaoTF.placeholder=NSLocalizedString(@"qingshuruzhanghao",nil);
    _zhanghaoTF.textColor=[UIColor colorWithHexString:@"#343b47"];
    _zhanghaoTF.font=[UIFont fontWithName:@"Times New Roman" size:15];
    _zhanghaoTF.adjustsFontSizeToFitWidth=YES;
    [self.view addSubview:_zhanghaoTF];
    [_zhanghaoTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_zhanghaoLB.mas_centerY);
        make.height.mas_equalTo(30*HSCALE);
        make.right.mas_equalTo(-30*WSCALE);
        make.leading.mas_equalTo(_zhanghaoLB.mas_trailing).offset(30*WSCALE);
    }];
    
    


    
    
    
    
    
    //选择框
    _checkView=[[CheckTypeView alloc]init];
    _checkView.layer.borderWidth=0.4;
    _checkView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _checkView.layer.masksToBounds=YES;
    _checkView.layer.cornerRadius=6;
    [self.view  addSubview:_checkView];
    [_checkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(600*WSCALE, 198*HSCALE));
        make.top.mas_equalTo(_line1.mas_bottom).offset(1*HSCALE);
        make.left.mas_equalTo(20*WSCALE);
    }];
    _checkView.hidden=YES;
    UITapGestureRecognizer *paypalTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(paypalCheckTap)];
    [_checkView.paypalView addGestureRecognizer:paypalTap];
    UITapGestureRecognizer *zhifubaoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zhifubaoCheckTap)];
    [_checkView.zhifubaoView addGestureRecognizer:zhifubaoTap];
    
    */
    

}


-(void)querenAction:(UIButton *)btn{
    AddAccount2ViewController *vc=[[AddAccount2ViewController alloc]init];
    switch (btn.tag) {
        case 10001:
            vc.type=@"PayPal";
            break;
        case 10002:
            vc.type=@"AliPay";
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma 确认
-(void)querenAction{
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    
    dic=@{@"pay_account":_zhanghaoTF.text,@"pay_account_name":_zhanghuTF.text,@"pay_channel":_pay_channel};
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"cashaccount/create" timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"cashaccount/create" method:POST param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        //添加账户
        if (status==1){
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[AccountViewController class]]) {
                    AccountViewController *VC=(AccountViewController *)controller;
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView==_alert) {
        if (buttonIndex==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


#pragma 触摸空白
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_zhanghaoTF resignFirstResponder];
    [_zhanghuTF resignFirstResponder];
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
*/

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
