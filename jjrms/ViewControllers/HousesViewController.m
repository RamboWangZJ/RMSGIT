//
//  HousesViewController.m
//  jjrms
//
//  Created by user on 2016/11/15.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "HousesViewController.h"

@interface HousesViewController ()

@end

@implementation HousesViewController
{
    UILabel *_infoLab;
    
    int _currentPageInt;//当前页int型
    NSNumber *_currentPageNum;//当前页NSNumber型
}

static NSString *homesCell = @"HomesTableViewCell";
static NSString *PointCell = @"PointTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBarView.hidden=YES;
    
    _currentPageInt=1;
    
    _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
    
    self.homeArr=[[NSMutableArray alloc]init];
    
    [self initUI];
}

-(void)initUI{
    
    self.homeTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20) style:UITableViewStyleGrouped];
    self.homeTableView.backgroundColor=[UIColor whiteColor];
    self.homeTableView.delegate=self;
    self.homeTableView.dataSource=self;
    self.homeTableView.showsVerticalScrollIndicator=NO;
    self.homeTableView.separatorStyle = NO;//无边线
    self.homeTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.homeTableView];
    [self.homeTableView registerClass:[HomesTableViewCell class] forCellReuseIdentifier:homesCell];
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

    dic=@{@"landlord_sn":[[NSUserDefaults standardUserDefaults]valueForKey:USER_SN],@"page_size":@10,@"current_page":_currentPageNum};
    
  
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"house/list"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"house/list" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){
            
            NSDictionary *info=[responseDic objectForKey:@"info"];
            
            NSArray *list=[info objectForKey:@"list"];
            
            self.homeArr=[[NSMutableArray alloc]init];
            
            self.homeArr=[HomeSourceModel objectArrayWithKeyValuesArray:list];
            for (int i = 0; i<self.homeArr.count; i++) {
                HomeSourceModel *model=self.homeArr[i];
            }
            [self.homeTableView reloadData];
            
            _currentPageInt+=1;
            
            _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
            
        }
        
        [self.homeTableView.mj_header endRefreshing];
        
        
    } failure:^(NSError *error) {
        [self.homeTableView.mj_header endRefreshing];

    }];
    
    
    
}
#pragma 上拉刷新
-(void)loadBottom{
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    dic=@{@"landlord_sn":[[NSUserDefaults standardUserDefaults]valueForKey:USER_SN],@"page_size":@10,@"current_page":_currentPageNum};
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
        [self.homeTableView.mj_footer endRefreshing];

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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView=[[UIView alloc]init];
    headView.backgroundColor=[UIColor whiteColor];
    UILabel *lab=[[UILabel alloc]init];
    lab.textColor=[UIColor colorWithHexString:@"#555555"];
    [lab setFont:[UIFont fontWithName:CUTI size:23]];
    lab.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60*HSCALE + 44);
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
        lab.text=NSLocalizedString(@"fangyuans_hs",nil);
    }
    
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 140*HSCALE + 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.homeArr.count==0) {
        PointTableViewCell *cell = [self.homeTableView dequeueReusableCellWithIdentifier:PointCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.txt2.text=NSLocalizedString(@"nimeiyoufangyuan_hs",nil);
        return cell;
    }else{
        HomesTableViewCell *cell = [self.homeTableView dequeueReusableCellWithIdentifier:homesCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model=self.homeArr[indexPath.row];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    if (self.homeArr.count==0) {
        return SCREEN_HEIGHT-64;
    }
    return 286*HSCALE;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.homeArr.count==0) {
        [self.homeTableView.mj_header beginRefreshing];
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
