//
//  ChildAccountViewController.m
//  jjrms
//
//  Created by user on 16/10/21.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "ChildAccountViewController.h"

@interface ChildAccountViewController ()

@end

@implementation ChildAccountViewController
{
    int _currentPageInt;//当前页int型
    NSNumber *_currentPageNum;//当前页NSNumber型
    UILabel *_tit;
    UIButton *_confirm;
    UIView *_line;
}

static NSString *ListCell = @"listTableViewCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBarView.backBut.hidden=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;

    _tit=[[UILabel alloc]init];
    _tit.textColor=[UIColor colorWithHexString:@"#555555"];
    [_tit setFont:[UIFont fontWithName:CUTI size:16]];
    _tit.textAlignment=NSTextAlignmentCenter;
    [self.navBarView addSubview:_tit];
    [_tit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.navBarView.backBut.mas_centerY);
        make.centerX.mas_equalTo(weakSelf.navBarView.mas_centerX);
    }];
    _tit.text=NSLocalizedString(@"zhangdan_ac",nil);
    
    
    _line=[[UIView alloc]init];
    [self.navBarView addSubview:_line];
    _line.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 2*HSCALE));
        make.left.mas_equalTo(0*WSCALE);
        make.top.mas_equalTo(64);
    }];

    
    self.listArr=[[NSMutableArray alloc]init];
    
    [self initUI];
}


-(void)initUI{

    
    self.listTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+2*HSCALE, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    self.listTableView.delegate=self;
    self.listTableView.dataSource=self;
    self.listTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.listTableView];
    [self.listTableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:ListCell];
    self.listTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTop)];
    self.listTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadBottom)];
    [self.listTableView.mj_header beginRefreshing];
    
}


#pragma 下拉刷新
-(void)loadTop{
    
    _currentPageInt=1;
    
    _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    dic=@{@"page_size":@20,@"current_page":_currentPageNum};
    
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"accountlog/list"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"accountlog/list" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){
            
            NSDictionary *info=[responseDic objectForKey:@"info"];
            
            NSArray *list=[info objectForKey:@"list"];
            
            self.listArr=[[NSMutableArray alloc]init];
            
            self.listArr=[AccountListModel objectArrayWithKeyValuesArray:list];
            
            if (self.listArr.count==0) {
                //[self noOrderUI];
            }else{
                [self.listTableView reloadData];
                
                _currentPageInt+=1;
                
                _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
            }

        }
        
        [self.listTableView.mj_header endRefreshing];
        
        
    } failure:^(NSError *error) {
        [self.listTableView.mj_header endRefreshing];

    }];
    
}

#pragma 上拉刷新
-(void)loadBottom{
    
    NSDictionary *dic=[[NSDictionary alloc]init];

    dic=@{@"amount_type":@"1,-1",@"page_size":@20};

    
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"accountlog/list"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"accountlog/list" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){
            NSDictionary *info=[responseDic objectForKey:@"info"];
            
            NSArray *list=[info objectForKey:@"list"];
            
            NSMutableArray *newModelArr=[[NSMutableArray alloc]init];
            
            newModelArr=[AccountListModel objectArrayWithKeyValuesArray:list];
            
            [self.listArr addObjectsFromArray:newModelArr];
            
            [self.listTableView reloadData];
            
            _currentPageInt+=1;
            
            _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
            
        }
        
        [self.listTableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        [self.listTableView.mj_footer endRefreshing];

    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell *cell = [self.listTableView dequeueReusableCellWithIdentifier:ListCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model=self.listArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    return 146*HSCALE;
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
