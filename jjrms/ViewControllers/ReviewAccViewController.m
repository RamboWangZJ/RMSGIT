//
//  ReviewAccViewController.m
//  jjrms
//
//  Created by user on 16/10/21.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "ReviewAccViewController.h"
#import "AccountViewController.h"
@interface ReviewAccViewController ()

@end

@implementation ReviewAccViewController
{

    
    UILabel *_zhanghuLB;
    UILabel *_zhanghaoLB;
    UITextField *_zhanghuTF;
    UITextField *_zhanghaoTF;
    UIButton *_querenBT;
    
    UIView *_line1;
    UIView *_line2;
    UIView *_line3;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBarView.titleLab.text=NSLocalizedString(@"xiugaizhanghu_ac",nil);
    self.view.backgroundColor=[UIColor whiteColor];
    [self initUI];
}

-(void)initUI{
    __weak typeof(self) weakSelf = self;
    
    
    _line1=[[UIView alloc]init];
    [self.view addSubview:_line1];
    _line1.backgroundColor=[UIColor colorWithHexString:@"#dddddd"];
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(600*WSCALE, 1*HSCALE));
        make.left.mas_equalTo(20*WSCALE);
        make.top.mas_equalTo(98*HSCALE+64);
    }];
    
    _line2=[[UIView alloc]init];
    [self.view addSubview:_line2];
    _line2.backgroundColor=[UIColor colorWithHexString:@"#dddddd"];
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(600*WSCALE, 1*HSCALE));
        make.left.mas_equalTo(20*WSCALE);
        make.top.mas_equalTo(197*HSCALE+64);
    }];
    
    
    

    


    //
    _zhanghuLB=[[UILabel alloc]init];
    _zhanghuLB.text=NSLocalizedString(@"zhanghuming_ac",nil);
    _zhanghuLB.textColor=[UIColor blackColor];
    _zhanghuLB.font=[UIFont systemFontOfSize:15];
    _zhanghuLB.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:_zhanghuLB];
    [_zhanghuLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30*WSCALE);
        make.top.mas_equalTo(30*HSCALE + 64);
    }];
    
    _zhanghaoLB=[[UILabel alloc]init];
    _zhanghaoLB.text=NSLocalizedString(@"zhanghao_ac",nil);
    _zhanghaoLB.font=[UIFont systemFontOfSize:15];
    _zhanghaoLB.textColor=[UIColor blackColor];
    _zhanghaoLB.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:_zhanghaoLB];
    [_zhanghaoLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30*WSCALE);
        make.top.mas_equalTo(_line1.mas_bottom).offset(30*HSCALE);
    }];
    [_zhanghaoLB setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];//

    
    
    _zhanghuTF=[[UITextField alloc]init];
    //_zhanghuTF.placeholder=NSLocalizedString(@"qingshuruzhanghuming",nil);
    _zhanghuTF.text=self.model.pay_account_name;
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
    //_zhanghaoTF.placeholder=NSLocalizedString(@"qingshuruzhanghao",nil);
    _zhanghaoTF.text=self.model.pay_account;
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
    
    
    /*
    NSString *lang=[[NSUserDefaults standardUserDefaults]valueForKey:LANGUAGE];

    //
    _zhanghuLB=[[UILabel alloc]init];
    _zhanghuLB.text=NSLocalizedString(@"zhanghuming_ac",nil);
    _zhanghuLB.textColor=[UIColor blackColor];
    if (iPhone5) {
        _zhanghuLB.font=[UIFont systemFontOfSize:14];
    }else{
        _zhanghuLB.font=[UIFont systemFontOfSize:15];
    }
    _zhanghuLB.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_zhanghuLB];
    [_zhanghuLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30*WSCALE);
        make.height.mas_equalTo(38*HSCALE);
        make.top.mas_equalTo(30*HSCALE + 64);
        if ([lang isEqualToString:@"en"]) {
            make.width.mas_equalTo(200*WSCALE);
        }else{
            make.width.mas_equalTo(110*WSCALE);
        }
    }];
    
    _zhanghaoLB=[[UILabel alloc]init];
    _zhanghaoLB.text=NSLocalizedString(@"zhanghao_ac",nil);
    _zhanghaoLB.textColor=[UIColor blackColor];
    if (iPhone5) {
        _zhanghaoLB.font=[UIFont systemFontOfSize:14];
    }else{
        _zhanghaoLB.font=[UIFont systemFontOfSize:15];
    }
    _zhanghaoLB.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_zhanghaoLB];
    [_zhanghaoLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30*WSCALE);
        make.height.mas_equalTo(38*HSCALE);
        make.top.mas_equalTo(_line1.mas_bottom).offset(30*HSCALE);
    }];
    
    
    _zhanghuTF=[[UITextField alloc]init];
    //_zhanghuTF.placeholder=NSLocalizedString(@"qingshuruzhanghuming",nil);
    _zhanghuTF.text=self.model.pay_account_name;
    _zhanghuTF.textColor=[UIColor colorWithHexString:@"#343b47"];
    _zhanghuTF.font=[UIFont fontWithName:@"Times New Roman" size:15];
    _zhanghuTF.adjustsFontSizeToFitWidth=YES;
    [self.view addSubview:_zhanghuTF];
    [_zhanghuTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_zhanghuLB.mas_centerY);
        make.height.mas_equalTo(30*HSCALE);
        make.right.mas_equalTo(-30*WSCALE);
        if ([lang isEqualToString:@"en"]) {
            make.left.mas_equalTo(240*WSCALE);
        }else{
            make.left.mas_equalTo(140*WSCALE);
        }
    }];
    
    _zhanghaoTF=[[UITextField alloc]init];
    //_zhanghaoTF.placeholder=NSLocalizedString(@"qingshuruzhanghao",nil);
    _zhanghaoTF.text=self.model.pay_account;
    _zhanghaoTF.textColor=[UIColor colorWithHexString:@"#343b47"];
    _zhanghaoTF.font=[UIFont fontWithName:@"Times New Roman" size:15];
    _zhanghaoTF.adjustsFontSizeToFitWidth=YES;
    [self.view addSubview:_zhanghaoTF];
    [_zhanghaoTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_zhanghaoLB.mas_centerY);
        make.height.mas_equalTo(30*HSCALE);
        make.right.mas_equalTo(-30*WSCALE);
        if ([lang isEqualToString:@"en"]) {
            make.left.mas_equalTo(255*WSCALE);
        }else{
            make.left.mas_equalTo(140*WSCALE);
        }
    }];
    */


    
    _querenBT=[UIButton buttonWithType:UIButtonTypeCustom];
    [_querenBT setTitle:NSLocalizedString(@"queren",nil) forState:UIControlStateNormal];
    [_querenBT addTarget:self action:@selector(querenAction) forControlEvents:UIControlEventTouchUpInside];
    _querenBT.backgroundColor=[UIColor colorWithHexString:@"#64b8f0"];
    [_querenBT setBackgroundImage:[self imageWithColor:[UIColor colorWithHexString:@"#5aa6d8"]] forState:UIControlStateHighlighted];
    [_querenBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _querenBT.titleLabel.font=[UIFont systemFontOfSize:18];
    [_querenBT setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    _querenBT.layer.masksToBounds=YES;
    _querenBT.layer.cornerRadius=6;
    [self.view addSubview:_querenBT];
    [_querenBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(580*WSCALE, 80*HSCALE));
        make.centerX.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(257*HSCALE+64);
    }];
}

#pragma 确认
-(void)querenAction{
    
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    
    dic=@{@"pay_account":_zhanghaoTF.text,@"pay_account_name":_zhanghuTF.text,@"pay_channel":_model.pay_channel,@"id":_model.id};
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"cashaccount/update" timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"cashaccount/update" method:POST param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
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
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
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
