//
//  FeedbackViewController.m
//  jjrms
//
//  Created by user on 16/10/25.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController
{
    UIView *_backView;
    UITextView *_inputTV;

    UILabel *_beizhu;
    
    UILabel *_telLB;
    UITextField *_telTF;
    
    UIButton *_querenBT;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBarView.titleLab.text=NSLocalizedString(@"yijian_my",nil);
    self.view.backgroundColor=[UIColor colorWithHexString:@"#EEEEEE"];
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //状态栏
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor colorWithHexString:@"#343b47"];
    }
}


-(void)initUI{
    
    __weak typeof(self) weakSelf = self;

    
    _backView=[[UIView alloc]init];
    [self.view addSubview:_backView];
    _backView.backgroundColor=[UIColor whiteColor];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(640*WSCALE, 380*HSCALE));
        make.left.mas_equalTo(0*WSCALE);
        make.top.mas_equalTo(64);
    }];
    
    
    _inputTV=[[UITextView alloc]init];
    _inputTV.layer.cornerRadius = 4;
    _inputTV.layer.masksToBounds = YES;
    _inputTV.layer.borderWidth = 1;
    _inputTV.font = [UIFont systemFontOfSize:14];
    _inputTV.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
    _inputTV.textColor=[UIColor colorWithHexString:@"#666666"];
    _inputTV.font=[UIFont fontWithName:@"Times New Roman" size:15];
    [_backView addSubview:_inputTV];
    [_inputTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(242*HSCALE);
        make.top.mas_equalTo(26*HSCALE);
        make.width.mas_equalTo(586*WSCALE);
        make.left.mas_equalTo(30*WSCALE);
    }];
    
    
    _beizhu=[[UILabel alloc]init];
    _beizhu.backgroundColor=[UIColor whiteColor];
    _beizhu.textColor=[UIColor colorWithHexString:@"#AAAAAA"];
    _beizhu.text=@"注：意见反馈不处理业务问题；业务相关问题请拨打客服电话1111111";
    _beizhu.textColor=[UIColor colorWithHexString:@"#999999"];
    _beizhu.font=[UIFont systemFontOfSize:13];
    _beizhu.numberOfLines=0;
    [_backView addSubview:_beizhu];
    [_beizhu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(32*WSCALE);
        make.height.mas_equalTo(80*HSCALE);
        make.top.mas_equalTo(_inputTV.mas_bottom).offset(20*HSCALE);
        make.right.mas_equalTo(-32*WSCALE);
    }];
    
    
    
    _telLB=[[UILabel alloc]init];
    _telLB.backgroundColor=[UIColor whiteColor];
    _telLB.text=NSLocalizedString(@"xianxifangshi_my",nil);
    _telLB.textColor=[UIColor colorWithHexString:@"#999999"];
    _telLB.font=[UIFont systemFontOfSize:13];
    _telLB.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:_telLB];
    [_telLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0*WSCALE);
        make.height.mas_equalTo(88*HSCALE);
        make.top.mas_equalTo(_backView.mas_bottom).offset(30*HSCALE);
        make.width.mas_equalTo(84*2*WSCALE);
    }];

    
    
    _telTF=[[UITextField alloc]init];
    _telTF.backgroundColor=[UIColor whiteColor];
    _telTF.textColor=[UIColor colorWithHexString:@"#343b47"];
    _telTF.keyboardType = UIKeyboardTypeNumberPad;
    _telTF.font=[UIFont fontWithName:@"Times New Roman" size:15];
    //_telTF.adjustsFontSizeToFitWidth=YES;
    [self.view addSubview:_telTF];
    [_telTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_telLB.mas_centerY);
        make.height.mas_equalTo(88*HSCALE);
        make.left.mas_equalTo(84*2*WSCALE);
        make.right.mas_equalTo(0*WSCALE);
    }];
    
 
    _querenBT=[UIButton buttonWithType:UIButtonTypeCustom];
    [_querenBT setTitle:@"提交" forState:UIControlStateNormal];
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
        make.top.mas_equalTo(676*HSCALE);
    }];

    
}


-(void)querenAction{
    
    NSDictionary *dic=@{@"content":_inputTV.text,@"phone":_telTF.text};
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"feedback/create" timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"feedback/create" method:POST param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        if (status==1){
            NSString *msg=[responseDic objectForKey:@"msg"];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } failure:^(NSError *error) {
        
        
    }];

}

#pragma 触摸空白
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_inputTV resignFirstResponder];
    [_telTF resignFirstResponder];
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
