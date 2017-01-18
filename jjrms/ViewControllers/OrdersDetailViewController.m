//
//  OrdersDetailViewController.m
//  jjrms
//
//  Created by user on 2016/11/17.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "OrdersDetailViewController.h"

@interface OrdersDetailViewController ()

@end

@implementation OrdersDetailViewController
{
    UIButton *_querenBtn;
    UILabel *_address;
    UILabel *_ruzhu;
    UILabel *_tuifang;
    UILabel *_ruzhudate;
    UILabel *_tuifangdate;
    UILabel *_ruzhutime;
    UILabel *_tuifangtime;
    UILabel *_xiangqing;
    UILabel *_xiangqings;
    UILabel *_feiyong;
    UILabel *_feiyongs;
    UILabel *_tel;
    UILabel *_msg;
    UIButton *_telBtn;
    UIButton *_msgBtn;

    UIView *_line1;
    UIView *_line2;
    UIView *_line3;
    UIView *_line4;
    UIView *_line5;
    UIView *_line6;


}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navBarView.backBut.hidden=NO;
    self.navBarView.titleLab.text=_orderModel.ota_tenant_name;
    
    [self initUI];
}

-(void)initUI{
    __weak typeof(self) weakSelf = self;
    
    _address=[[UILabel alloc]init];
    _address.text=_orderModel.house_name;
    _address.numberOfLines=0;
    [_address setFont:[UIFont fontWithName:CUTI size:22]];
    _address.textColor=[UIColor colorWithHexString:@"555555"];
    [self.view addSubview:_address];
    [_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.navBarView.mas_bottom).offset(56*HSCALE);
        make.height.mas_equalTo(106*HSCALE);
        make.left.mas_equalTo(36*WSCALE);
        make.right.mas_equalTo(-46*WSCALE);
    }];
    
    
    _line1=[[UIView alloc]init];
    _line1.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [self.view addSubview:_line1];
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(580*WSCALE, 2*HSCALE));
        make.left.mas_equalTo(30*WSCALE);
        make.top.mas_equalTo(_address.mas_bottom).offset(50*HSCALE);
    }];
    
    
    _ruzhu=[[UILabel alloc]init];
    _ruzhu.text=NSLocalizedString(@"ruzhu_or",nil);
    [_ruzhu setFont:[UIFont systemFontOfSize:15]];
    _ruzhu.textColor=[UIColor colorWithHexString:@"777777"];
    [self.view addSubview:_ruzhu];
    [_ruzhu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line1.mas_bottom).offset(34*HSCALE);
        make.height.mas_equalTo(28*HSCALE);
        make.left.mas_equalTo(_line1.mas_left);
    }];
    
    
    _tuifang=[[UILabel alloc]init];
    _tuifang.text=NSLocalizedString(@"tuifang_or",nil);
    [_tuifang setFont:[UIFont systemFontOfSize:15]];
    _tuifang.textColor=[UIColor colorWithHexString:@"777777"];
    [self.view addSubview:_tuifang];
    [_tuifang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line1.mas_bottom).offset(34*HSCALE);
        make.height.mas_equalTo(28*HSCALE);
        make.left.mas_equalTo(352*WSCALE);
    }];
    
    
    
    _ruzhudate=[[UILabel alloc]init];
    _ruzhudate.text=@"";
    [_ruzhudate setFont:[UIFont systemFontOfSize:12]];
    _ruzhudate.textColor=[UIColor colorWithHexString:@"555555"];
    [self.view addSubview:_ruzhudate];
    [_ruzhudate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ruzhu.mas_bottom).offset(20*HSCALE);
        make.height.mas_equalTo(24*HSCALE);
        make.left.mas_equalTo(_line1.mas_left);
    }];
    
    
    _tuifangdate=[[UILabel alloc]init];
    _tuifangdate.text=@"";
    [_tuifangdate setFont:[UIFont systemFontOfSize:12]];
    _tuifangdate.textColor=[UIColor colorWithHexString:@"555555"];
    [self.view addSubview:_tuifangdate];
    [_tuifangdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ruzhu.mas_bottom).offset(20*HSCALE);
        make.height.mas_equalTo(24*HSCALE);
        make.left.mas_equalTo(_tuifang.mas_left);
    }];
    
    
    _ruzhutime=[[UILabel alloc]init];
    _ruzhutime.text=@"";
    [_ruzhutime setFont:[UIFont systemFontOfSize:17]];
    _ruzhutime.textColor=[UIColor colorWithHexString:@"555555"];
    [self.view addSubview:_ruzhutime];
    [_ruzhutime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ruzhudate.mas_bottom).offset(16*HSCALE);
        make.height.mas_equalTo(26*HSCALE);
        make.left.mas_equalTo(_line1.mas_left);
    }];
    
    
    _tuifangtime=[[UILabel alloc]init];
    _tuifangtime.text=@"";
    [_tuifangtime setFont:[UIFont systemFontOfSize:17]];
    _tuifangtime.textColor=[UIColor colorWithHexString:@"555555"];
    [self.view addSubview:_tuifangtime];
    [_tuifangtime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_tuifangdate.mas_bottom).offset(16*HSCALE);
        make.height.mas_equalTo(26*HSCALE);
        make.left.mas_equalTo(_tuifang.mas_left);
    }];
    
    
    //shu
    _line2=[[UIView alloc]init];
    _line2.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [self.view addSubview:_line2];
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(2*WSCALE, 142*HSCALE));
        make.left.mas_equalTo(320*WSCALE);
        make.top.mas_equalTo(_line1.mas_bottom).offset(20*HSCALE);
    }];
    
    
    _line3=[[UIView alloc]init];
    _line3.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [self.view addSubview:_line3];
    [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(580*WSCALE, 2*HSCALE));
        make.left.mas_equalTo(30*WSCALE);
        make.top.mas_equalTo(_line2.mas_bottom).offset(20*HSCALE);
    }];
    
    
    _xiangqing=[[UILabel alloc]init];
    _xiangqing.text=NSLocalizedString(@"xiangqing_or",nil);
    [_xiangqing setFont:[UIFont systemFontOfSize:15]];
    _xiangqing.textColor=[UIColor colorWithHexString:@"#999999"];
    [self.view addSubview:_xiangqing];
    [_xiangqing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line3.mas_bottom).offset(32*HSCALE);
        make.height.mas_equalTo(30*HSCALE);
        make.left.mas_equalTo(32*WSCALE);
    }];
    
    _xiangqings=[[UILabel alloc]init];
    _xiangqings.text=@"";
    [_xiangqings setFont:[UIFont fontWithName:CUTI size:17]];
    _xiangqings.textColor=[UIColor colorWithHexString:@"#555555"];
    [self.view addSubview:_xiangqings];
    [_xiangqings mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_xiangqing.mas_centerY);
        make.height.mas_equalTo(34*HSCALE);
        make.right.mas_equalTo(-32*WSCALE);
    }];
    
    
    _line4=[[UIView alloc]init];
    _line4.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [self.view addSubview:_line4];
    [_line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(580*WSCALE, 2*HSCALE));
        make.left.mas_equalTo(30*WSCALE);
        make.top.mas_equalTo(_line3.mas_bottom).offset(92*HSCALE);
    }];
    
    
    
    _feiyong=[[UILabel alloc]init];
    _feiyong.text=NSLocalizedString(@"yudingfeiyong_or",nil);
    [_feiyong setFont:[UIFont systemFontOfSize:15]];
    _feiyong.textColor=[UIColor colorWithHexString:@"#999999"];
    [self.view addSubview:_feiyong];
    [_feiyong mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line4.mas_bottom).offset(32*HSCALE);
        make.height.mas_equalTo(30*HSCALE);
        make.left.mas_equalTo(32*WSCALE);
    }];
    
    _feiyongs=[[UILabel alloc]init];
    _feiyongs.text=NSLocalizedString(@"yudingfeiyong_or",nil);
    [_feiyongs setFont:[UIFont fontWithName:CUTI size:17]];
    _feiyongs.textColor=[UIColor colorWithHexString:@"#555555"];
    [self.view addSubview:_feiyongs];
    [_feiyongs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_feiyong.mas_centerY);
        make.height.mas_equalTo(26*HSCALE);
        make.right.mas_equalTo(-32*WSCALE);
    }];
    
    
    _line5=[[UIView alloc]init];
    _line5.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [self.view addSubview:_line5];
    [_line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(580*WSCALE, 2*HSCALE));
        make.left.mas_equalTo(30*WSCALE);
        make.top.mas_equalTo(_line4.mas_bottom).offset(92*HSCALE);
    }];
    
    
    
    _tel=[[UILabel alloc]init];
    _tel.text=NSLocalizedString(@"yudingfeiyong_or",nil);
    [_tel setFont:[UIFont fontWithName:CUTI size:18]];
    _tel.textColor=[UIColor colorWithHexString:@"#555555"];
    [self.view addSubview:_tel];
    [_tel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line5.mas_bottom).offset(44*HSCALE);
        make.height.mas_equalTo(24*HSCALE);
        make.left.mas_equalTo(32*WSCALE);
    }];
    
    
    _telBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_telBtn setImage:[UIImage imageNamed:@"dianh"] forState:UIControlStateNormal];
    [_telBtn addTarget:self action:@selector(telActionOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_telBtn];
    [_telBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40*WSCALE, 40*HSCALE));
        make.right.mas_equalTo(-40*WSCALE);
        make.centerY.mas_equalTo(_tel.mas_centerY);
    }];
    
    
    _msg=[[UILabel alloc]init];
    _msg.text=NSLocalizedString(@"yudingfeiyong_or",nil);
    [_msg setFont:[UIFont systemFontOfSize:15]];
    _msg.textColor=[UIColor colorWithHexString:@"#555555"];
    [self.view addSubview:_msg];
    [_msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_tel.mas_bottom).offset(62*HSCALE);
        make.height.mas_equalTo(30*HSCALE);
        make.left.mas_equalTo(32*WSCALE);
    }];

    
    
    _msgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_msgBtn setImage:[UIImage imageNamed:@"youx"] forState:UIControlStateNormal];
    [self.view addSubview:_msgBtn];
    [_msgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40*WSCALE, 40*HSCALE));
        make.right.mas_equalTo(-40*WSCALE);
        make.centerY.mas_equalTo(_msg.mas_centerY);
    }];
    
    
    
    _querenBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_querenBtn setTitle:NSLocalizedString(@"querendingdan_or",nil) forState:UIControlStateNormal];
    [_querenBtn addTarget:self action:@selector(querenAction) forControlEvents:UIControlEventTouchUpInside];
    _querenBtn.backgroundColor=[UIColor colorWithHexString:@"#00A6A6"];
    //[_querenBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithHexString:@"#5aa6d8"]] forState:UIControlStateHighlighted];
    [_querenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _querenBtn.titleLabel.font=[UIFont fontWithName:CUTI size:19];
    [_querenBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.view addSubview:_querenBtn];
    [_querenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(640*WSCALE, 102*HSCALE));
        make.left.mas_equalTo(0*WSCALE);
        make.bottom.mas_equalTo(0);
    }];
    if (_showAcc==YES) {
        _querenBtn.hidden=NO;
    }else{
        _querenBtn.hidden=YES;
    }
    
    [self initData];
    
}

-(void)initData{
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    dic=@{@"order_sn":self.orderModel.order_sn};
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"order/detail"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"order/detail" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){
            
            NSDictionary *info=[responseDic objectForKey:@"info"];
            OrderDetailModel *model=[[OrderDetailModel alloc]init];
            model=[OrderDetailModel objectWithKeyValues:info];
            
            _ruzhutime.text=model.estimated_arrive_time;
            _tuifangtime.text=model.estimated_leave_time;
            _xiangqings.text=model.rent_overview_txt;
            _tel.text=model.ota_tenant_phone;
            _msg.text=model.ota_tenant_email;
            
            double money_dou=model.landlord_total_price.doubleValue/100;
            _feiyongs.text=[NSString stringWithFormat:@"%@ %.0f",model.price_unit,money_dou];
            
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"yyyy/MM/dd"];
            NSDate* date1 = [NSDate dateWithTimeIntervalSince1970:[model.start_time doubleValue]];
            NSString* dateString = [formatter stringFromDate:date1];
            _ruzhudate.text=[NSString stringWithFormat:@"%@",dateString];
            
            NSDate* date2 = [NSDate dateWithTimeIntervalSince1970:[model.end_time doubleValue]];
            NSString* dateString2 = [formatter stringFromDate:date2];
            _tuifangdate.text=[NSString stringWithFormat:@"%@",dateString2];

            
            
        }else{
            NSString *msg=[responseDic objectForKey:@"msg"];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:self cancelButtonTitle:NSLocalizedString(@"queren",nil) otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } failure:^(NSError *error) {
        
    }];

    
}

//确认订单
-(void)querenAction{
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    //OrderModel *model=[[OrderModel alloc]init];
    //model=self.orderArr[0];
    dic=@{@"order_sn":_orderModel.order_sn};
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"order/orderconfirm"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"order/orderconfirm" method:POST param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        
        if (status==1){
            
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[OrdersViewController class]]) {
                    OrdersViewController *VC=(OrdersViewController *)controller;
                    [self.navigationController popToViewController:VC animated:YES];
                    VC.isRefresh=YES;
                }
            }
             
        };
    
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)telActionOrder{
    NSLog(@"%@", _tel.text);
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", _tel.text]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
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
