//
//  WalletViewController.m
//  jjrms
//
//  Created by user on 2016/11/18.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "WalletViewController.h"
#import "WithdrawViewController.h"
@interface WalletViewController ()

@end

static NSString *accountCell = @"accountCell";

@implementation WalletViewController
{
    BalanceView *_headerView;
    UIImageView *_iconTop;
    UIButton *_detail;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if (_isRloadList) {
        [self reloadList];
        _isRloadList=NO;
    }
    if (_isRloadAccount) {
        [_headerView reloadUI];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navBarView.backBut.hidden=NO;
    //self.navBarView.titleLab.text=NSLocalizedString(@"qianbao_tit",nil);
    
    __weak typeof(self) weakSelf = self;

    _detail=[UIButton buttonWithType:UIButtonTypeCustom];
    [_detail setTitle:NSLocalizedString(@"zhangdan_ac",nil) forState:UIControlStateNormal];
    [_detail addTarget:self action:@selector(zhangdanAction) forControlEvents:UIControlEventTouchUpInside];
    [_detail setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
    _detail.titleLabel.font=[UIFont systemFontOfSize:15];
    [_detail setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.view addSubview:_detail];
    [_detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-50*WSCALE);
        make.centerY.mas_equalTo(weakSelf.navBarView.backBut.mas_centerY);
    }];
    
    
    _iconTop=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zhangd"]];
    [self.view addSubview:_iconTop];
    [_iconTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25*WSCALE, 30*HSCALE));
        make.centerY.equalTo(_detail.mas_centerY);
        make.right.mas_equalTo(_detail.mas_left).offset(-12*WSCALE);
    }];

    
    [self initUI];
}

-(void)zhangdanAction{
    ChildAccountViewController *vc=[[ChildAccountViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)initUI{
    _headerView=[[BalanceView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 197*2*HSCALE + 140*HSCALE)];
    [_headerView.tixian1 addTarget:self action:@selector(tixianAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView.tixian2 addTarget:self action:@selector(tixianAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView.tixian3 addTarget:self action:@selector(tixianAction:) forControlEvents:UIControlEventTouchUpInside];
    _headerView.tixian1.tag=10001;
    _headerView.tixian2.tag=10002;
    _headerView.tixian3.tag=10003;

    
    self.accountArr=[[NSMutableArray alloc]init];
    
    self.accountTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    self.accountTableView.delegate=self;
    self.accountTableView.dataSource=self;
    self.accountTableView.tableHeaderView = _headerView;
    self.accountTableView.separatorStyle = NO;
    self.accountTableView.showsVerticalScrollIndicator=NO;
    self.accountTableView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:self.accountTableView];
    [self.accountTableView registerClass:[AcountTableViewCell class] forCellReuseIdentifier:accountCell];
    
    [self initData];

}

-(void)tixianAction:(UIButton *)but{
    WithdrawViewController *vc=[[WithdrawViewController alloc]init];
    switch (but.tag) {
        case 10001:
            vc.type=@"CNY";
            break;
        case 10002:
            vc.type=@"USD";
            break;
        case 10003:
            vc.type=@"JPY";
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)initData{
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    dic=@{@"page_size":@100,@"current_page":@1};
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"cashaccount/myaccountlist" timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"cashaccount/myaccountlist" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){
            
            NSDictionary *info=[responseDic objectForKey:@"info"];
            NSArray *listArr=[info objectForKey:@"list"];
            self.accountArr = [AccountsModel objectArrayWithKeyValuesArray:listArr];
            [self.accountTableView reloadData];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.accountArr.count+1;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView=[[UIView alloc]init];
    headView.backgroundColor=[UIColor whiteColor];
    UILabel *lab=[[UILabel alloc]init];
    lab.textColor=[UIColor colorWithHexString:@"#555555"];
    [lab setFont:[UIFont fontWithName:CUTI size:20]];
    lab.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
    }];

    
    if (section==0) {
        lab.text=NSLocalizedString(@"zhanghu_ac",nil);
    }
    
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 130*HSCALE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==self.accountArr.count) {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *lab=[[UILabel alloc]init];
        lab.textColor=[UIColor colorWithHexString:@"#555555"];
        [lab setFont:[UIFont systemFontOfSize:17]];
        lab.textAlignment=NSTextAlignmentCenter;
        lab.text=NSLocalizedString(@"tianjiazhanghu_ac",nil);
        [cell addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50*HSCALE);
            make.left.mas_equalTo(84*WSCALE);
        }];

        UIImageView *img=[[UIImageView alloc]init];
        img.image=[UIImage imageNamed:@"tianjia"];
        [cell addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(44*WSCALE, 44*HSCALE));
            make.centerY.mas_equalTo(lab.mas_centerY);
            make.right.mas_equalTo(-80*WSCALE);
        }];
        
        

        return cell;
    }else{
        AcountTableViewCell  *cell  = [self.accountTableView dequeueReusableCellWithIdentifier: accountCell];
        if (cell == nil) {
            cell = [[AcountTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:accountCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model=self.accountArr[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    return 130*HSCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==self.accountArr.count) {
        AddAccountViewController *vc=[[AddAccountViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        AddAccount2ViewController *vc=[[AddAccount2ViewController alloc]init];
        AccountsModel *model=self.accountArr[indexPath.row];
        vc.model=model;
        vc.whichShow=@"review";
        if ([model.pay_channel isEqualToString:@"AliPay"]) {
            vc.type=@"AliPay";
        }else{
            vc.type=@"PayPal";
        }
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}


#pragma 刷新list
-(void)reloadList{
    NSDictionary *dic=[[NSDictionary alloc]init];
    dic=@{@"page_size":@100,@"current_page":@1};
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"cashaccount/myaccountlist" timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"cashaccount/myaccountlist" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){
            
            NSDictionary *info=[responseDic objectForKey:@"info"];
            NSArray *listArr=[info objectForKey:@"list"];
            self.accountArr = [AccountsModel objectArrayWithKeyValuesArray:listArr];
            [self.accountTableView reloadData];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
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
