//
//  MsgViewController.m
//  jjrms
//
//  Created by user on 2016/11/15.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "MsgViewController.h"
#import "NewsTableViewCell.h"
#import "NewsModel.h"
#import "NoImageTableViewCell.h"
@interface MsgViewController ()

@end

@implementation MsgViewController
{
    int _currentPageInt;//当前页int型
    NSNumber *_currentPageNum;//当前页NSNumber型
}

static NSString *newsCell = @"NewsTableViewCell";
static NSString *noImagenewsCell = @"noImagenewsCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBarView.hidden=YES;
    
    _currentPageInt=1;
    
    _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
    
    self.orderArr=[[NSMutableArray alloc]init];
    
    [self initUI];
}
-(void)initUI{
    
        self.orderTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20) style:UITableViewStyleGrouped];
        self.orderTableView.backgroundColor=[UIColor whiteColor];
        self.orderTableView.delegate=self;
        self.orderTableView.dataSource=self;
        self.orderTableView.separatorStyle = NO;//无边线
        [self.view addSubview:self.orderTableView];
        [self.orderTableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:newsCell];
        [self.orderTableView registerClass:[NoImageTableViewCell class] forCellReuseIdentifier:noImagenewsCell];
        self.orderTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTopNew)];
        self.orderTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadBottomNew)];
        [self.orderTableView.mj_header beginRefreshing];
    
    
}



#pragma 下拉刷新
-(void)loadTopNew{
    _currentPageInt=1;
    _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
    NSDictionary *dic=[[NSDictionary alloc]init];
    dic=@{@"page_size":@10,@"current_page":_currentPageNum};
    
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"notice/list"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"notice/list" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        if (status==1){
            NSDictionary *info=[responseDic objectForKey:@"info"];
            NSArray *list=[info objectForKey:@"list"];
            self.orderArr=[[NSMutableArray alloc]init];
            NSMutableArray *tempArr=[[NSMutableArray alloc]init];
            tempArr=[NewsModel objectArrayWithKeyValuesArray:list];
            for (int i=0; i<tempArr.count; i++) {
                NewsModel *model=tempArr[i];
                if (model.image.length) {
                    model.cellHeight=530*HSCALE;
                }else{
                    model.cellHeight=340*HSCALE;
                }
                [self.orderArr addObject:model];
            }
            
            if (self.orderArr.count==0) {
                //[self noOrderUI];
            }else{
                [self.orderTableView reloadData];
                _currentPageInt+=1;
                _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
            }
        }
        
        [self.orderTableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.orderTableView.mj_header endRefreshing];

    }];
}


#pragma 上拉刷新
-(void)loadBottomNew{
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    
    dic=@{@"page_size":@10,@"current_page":_currentPageNum};
    
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"notice/list"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"notice/list" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        if (status==1){
            
            NSDictionary *info=[responseDic objectForKey:@"info"];
            NSArray *list=[info objectForKey:@"list"];
            
            NSMutableArray *tempArr=[[NSMutableArray alloc]init];
            
            tempArr=[NewsModel objectArrayWithKeyValuesArray:list];
            
            for (int j=0; j<tempArr.count; j++) {
                NewsModel *model=tempArr[j];
                
                if (model.image.length) {
                    model.cellHeight=530*HSCALE;
                }else{
                    model.cellHeight=340*HSCALE;
                }
                
                [self.orderArr addObject:model];
            }
            
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.orderArr.count==0) {
        return  0;
    }else{
        return self.orderArr.count;
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
        lab.text=NSLocalizedString(@"xiaoxi_tit",nil);
    }
    
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 140*HSCALE + 44;//254*HSCALE-20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel *model=self.orderArr[indexPath.row];
    
    if (model.image.length) {
        NewsTableViewCell  *cell  = [self.orderTableView dequeueReusableCellWithIdentifier: newsCell];
        if (cell == nil) {
            cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newsCell];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.model=model;
        return cell;
    }else{
        
        NoImageTableViewCell  *cell  = [self.orderTableView dequeueReusableCellWithIdentifier: noImagenewsCell];
        if (cell == nil) {
            cell = [[NoImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noImagenewsCell];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.model=model;
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *model=self.orderArr[indexPath.row];
    return model.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel *model=self.orderArr[indexPath.row];
    NewsDetailViewController *vc=[[NewsDetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed=YES;
    vc.model=model;
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
