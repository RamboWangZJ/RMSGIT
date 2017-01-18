//
//  OrderDetailViewController.m
//  jjrms
//
//  Created by user on 16/9/28.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderTableViewCell.h"
#import "NodealTableViewCell.h"
@interface OrderDetailViewController ()

@end

@implementation OrderDetailViewController
{
    UIButton *_loginButton;
}
static NSString *homeCell = @"OrderDetailTableViewCell";
static NSString *NodealCell = @"NodealTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    self.navBarView.titleLab.text=NSLocalizedString(@"dingdanxiangqing_or",nil);
    [self initOrderDetailData];
}

#pragma 请求订单详情数据
-(void)initOrderDetailData{
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
            self.orderArr=[[NSMutableArray alloc]init];
            [self.orderArr addObject:model];
            if ([model.order_status isEqualToString:@"90"]) {// 510
                self.isNoDeal=YES;
            }else{
                self.isNoDeal=NO;
            }
            
            [self initUI];
            
        }else{
            NSString *msg=[responseDic objectForKey:@"msg"];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:self cancelButtonTitle:NSLocalizedString(@"queren",nil) otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } failure:^(NSError *error) {
        
    }];
}


-(void)initUI{
    
    OrderDetailTopView *topView = [[OrderDetailTopView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 188*HSCALE)];
    topView.model=self.orderModel;
    [self.view addSubview:topView];
    
    /*
    OrderTableViewCell *cell=[[OrderTableViewCell alloc]init];
    cell.model=self.orderModel;
    [self.view addSubview:cell];
    [cell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 188*HSCALE));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
    }];
    NSLog(@"%f..",cell.frame.size.width);
    NSLog(@"%f..",cell.frame.size.height);
     */
    
    //待处理
    if (self.isNoDeal) {
        /*
        [self.navBarView.rightBut setTitle:NSLocalizedString(@"qvxiaodingdan_or",nil) forState:UIControlStateNormal];
        [self.navBarView.rightBut addTarget:self action:@selector(cancelOrder) forControlEvents:UIControlEventTouchUpInside];
        */
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"querendingdan_or",nil) style:UIBarButtonItemStylePlain target:self action:@selector(cancelOrder)];
        self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
        self.orderTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, topView.frame.origin.y + 208*HSCALE, SCREEN_WIDTH, SCREEN_HEIGHT - 208*HSCALE - 64 - 100*HSCALE)];
        self.orderTableView.delegate=self;
        self.orderTableView.dataSource=self;
        self.orderTableView.tableFooterView = [UIView new];
        [self.view addSubview:self.orderTableView];
        [self.orderTableView registerClass:[NodealTableViewCell class] forCellReuseIdentifier:NodealCell];
        
        
        _loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:NSLocalizedString(@"querendingdan_or",nil) forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.backgroundColor=[UIColor colorWithHexString:@"#64b8f0"];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.titleLabel.font=[UIFont systemFontOfSize:18];
        [_loginButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        _loginButton.layer.masksToBounds=YES;
        _loginButton.layer.cornerRadius=6;
        [self.view addSubview:_loginButton];
        [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(460*WSCALE, 72*HSCALE));
            make.left.mas_equalTo(90*WSCALE);
            make.bottom.mas_equalTo(-14*HSCALE);
        }];
        
        
    }else{ //其他
        
        self.orderTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, topView.frame.origin.y + 208*HSCALE, SCREEN_WIDTH, SCREEN_HEIGHT - 208*HSCALE)];
        self.orderTableView.delegate=self;
        self.orderTableView.dataSource=self;
        self.orderTableView.tableFooterView = [UIView new];
        [self.view addSubview:self.orderTableView];
        [self.orderTableView registerClass:[OrderDetailTableViewCell class] forCellReuseIdentifier:homeCell];
       
    }
    
}

#pragma 批量取消订单
-(void)cancelOrder{
    
    UIButton *button = (UIButton *)[self.orderTableView viewWithTag:1000];
    if (button.isSelected) {
        
        NSDictionary *dic=[[NSDictionary alloc]init];
        OrderModel *model=[[OrderModel alloc]init];
        model=self.orderArr[0];
        dic=@{@"order_sn":model.order_sn,@"user_sn":[[NSUserDefaults standardUserDefaults]valueForKey:USER_SN]};
        NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
        NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"order/cancel"timeString:dateStr];
        [[httpManager sharedManager]httpWithURL:@"order/cancel" method:POST param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
            
            NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
            
            if (status==1){
                
                NSString *msg=[responseDic objectForKey:@"msg"];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:self cancelButtonTitle:NSLocalizedString(@"queren",nil) otherButtonTitles:nil, nil];
                [alert show];
                
            }else{
                NSString *msg=[responseDic objectForKey:@"msg"];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:self cancelButtonTitle:NSLocalizedString(@"queren",nil) otherButtonTitles:nil, nil];
                [alert show];
            }
            
        } failure:^(NSError *error) {
            
        }];
        
        
    }
    
}

#pragma 确认订单
-(void)confirmAction{
    
    UIButton *button = (UIButton *)[self.orderTableView viewWithTag:1000];
    if (button.isSelected) {
        
        NSDictionary *dic=[[NSDictionary alloc]init];
        OrderModel *model=[[OrderModel alloc]init];
        model=self.orderArr[0];
        dic=@{@"order_sn":model.order_sn};
        NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
        NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"order/orderconfirm"timeString:dateStr];
        [[httpManager sharedManager]httpWithURL:@"order/orderconfirm" method:POST param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
            
            NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
            
            OrderResultViewController *resultVC=[[OrderResultViewController alloc]init];
            
            if (status==1){
                resultVC.isSuc=YES;
            }else{
                resultVC.isSuc=NO;
            }
            
            [self.navigationController pushViewController:resultVC animated:YES];
            
        } failure:^(NSError *error) {
            
        }];
    }
    
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.orderArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isNoDeal) {
        NodealTableViewCell *cell = [self.orderTableView dequeueReusableCellWithIdentifier:NodealCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model=self.orderArr[indexPath.row];
        cell.checkBut.tag=indexPath.row+1000;
        return cell;
    }else{
        OrderDetailTableViewCell *cell = [self.orderTableView dequeueReusableCellWithIdentifier:homeCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model=self.orderArr[indexPath.row];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    if (self.isNoDeal) {
        return 156*HSCALE;
    }
    return 240*HSCALE;
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
