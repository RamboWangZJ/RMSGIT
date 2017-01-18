//
//  AccountGrayView.m
//  jjrms
//
//  Created by user on 16/10/21.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "AccountGrayView.h"

@implementation AccountGrayView
{
    UIView *_whiteView;
    
    UILabel *_tixianLB;
    
    UILabel *_zhanghuLB;
    //UILabel *_zhanghuNubLB;
    UIButton *_zhanghuNubBT;
    UIButton *_xiala;

    UILabel *_jineLB;
    UILabel *_ketixianLB;

    
    UITextField *_tixianTF;
    

    UIView *_lineViewHeng1;
    UIView *_lineViewHeng2;
    UIView *_lineViewHeng3;
    UIView *_lineViewHeng4;
    UIView *_lineViewShu;
    
    NSString *_id;

}

static NSString *AccCheckCell = @"AccCheckTableViewCell";

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
    
}

-(void)initView{
    __weak typeof(self) weakSelf = self;
    
    self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    
    _whiteView=[[UIView alloc]init];
    _whiteView.backgroundColor=[UIColor whiteColor];
    _whiteView.alpha=1;
    _whiteView.layer.masksToBounds=YES;
    _whiteView.layer.cornerRadius=8;
    [self addSubview:_whiteView];
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(580*WSCALE, 420*HSCALE));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
    }];
    
    UITapGestureRecognizer *whiteViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    // 设置触控对象
    [whiteViewTap setNumberOfTouchesRequired:1];
    // 设置轻拍的次数
    [whiteViewTap setNumberOfTapsRequired:1];
    [_whiteView addGestureRecognizer:whiteViewTap];
    [whiteViewTap setCancelsTouchesInView:NO];

    
    
    
    _tixianLB=[[UILabel alloc]init];
    _tixianLB.textAlignment=NSTextAlignmentCenter;
    _tixianLB.textColor=[UIColor colorWithHexString:@"#343b47"];
    _tixianLB.font=[UIFont systemFontOfSize:15];
    [_whiteView addSubview:_tixianLB];
    [_tixianLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40*HSCALE);
        make.top.mas_equalTo(22*HSCALE);
        make.centerX.mas_equalTo(_whiteView.mas_centerX);
        //make.width.mas_equalTo(50*WSCALE);
    }];_tixianLB.text=NSLocalizedString(@"tixian_ac",nil);
    
    
    _zhanghuLB=[[UILabel alloc]init];
    _zhanghuLB.textAlignment=NSTextAlignmentCenter;
    _zhanghuLB.textColor=[UIColor colorWithHexString:@"#666666"];
    _zhanghuLB.font=[UIFont systemFontOfSize:14];
    [_whiteView addSubview:_zhanghuLB];
    [_zhanghuLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40*HSCALE);
        make.top.mas_equalTo((22+88)*HSCALE);
        make.left.mas_equalTo(30*WSCALE);
    }];_zhanghuLB.text=NSLocalizedString(@"zhanghu_ac",nil);
    
    
    
    
    
    
    _zhanghuNubBT=[UIButton buttonWithType:UIButtonTypeCustom];
    [_zhanghuNubBT addTarget:self action:@selector(xialaButAction:) forControlEvents:UIControlEventTouchUpInside];
    [_zhanghuNubBT setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    _zhanghuNubBT.titleLabel.font=[UIFont systemFontOfSize:14];
    [_zhanghuNubBT setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [_whiteView addSubview:_zhanghuNubBT];
    [_zhanghuNubBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40*HSCALE);
        make.centerY.mas_equalTo(_zhanghuLB.mas_centerY);
        make.left.mas_equalTo(_zhanghuLB.mas_right).offset(20*WSCALE);
        make.right.mas_equalTo(-70*WSCALE);
    }];
    
  
    
    _xiala=[UIButton buttonWithType:UIButtonTypeCustom];
    [_xiala setBackgroundImage:[UIImage imageNamed:@"xiala_TRA"] forState:UIControlStateNormal];
    [_xiala addTarget:self action:@selector(xialaButAction:) forControlEvents:UIControlEventTouchUpInside];
    [_whiteView addSubview:_xiala];
    [_xiala mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(CGSizeMake(32*WSCALE, 17*HSCALE));
        //make.centerY.mas_equalTo(_zhanghuLB.mas_centerY);
        //make.right.mas_equalTo(-30*WSCALE);
        make.size.mas_equalTo(CGSizeMake(60*WSCALE, 60*HSCALE));
        make.centerY.mas_equalTo(_zhanghuLB.mas_centerY);
        make.right.mas_equalTo(-10*WSCALE);
    }];
    
    
    _jineLB=[[UILabel alloc]init];
    _jineLB.textAlignment=NSTextAlignmentCenter;
    _jineLB.textColor=[UIColor colorWithHexString:@"#666666"];
    _jineLB.font=[UIFont systemFontOfSize:14];
    [_whiteView addSubview:_jineLB];
    [_jineLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40*HSCALE);
        make.top.mas_equalTo((22+88+88)*HSCALE);
        make.left.mas_equalTo(30*WSCALE);
    }];
    
    
    _tixianTF=[[UITextField alloc]init];
    _tixianTF.placeholder=@"0.00";
    _tixianTF.textColor=[UIColor colorWithHexString:@"#666666"];
    _tixianTF.borderStyle = UITextBorderStyleRoundedRect;
    //_tixianTF.keyboardType = UIKeyboardTypeNumberPad;
    [_whiteView addSubview:_tixianTF];
    [_tixianTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(222*WSCALE, 60*HSCALE));
        make.centerY.mas_equalTo(_jineLB.mas_centerY);
        make.right.mas_equalTo(-30*WSCALE);
    }];
    
    
    _ketixianLB=[[UILabel alloc]init];
    _ketixianLB.textAlignment=NSTextAlignmentCenter;
    _ketixianLB.textColor=[UIColor colorWithHexString:@"#666666"];
    _ketixianLB.font=[UIFont systemFontOfSize:13];
    [_whiteView addSubview:_ketixianLB];
    [_ketixianLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40*HSCALE);
        make.top.mas_equalTo(_tixianTF.mas_bottom).offset(20*HSCALE);
        make.right.mas_equalTo(-30*WSCALE);
    }];
    
    
    
    //取消 保存
    self.cancel=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancel setTitle:NSLocalizedString(@"qvxiao",nil) forState:UIControlStateNormal];
    [self.cancel setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    self.cancel.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.cancel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_whiteView addSubview:self.cancel];
    [self.cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(580/2*WSCALE, 88*HSCALE));
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    self.save=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.save setTitle:NSLocalizedString(@"queren",nil) forState:UIControlStateNormal];
    [self.save setTitleColor:[UIColor colorWithHexString:@"#64b8f0"] forState:UIControlStateNormal];
    self.save.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.save setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_whiteView addSubview:self.save];
    [self.save mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(580/2*WSCALE, 88*HSCALE));
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
    _lineViewHeng1=[[UIView alloc]init];
    [_whiteView addSubview:_lineViewHeng1];
    _lineViewHeng1.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    [_lineViewHeng1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(560*WSCALE, 1*HSCALE));
        make.left.mas_equalTo(10*WSCALE);
        make.top.mas_equalTo(88*HSCALE);
    }];
    
    _lineViewHeng2=[[UIView alloc]init];
    [_whiteView addSubview:_lineViewHeng2];
    _lineViewHeng2.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    [_lineViewHeng2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(560*WSCALE, 1*HSCALE));
        make.left.mas_equalTo(10*WSCALE);
        make.top.mas_equalTo((88+88+1)*WSCALE);
    }];

    _lineViewHeng3=[[UIView alloc]init];
    [_whiteView addSubview:_lineViewHeng3];
    _lineViewHeng3.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    [_lineViewHeng3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(580*WSCALE, 1*HSCALE));
        make.left.mas_equalTo(10*WSCALE);
        make.top.mas_equalTo((88+88+2+150)*WSCALE);
    }];
    
    _lineViewShu=[[UIView alloc]init];
    [_whiteView addSubview:_lineViewShu];
    _lineViewShu.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    [_lineViewShu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1*WSCALE, 88*HSCALE));
        make.left.mas_equalTo(self.cancel.mas_right);
        make.bottom.mas_equalTo(0);
    }];
    
    
    self.checkArr=[[NSMutableArray alloc]init];

    
    self.checkTableView=[[UITableView alloc]initWithFrame:CGRectMake(20*WSCALE, 176*HSCALE, 540*WSCALE, 264*HSCALE) style:UITableViewStylePlain];
    self.checkTableView.delegate=self;
    self.checkTableView.dataSource=self;
    self.checkTableView.tableFooterView = [UIView new];
    self.checkTableView.showsVerticalScrollIndicator = NO;
    [_whiteView addSubview:self.checkTableView];
    [self.checkTableView registerClass:[AccCheckTableViewCell class] forCellReuseIdentifier:AccCheckCell];
    self.checkTableView.hidden=YES;
    
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    dic=@{@"page_size":@100,@"current_page":@1};
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"cashaccount/myaccountlist" timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"cashaccount/myaccountlist" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){
            
            NSDictionary *info=[responseDic objectForKey:@"info"];
            NSArray *listArr=[info objectForKey:@"list"];
            self.checkArr = [AccountsModel objectArrayWithKeyValuesArray:listArr];
            self.checkTableView.frame=CGRectMake(20*WSCALE, 176*HSCALE, 540*WSCALE, 264*HSCALE);
            [self.checkTableView reloadData];
            
        }else{
            self.checkTableView.frame=CGRectMake(20*WSCALE, 176*HSCALE, 540*WSCALE, 0*HSCALE);
        }
        
        
    } failure:^(NSError *error) {
        
    }];

}

#pragma 白色背景轻拍手势
-(void)tapAction:(UITapGestureRecognizer *)tap{
    NSLog(@"111");
    [_tixianTF resignFirstResponder];
}
#pragma 从主页传数据初始化单位，可提现余额
- (void)initUIDataWithUnit:(NSString *)unit Ketixian:(NSString *)ketixian{
    _jineLB.text=unit;
    _ketixianLB.text=ketixian;
}

#pragma 下拉but
-(void)xialaButAction:(UIButton *)but{
    self.checkTableView.hidden=NO;
}
#pragma 点击账户lb
-(void)numTaptapAction{
    self.checkTableView.hidden=NO;
}

#pragma 获取输入金额
- (double)getMoney{
    NSString *m=_tixianTF.text;
    return m.doubleValue*100;
}
#pragma 获取账户id
-(NSString *)getId{
    return _id;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.checkArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        AccCheckTableViewCell  *cell  = [self.checkTableView dequeueReusableCellWithIdentifier: AccCheckCell];
        if (cell == nil) {
            cell = [[AccCheckTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AccCheckCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model=self.checkArr[indexPath.row];
        return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    return 88*HSCALE;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AccountsModel *model=self.checkArr[indexPath.row];
    [_zhanghuNubBT setTitle:model.pay_account forState:UIControlStateNormal];
    _id=model.id;
    self.checkTableView.hidden=YES;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
