//
//  ForgetSMSViewController.m
//  jjrms
//
//  Created by user on 2016/12/8.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "ForgetSMSViewController.h"

@interface ForgetSMSViewController ()

@end

@implementation ForgetSMSViewController
{
    UIScrollView *_backScroll;
    LoginBarView *_barView;
    UILabel *_infoLab;
    UILabel *_yanzhengma;
    UITextField *_yanzhengTF;
    UIButton *_yanzhengmaBtn;
    UIButton *_nextBtn;
    
    UIView *_lineone;
    UIView *_lineshu;
    
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
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        
    }];
    UITapGestureRecognizer *whiteViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap)];
    [_backScroll addGestureRecognizer:whiteViewTap];
    
    
    
    _barView=[[LoginBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 256*HSCALE)];
    [_barView.backBut addTarget:self action:@selector(backAC) forControlEvents:UIControlEventTouchUpInside];
    _barView.titleLab.text=NSLocalizedString(@"shuruyanzhengma_lg",nil);
    [_backScroll addSubview:_barView];
    
    
    
    _infoLab=[[UILabel alloc]init];
    _infoLab.textAlignment=NSTextAlignmentLeft;
    _infoLab.lineBreakMode = NSLineBreakByCharWrapping;// Wrap at character boundaries
    [_infoLab setFont:[UIFont systemFontOfSize:20]];
    _infoLab.textColor=[UIColor colorWithHexString:@"#555555"];
    NSString *lang=[[NSUserDefaults standardUserDefaults]valueForKey:LANGUAGE];
    if ([lang isEqualToString:@"zh-Hans"] || [lang isEqualToString:@"zh-Hans-CN"]) {
        _infoLab.text=[NSString stringWithFormat:@"我们向%@发送了一个验证码。请在下面输入验证码。", self.telStr];
    }else{
        _infoLab.text=[NSString stringWithFormat:@"We send a code to %@.Enter the code in that message.", self.telStr];
    }
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
    
    
    /*
    _yanzhengma=[[UILabel alloc]init];
    [_yanzhengma setFont:[UIFont systemFontOfSize:15]];
    _yanzhengma.textColor=[UIColor colorWithHexString:@"#555555"];
    _yanzhengma.text=NSLocalizedString(@"siweiyanzhengma_lg",nil);
    [_backScroll addSubview:_yanzhengma];
    [_yanzhengma mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_infoLab.mas_bottom).offset(110*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
        make.right.mas_equalTo(-50*WSCALE);
    }];
    */
    
    _yanzhengTF=[[UITextField alloc]init];
    _yanzhengTF.placeholder=NSLocalizedString(@"siweiyanzhengma_lg",nil);
    _yanzhengTF.textColor=[UIColor colorWithHexString:@"#555555"];
    _yanzhengTF.font=[UIFont systemFontOfSize:24];
    _yanzhengTF.adjustsFontSizeToFitWidth=YES;
    _yanzhengTF.delegate=self;
    _yanzhengTF.keyboardType = UIKeyboardTypeNumberPad;
    [_backScroll addSubview:_yanzhengTF];
    [_yanzhengTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(244*WSCALE);
        make.left.mas_equalTo(50*WSCALE);
        make.top.mas_equalTo(_infoLab.mas_bottom).offset(110*WSCALE);
    }];
    
    
    
    _yanzhengmaBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [_yanzhengmaBtn setTitle:NSLocalizedString(@"fasongyanzhengma_lg",nil) forState:UIControlStateNormal];
    [_yanzhengmaBtn addTarget:self action:@selector(fasongYanzhengma) forControlEvents:UIControlEventTouchUpInside];
    [_yanzhengmaBtn setTitleColor:[UIColor colorWithHexString:@"#00A6A6"] forState:UIControlStateNormal];
    _yanzhengmaBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    [_yanzhengmaBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_backScroll addSubview:_yanzhengmaBtn];
    [_yanzhengmaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_yanzhengTF.mas_right).offset(20*WSCALE);
        make.centerY.mas_equalTo(_yanzhengTF.mas_centerY);
        make.right.mas_equalTo(-60*WSCALE);
    }];
    
    
    
    _lineone=[[UIView alloc]init];
    _lineone.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [_backScroll addSubview:_lineone];
    [_lineone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(540*WSCALE, 2*HSCALE));
        make.left.mas_equalTo(50*WSCALE);
        make.top.mas_equalTo(_yanzhengmaBtn.mas_bottom).offset(28*HSCALE);
    }];
    
    _lineshu=[[UIView alloc]init];
    _lineshu.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [_backScroll addSubview:_lineshu];
    [_lineshu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(2*HSCALE, 50*HSCALE));
        make.left.mas_equalTo(_yanzhengTF.mas_right).offset(10*WSCALE);
        make.centerY.mas_equalTo(_yanzhengTF.mas_centerY);
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
    _errorInfo.numberOfLines=0;
    _errorInfo.textAlignment=NSTextAlignmentLeft;
    [_errorInfo setFont:[UIFont systemFontOfSize:15]];
    _errorInfo.textColor=[UIColor colorWithHexString:@"#444444"];
    _errorInfo.text=NSLocalizedString(@"yanzhengmacuowu_lg",nil);
    [_backScroll addSubview:_errorInfo];
    [_errorInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lineone.mas_bottom).offset(50*HSCALE);
        make.left.mas_equalTo(_errorLab.mas_right).offset(20*WSCALE);
        make.right.mas_equalTo(_nextBtn.mas_left).offset(-20*WSCALE);

    }];
    _errorInfo.hidden=YES;
    
    
    [_yanzhengTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    //[self fasongYanzhengma];
    [self zidongyangzheng];
    
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
    if (_yanzhengTF.text.length==4) {
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"ji"] forState:UIControlStateNormal];
        _nextBtn.userInteractionEnabled=YES;
    }else{
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"notji"] forState:UIControlStateNormal];
        _nextBtn.userInteractionEnabled=NO;
    }
}


-(void)zidongyangzheng{
    __block NSInteger time = 59; //倒计时时间
    
    if ([[NSUserDefaults standardUserDefaults]integerForKey:FORGETSECOND]==0) {
        time = 59;
    }else{
        time = [[NSUserDefaults standardUserDefaults]integerForKey:FORGETSECOND];
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        [[NSUserDefaults standardUserDefaults]setInteger:time forKey:FORGETSECOND];
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:FORGETSECOND];
                
                //结束 设置按钮的样式
                [_yanzhengmaBtn setTitle:NSLocalizedString(@"zaicifasongyanzhengma_lg",nil) forState:UIControlStateNormal];
                [_yanzhengmaBtn setTitleColor:[UIColor colorWithHexString:@"#00A6A6"] forState:UIControlStateNormal];
                _yanzhengmaBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [_yanzhengmaBtn setTitle:[NSString stringWithFormat:@"(%.2ds)", seconds] forState:UIControlStateNormal];
                [_yanzhengmaBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                _yanzhengmaBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);

}


-(void)fasongYanzhengma{
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    dic=@{@"country_code":_contrycode,@"mobile":_telStr,@"use_case":@30};
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"util/sendsms"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"util/sendsms" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){
            
            
        }else{
            _errorLab.hidden=NO;
            _errorInfo.hidden=NO;
            NSString *msg=[responseDic objectForKey:@"msg"];
            _errorInfo.text=msg;
            [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(changeText) userInfo:nil repeats:NO];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    __block NSInteger time = 59; //倒计时时间
    
    if ([[NSUserDefaults standardUserDefaults]integerForKey:FORGETSECOND]==0) {
        time = 59;
    }else{
        time = [[NSUserDefaults standardUserDefaults]integerForKey:FORGETSECOND];
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        [[NSUserDefaults standardUserDefaults]setInteger:time forKey:FORGETSECOND];

        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:FORGETSECOND];

                //结束 设置按钮的样式
                [_yanzhengmaBtn setTitle:NSLocalizedString(@"zaicifasongyanzhengma_lg",nil) forState:UIControlStateNormal];
                [_yanzhengmaBtn setTitleColor:[UIColor colorWithHexString:@"#00A6A6"] forState:UIControlStateNormal];
                _yanzhengmaBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [_yanzhengmaBtn setTitle:[NSString stringWithFormat:@"(%.2ds)", seconds] forState:UIControlStateNormal];
                [_yanzhengmaBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                _yanzhengmaBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}


//短息校验

-(void)nextAction{
    NSDictionary *dic=[[NSDictionary alloc]init];
    dic=@{@"country_code":_contrycode,@"mobile":_telStr,@"use_case":@30,@"sms_code":_yanzhengTF.text};
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"util/smsverify"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"util/smsverify" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){
            [DataProcessing sharedManager].sms_code=_yanzhengTF.text;
            
            [_yanzhengTF resignFirstResponder];
            CGFloat y=SCREEN_HEIGHT-24*HSCALE-102*HSCALE;
            _nextBtn.frame =CGRectMake(SCREEN_WIDTH-48*WSCALE-102*WSCALE, y, 102*WSCALE, 102*HSCALE);
            
            ForgetSetPasswordViewController *vc=[[ForgetSetPasswordViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            _errorLab.hidden=NO;
            _errorInfo.hidden=NO;
            _errorInfo.text=NSLocalizedString(@"yanzhengmacuowu_lg",nil);
            [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(changeText) userInfo:nil repeats:NO];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)changeText{
    _errorLab.hidden=YES;
    _errorInfo.hidden=YES;
}

-(void)clickTap{
    [_yanzhengTF resignFirstResponder];
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
