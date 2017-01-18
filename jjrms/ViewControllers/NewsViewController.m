//
//  NewsViewController.m
//  jjrms
//
//  Created by user on 16/9/23.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "NewsModel.h"
#import "NoImageTableViewCell.h"
@interface NewsViewController ()

@end

@implementation NewsViewController
{
    int _currentPageInt;//当前页int型
    NSNumber *_currentPageNum;//当前页NSNumber型
}

static NSString *newsCell = @"NewsTableViewCell";
static NSString *noImagenewsCell = @"noImagenewsCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarView.titleLab.text=NSLocalizedString(@"xiaoxi_ho",nil);


    _currentPageInt=1;
    
    _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
    
    self.orderArr=[[NSMutableArray alloc]init];
    
    [self initUI];

}
-(void)initUI{
    
    if (0) {
        

        
    }else{
 /*
        NewsModel *n1=[[NewsModel alloc]init];
        n1.imageUrl=@"qqq";
        n1.title=@"中秋";
        n1.time=@"2016121";
        n1.detail=@"是的，他们在等着大圣归来，一直在等着。一部《西游记》承载了多少代人的童年，齐天大圣的名号一亮出，又有多少人会热泪盈眶。在我小的时候，奥特曼、超人、钢铁侠，从来都不是我的超级英雄，陪伴我整个童年的，只有齐天大圣孙悟空。我看了无数遍六小龄童版的《西游记》，买了连环画，看了原著，买过各种型号的孙悟空面具和塑料金箍棒。九九八十一难取经历程结束，我多么希望再能看到孙悟空，看到那个曾经叱诧风云的齐天大圣。但是他成了斗战胜佛，最后摘掉金箍的他，已经离我们远去了。那一年，《宝莲灯》上映，沉香找到了孙悟空，当时我希望他奋起千钧棒，打死二郎神。";
        
        NewsModel *n2=[[NewsModel alloc]init];
        n2.title=@"国庆";
        n2.time=@"2016122";
        n2.detail=@"是的，他们在等着大圣归来，一直在等着。";
        n1.cellHeight=530*HSCALE;
        n2.cellHeight=346*HSCALE;
        [self.orderArr addObject:n1];
        [self.orderArr addObject:n2];

*/
        self.orderTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        self.orderTableView.delegate=self;
        self.orderTableView.dataSource=self;
        [self.view addSubview:self.orderTableView];
        [self.orderTableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:newsCell];
        [self.orderTableView registerClass:[NoImageTableViewCell class] forCellReuseIdentifier:noImagenewsCell];


        
        
        
        self.orderTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTopNew)];
        self.orderTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadBottomNew)];
        [self.orderTableView.mj_header beginRefreshing];
        
    }
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
        }else{
            NSString *msg=[responseDic objectForKey:@"msg"];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:self cancelButtonTitle:NSLocalizedString(@"queren",nil) otherButtonTitles:nil, nil];
            [alert show];
        }
        
        [self.orderTableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        
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
            
            
        }else{
            
            NSString *msg=[responseDic objectForKey:@"msg"];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:self cancelButtonTitle:NSLocalizedString(@"queren",nil) otherButtonTitles:nil, nil];
            [alert show];
        }
        
        [self.orderTableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        
    }];
}














- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.orderArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel *model=self.orderArr[indexPath.section];
    
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
    NewsModel *model=self.orderArr[indexPath.section];
    return model.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel *model=self.orderArr[indexPath.section];
    NewsDetailViewController *vc=[[NewsDetailViewController alloc]init];
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
