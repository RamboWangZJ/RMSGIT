//
//  ChildOrderTableViewController.m
//  jjrms
//
//  Created by user on 16/9/28.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "ChildOrderTableViewController.h"

@interface ChildOrderTableViewController ()

@end

@implementation ChildOrderTableViewController
{
    int _currentPageInt;//当前页int型
    NSNumber *_currentPageNum;//当前页NSNumber型
}

static NSString *orderCell = @"orderTableViewCell";
static NSString *PointCell = @"PointTableViewCell";




- (void)viewDidLoad {
    [super viewDidLoad];
    
    _currentPageInt=1;
    
    _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
    
    self.orderArr=[[NSMutableArray alloc]init];
    
    [self initUI];
    
}




-(void)initUI{
    
    self.orderTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-80*HSCALE) style:UITableViewStylePlain];
    self.orderTableView.delegate=self;
    self.orderTableView.dataSource=self;
    self.orderTableView.showsVerticalScrollIndicator=NO;
    self.orderTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.orderTableView];
    [self.orderTableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:orderCell];
    [self.orderTableView registerClass:[PointTableViewCell class] forCellReuseIdentifier:PointCell];
    self.orderTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTop)];
    self.orderTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadBottom)];
    [self.orderTableView.mj_header beginRefreshing];
    
}



#pragma 下拉刷新
-(void)loadTop{
    
    _currentPageInt=1;
    
    _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
    NSNumber *stateSearch=[NSNumber numberWithInteger:self.order_status];
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    if (self.order_status==9999) { //查全部
        dic=@{@"landlord_sn":[[NSUserDefaults standardUserDefaults]valueForKey:USER_SN],@"page_size":@10,@"current_page":_currentPageNum};
    }else{
        dic=@{@"landlord_sn":[[NSUserDefaults standardUserDefaults]valueForKey:USER_SN],@"page_size":@10,@"current_page":_currentPageNum,@"order_status":stateSearch};
    }
    
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"order/list"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"order/list" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){
            
            NSDictionary *info=[responseDic objectForKey:@"info"];
            
            NSArray *list=[info objectForKey:@"list"];
            
            self.orderArr=[[NSMutableArray alloc]init];
            
            self.orderArr=[OrderModel objectArrayWithKeyValuesArray:list];
            
            
            [self.orderTableView reloadData];
            
            _currentPageInt+=1;
            
            _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
            /*
             if (self.orderArr.count==0) {
             [self noOrderUI];
             }else{
             [self.orderTableView reloadData];
             
             _currentPageInt+=1;
             
             _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
             }
             */
            
        }
        
        [self.orderTableView.mj_header endRefreshing];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}
#pragma 上拉刷新
-(void)loadBottom{
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    NSNumber *stateSearch=[NSNumber numberWithInteger:self.order_status];
    if (self.order_status==9999) { //查全部
        dic=@{@"landlord_sn":[[NSUserDefaults standardUserDefaults]valueForKey:USER_SN],@"page_size":@10,@"current_page":_currentPageNum};
    }else{
        dic=@{@"landlord_sn":[[NSUserDefaults standardUserDefaults]valueForKey:USER_SN],@"page_size":@10,@"current_page":_currentPageNum,@"order_status":stateSearch};
    }
    
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"order/list"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"order/list" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){
            NSDictionary *info=[responseDic objectForKey:@"info"];
            
            NSArray *list=[info objectForKey:@"list"];
            
            NSMutableArray *newModelArr=[[NSMutableArray alloc]init];
            
            newModelArr=[OrderModel objectArrayWithKeyValuesArray:list];
            
            [self.orderArr addObjectsFromArray:newModelArr];
            
            [self.orderTableView reloadData];
            
            _currentPageInt+=1;
            
            _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
            
        }
        
        [self.orderTableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        
    }];
}


-(void)noOrderUI{
    
    PointView *point=[[PointView alloc]init];
    //point.icon.image=[UIImage imageNamed:@"wudingdan"];
    [point.iconBT setBackgroundImage:[UIImage imageNamed:@"wudingdan"] forState:UIControlStateNormal];
    [point.iconBT addTarget:self action:@selector(loadTop) forControlEvents:UIControlEventTouchUpInside];
    point.txt.text=@"亲，还没有订单信息!";
    [self.view addSubview:point];
    [point mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.orderArr.count==0) {
        return  1;
    }else{
        return self.orderArr.count;
    }
    //return self.orderArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.orderArr.count==0) {
        PointTableViewCell *cell = [self.orderTableView dequeueReusableCellWithIdentifier:PointCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.icon.image=[UIImage imageNamed:@"wudingdan"];
        cell.txt.text=@"亲，还没有订单信息!";
        return cell;
    }else{
        
        OrderTableViewCell *cell = [self.orderTableView dequeueReusableCellWithIdentifier:orderCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model=self.orderArr[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    if (self.orderArr.count==0) {
        return SCREEN_HEIGHT-64-80*HSCALE;
    }
    return 188*HSCALE;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.orderArr.count==0) {
        [self.orderTableView.mj_header beginRefreshing];
    }else{
    OrderDetailViewController *vc=[[OrderDetailViewController alloc] init];
    vc.orderModel=self.orderArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    }
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
