//
//  AccountViewController.m
//  jjrms
//
//  Created by user on 16/9/23.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountListViewController.h"
#import "AcountTableViewCell.h"
#import "AccountGrayView.h"
#import "QuerymoneyModel.h"
@interface AccountViewController ()

@end

@implementation AccountViewController
{
    AccountGrayView *_grayView;
    BalanceView *_headerView;
    NSString *_currency;
}
static NSString *accountCell = @"accountCell";

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if (_isRloadList) {
        [self reloadList];
        _isRloadList=NO;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarView.titleLab.text=NSLocalizedString(@"zhanghu_ho",nil);
    [self initUI];
}

-(void)initUI{

    
    _currency=@"";
    
    [self.navBarView.rightBut setTitle:NSLocalizedString(@"zhangdan_ac",nil) forState:UIControlStateNormal];
    [self.navBarView.rightBut addTarget:self action:@selector(accountList) forControlEvents:UIControlEventTouchUpInside];
    
    _headerView=[[BalanceView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400*HSCALE)];
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
    self.accountTableView.backgroundColor=[UIColor colorWithHexString:@"#64b8f0"];
    
    [self.view addSubview:self.accountTableView];
    [self.accountTableView registerClass:[AcountTableViewCell class] forCellReuseIdentifier:accountCell];
    
    [self initData];
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

-(void)tixianAction:(UIButton *)but{
    _grayView=[[AccountGrayView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sureTapClick:)];
    [_grayView addGestureRecognizer:tap];
    // 设置触控对象
    [tap setNumberOfTouchesRequired:1];
    // 设置轻拍的次数
    [tap setNumberOfTapsRequired:1];
    [tap setCancelsTouchesInView:NO];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:_grayView];
    [_grayView.save addTarget:self action:@selector(saveButton) forControlEvents:UIControlEventTouchUpInside];
    [_grayView.cancel addTarget:self action:@selector(cancelButton) forControlEvents:UIControlEventTouchUpInside];
    
    
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
                
                double money = model.availablemoney.doubleValue/100;
                
                NSString *str=[NSString stringWithFormat:@"%@:%.2f",NSLocalizedString(@"ketixian_ac",nil),money];
                
                if ([model.currency isEqualToString:@"USD"]&&but.tag==10002) {
                    [_grayView initUIDataWithUnit:NSLocalizedString(@"jinemy_ac",nil) Ketixian:str];
                    _currency=@"USD";
                }
                if ([model.currency isEqualToString:@"CNY"]&&but.tag==10001) {
                    [_grayView initUIDataWithUnit:NSLocalizedString(@"jinermb_ac",nil) Ketixian:str];
                    _currency=@"CNY";
                    
                }
                if ([model.currency isEqualToString:@"JPY"]&&but.tag==10003) {
                    [_grayView initUIDataWithUnit:NSLocalizedString(@"jinery_ac",nil) Ketixian:str];
                    _currency=@"JPY";
                    
                }
            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma 确认提现
-(void)saveButton{
    double moneyInput=[_grayView getMoney];
    
    if (moneyInput <= 0) {
        
        
    }else{
        
        [_grayView removeFromSuperview];
        
        double money=[_grayView getMoney];
        NSNumber *moneyNSN=[[NSNumber alloc]initWithDouble:money];
        NSString *acid=[_grayView getId];
        
        
        NSDictionary *dic=[[NSDictionary alloc]init];
        
        if (acid) {
            dic=@{@"cash_account_id":acid,@"currency":_currency,@"money":moneyNSN};
        }
        
        NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
        NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"cashapproval/create" timeString:dateStr];
        [[httpManager sharedManager]httpWithURL:@"cashapproval/create" method:POST param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
            NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
            
            //提现成功
            if (status==1){
                
                NSString *msg=[responseDic objectForKey:@"msg"];
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:msg delegate:self cancelButtonTitle:NSLocalizedString(@"queren",nil) otherButtonTitles:nil, nil];
                [alert show];
                [_headerView reloadUI];
            }else{
                NSString *msg=[responseDic objectForKey:@"msg"];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:self cancelButtonTitle:NSLocalizedString(@"queren",nil) otherButtonTitles:nil, nil];
                [alert show];
            }
            
        } failure:^(NSError *error) {
            
        }];
        
    }
    
}

-(void)cancelButton{
    [_grayView removeFromSuperview];
    
}

-(void)sureTapClick:(UIGestureRecognizer *)tap{
    [_grayView removeFromSuperview];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.accountArr.count+1;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==self.accountArr.count) {
        AcountTableViewCell *cell=[[AcountTableViewCell alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typeName.text=NSLocalizedString(@"tianjiazhanghu_ac",nil);
        cell.typeImage.image=[UIImage imageNamed:@"tianj"];
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
    return 108*HSCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==self.accountArr.count) {
        AddAccountViewController *vc=[[AddAccountViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ReviewAccViewController *vc=[[ReviewAccViewController alloc]init];
        AccountsModel *model=self.accountArr[indexPath.row];
        vc.model=model;
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
            
        }else{
            
            NSString *msg=[responseDic objectForKey:@"msg"];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}


#pragma 账单
-(void)accountList{
    AccountListViewController *vc=[[AccountListViewController alloc]init];
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
