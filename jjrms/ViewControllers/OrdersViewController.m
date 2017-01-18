//
//  OrdersViewController.m
//  jjrms
//
//  Created by user on 2016/11/15.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "OrdersViewController.h"

@interface OrdersViewController ()

@end

@implementation OrdersViewController
{
    UIImageView *_iconTop;
    UIButton *_detail;
    
    int _currentPageInt;//当前页int型
    NSNumber *_currentPageNum;//当前页NSNumber型
    
}

static NSString *ordersCell = @"ordersTableViewCell";
static NSString *PointCell = @"PointTableViewCell";


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if(self.isRefresh==YES){
        [self.orderTableView.mj_header beginRefreshing];

    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.navBarView.titleLab.text=NSLocalizedString(@"dingdan_tit",nil);
    self.navBarView.hidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;

    _detail=[UIButton buttonWithType:UIButtonTypeCustom];
    [_detail setTitle:NSLocalizedString(@"guidang_or",nil) forState:UIControlStateNormal];
    [_detail addTarget:self action:@selector(guidangAction) forControlEvents:UIControlEventTouchUpInside];
    [_detail setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
    _detail.titleLabel.font=[UIFont systemFontOfSize:15];
    [_detail setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.view addSubview:_detail];
    [_detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-50*WSCALE);
        make.centerY.mas_equalTo(weakSelf.navBarView.backBut.mas_centerY);
    }];
    
    
    _iconTop=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dinggui"]];
    [self.view addSubview:_iconTop];
    [_iconTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30*WSCALE, 30*HSCALE));
        make.centerY.equalTo(_detail.mas_centerY);
        make.right.mas_equalTo(_detail.mas_left).offset(-12*WSCALE);
    }];
    
    _currentPageInt=1;
    
    _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
    
    self.orderArr=[[NSMutableArray alloc]init];
    
    [self initUI];
}


-(void)initUI{
    
    self.orderTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStyleGrouped];
    self.orderTableView.backgroundColor=[UIColor whiteColor];
    self.orderTableView.delegate=self;
    self.orderTableView.dataSource=self;
    self.orderTableView.showsVerticalScrollIndicator=NO;
    self.orderTableView.separatorStyle = NO;//无边线
    self.orderTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.orderTableView];
    [self.orderTableView registerClass:[OrdersTableViewCell class] forCellReuseIdentifier:ordersCell];
    [self.orderTableView registerClass:[PointTableViewCell class] forCellReuseIdentifier:PointCell];
    self.orderTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTop)];
    self.orderTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadBottom)];
    [self.orderTableView.mj_header beginRefreshing];
    
}



#pragma 下拉刷新
-(void)loadTop{
    
    _currentPageInt=1;
    _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
    NSDictionary *dic=[[NSDictionary alloc]init];
    dic=@{@"landlord_sn":[[NSUserDefaults standardUserDefaults]valueForKey:USER_SN],@"page_size":@10,@"current_page":_currentPageNum,@"order_status":@90};

    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"order/list"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"order/list" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){
            
            NSDictionary *info=[responseDic objectForKey:@"info"];
            
            NSArray *list=[info objectForKey:@"list"];
            
            self.orderArr=[OrderModel objectArrayWithKeyValuesArray:list];
            
            [self.orderTableView reloadData];
            
            _currentPageInt+=1;
            
            _currentPageNum=[NSNumber numberWithInt:_currentPageInt];

        }
        
        [self.orderTableView.mj_header endRefreshing];
        
        
    } failure:^(NSError *error) {
        
        [self.orderTableView.mj_header endRefreshing];

    }];
    
}
#pragma 上拉刷新
-(void)loadBottom{
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    dic=@{@"landlord_sn":[[NSUserDefaults standardUserDefaults]valueForKey:USER_SN],@"page_size":@10,@"current_page":_currentPageNum,@"order_status":@90};
    
    
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
        
        [self.orderTableView.mj_footer endRefreshing];

    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.orderArr.count==0) {
        return 1;
    }else{
        return 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView=[[UIView alloc]init];
    headView.backgroundColor=[UIColor whiteColor];
    UILabel *lab=[[UILabel alloc]init];
    lab.textColor=[UIColor colorWithHexString:@"#555555"];
    [lab setFont:[UIFont fontWithName:CUTI size:23]];
    lab.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
    }];
    
    UIView *line=[[UIView alloc]init];
    line.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [headView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(96*WSCALE);
        make.height.mas_equalTo(2*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
        make.bottom.mas_equalTo(0*HSCALE);
    }];
    
    if (section==0) {
        lab.text=NSLocalizedString(@"daiqueren_or",nil);
    }
    
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 140*HSCALE;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.orderArr.count==0) {
        return  1;
    }else{
        return self.orderArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.orderArr.count==0) {
        PointTableViewCell *cell = [self.orderTableView dequeueReusableCellWithIdentifier:PointCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.txt1.text=NSLocalizedString(@"tishi1_or",nil);
        cell.txt2.text=NSLocalizedString(@"tishi2_or",nil);
        return cell;
    }else{
        
        OrdersTableViewCell *cell = [self.orderTableView dequeueReusableCellWithIdentifier:ordersCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model=self.orderArr[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    if (self.orderArr.count==0) {
        return SCREEN_HEIGHT-64-49;
    }
    return 262*HSCALE;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.orderArr.count==0) {
        [self.orderTableView.mj_header beginRefreshing];
    }else{
        OrdersDetailViewController *vc=[[OrdersDetailViewController alloc] init];
        vc.orderModel=self.orderArr[indexPath.row];
        vc.hidesBottomBarWhenPushed=YES;
        vc.showAcc=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



//
-(void)guidangAction{
    OtherOrdersViewController *vc=[[OtherOrdersViewController alloc] init];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];    
}

//
-(void)loadData{
    
    
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
