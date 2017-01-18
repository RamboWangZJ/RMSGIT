//
//  ChildTableViewController.m
//  jjrms
//
//  Created by user on 16/9/27.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "ChildTableViewController.h"
#import "PointView.h"
@interface ChildTableViewController ()

@end

@implementation ChildTableViewController
{
    int _currentPageInt;//当前页int型
    NSNumber *_currentPageNum;//当前页NSNumber型
}
static NSString *homeCell = @"HomeTableViewCell";
static NSString *PointCell = @"PointTableViewCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _currentPageInt=1;
    
    _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
    
    self.homeArr=[[NSMutableArray alloc]init];
    //[self initData];
    [self initUI];
    
}
-(void)initData{
    
}

-(void)initUI{
    
    self.homeTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-80*HSCALE) style:UITableViewStylePlain];
    self.homeTableView.delegate=self;
    self.homeTableView.dataSource=self;
    self.homeTableView.showsVerticalScrollIndicator=NO;
    self.homeTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.homeTableView];
    [self.homeTableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:homeCell];
    [self.homeTableView registerClass:[PointTableViewCell class] forCellReuseIdentifier:PointCell];
    self.homeTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTop)];
    self.homeTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadBottom)];
    [self.homeTableView.mj_header beginRefreshing];
    
}

#pragma 下拉刷新
-(void)loadTop{
    
    _currentPageInt=1;
    
    _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    
    NSNumber *stateSearch=[NSNumber numberWithInteger:self.status];
    
    
    if (self.status==9999) { //查全部  crash iphone5
        dic=@{@"landlord_sn":[[NSUserDefaults standardUserDefaults]valueForKey:USER_SN],@"page_size":@10,@"current_page":_currentPageNum};
    }else{
        dic=@{@"landlord_sn":[[NSUserDefaults standardUserDefaults]valueForKey:USER_SN],@"page_size":@10,@"current_page":_currentPageNum,@"status":stateSearch};
    }
    
    
    
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"house/list"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"house/list" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){
            
            NSDictionary *info=[responseDic objectForKey:@"info"];
            
            NSArray *list=[info objectForKey:@"list"];
            
            self.homeArr=[[NSMutableArray alloc]init];
            
            self.homeArr=[HomeSourceModel objectArrayWithKeyValuesArray:list];
            
            [self.homeTableView reloadData];
            
            _currentPageInt+=1;
            
            _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
            /*
             // 无房源信息
             if (self.homeArr.count==0) {
             [self noHomeUI];
             }else{
             [self.homeTableView reloadData];
             
             _currentPageInt+=1;
             
             _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
             }
             */
            
        }
        
        [self.homeTableView.mj_header endRefreshing];
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}
#pragma 上拉刷新
-(void)loadBottom{
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    NSNumber *stateSearch=[NSNumber numberWithInteger:self.status];
    if (self.status==9999) { //查全部  crash iphone5
        //查全部
        dic=@{@"landlord_sn":[[NSUserDefaults standardUserDefaults]valueForKey:USER_SN],@"page_size":@10,@"current_page":_currentPageNum};
    }else{
        dic=@{@"landlord_sn":[[NSUserDefaults standardUserDefaults]valueForKey:USER_SN],@"page_size":@10,@"current_page":_currentPageNum,@"status":stateSearch};
    }
    
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"house/list"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"house/list" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){
            
            NSDictionary *info=[responseDic objectForKey:@"info"];
            
            NSArray *list=[info objectForKey:@"list"];
            
            NSMutableArray *newModelArr=[[NSMutableArray alloc]init];
            
            newModelArr=[HomeSourceModel objectArrayWithKeyValuesArray:list];
            
            [self.homeArr addObjectsFromArray:newModelArr];
            
            [self.homeTableView reloadData];
            
            _currentPageInt+=1;
            
            _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
            
        }
        
        [self.homeTableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)noHomeUI{
    PointView *point=[[PointView alloc]init];
    //point.icon.image=[UIImage imageNamed:@"wnfangyuan"];
    [point.iconBT setBackgroundImage:[UIImage imageNamed:@"wnfangyuan"] forState:UIControlStateNormal];
    [point.iconBT addTarget:self action:@selector(loadTop) forControlEvents:UIControlEventTouchUpInside];
    point.txt.text=@"亲，还没有房源信息!";
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
    if (self.homeArr.count==0) {
        return  1;
    }else{
        return self.homeArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.homeArr.count==0) {
        PointTableViewCell *cell = [self.homeTableView dequeueReusableCellWithIdentifier:PointCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.icon.image=[UIImage imageNamed:@"wnfangyuan"];
        cell.txt.text=@"亲，还没有房源信息!";
        return cell;
    }else{
        HomeTableViewCell *cell = [self.homeTableView dequeueReusableCellWithIdentifier:homeCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model=self.homeArr[indexPath.row];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    if (self.homeArr.count==0) {
        return SCREEN_HEIGHT-64-80*HSCALE;
    }
    return 188*HSCALE;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.homeArr.count==0) {
        [self.homeTableView.mj_header beginRefreshing];
    }else{
        DetailViewController *vc=[[DetailViewController alloc] init];
        vc.topModel=self.homeArr[indexPath.row];
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
