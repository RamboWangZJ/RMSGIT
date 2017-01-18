//
//  HomeViewController.m
//  jjrms
//
//  Created by user on 16/9/23.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "HomeViewController.h"
#import "TapCollectionViewCell.h"
#import "HousesSourceViewController.h"
#import "OrderViewController.h"
#import "NewsViewController.h"
#import "AccountViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController
{
    UIImageView *_headImageView;
    UILabel *_title;
    UIView *_lineW;
    UIView *_lineH;
}

static NSString *tapCell = @"HomeTapCollectionViewCell";



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.clipsToBounds=YES;

    [self initData];
    [self initUI];
}


- (void)viewWillAppear:(BOOL)animated{
    //状态栏
    [super viewWillAppear:YES];
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor clearColor];
    }
}


//菜单数据字典
- (void)initData{
    self.MenuArr = [[NSMutableArray alloc]initWithObjects:
                    @{@"pic":@"fangyuan1",@"text":NSLocalizedString(@"fangyuan_ho",nil)}, @{@"pic":@"dingdan1",@"text":NSLocalizedString(@"dingdan_ho",nil)}, @{@"pic":@"xiaoxi1",@"text":NSLocalizedString(@"xiaoxi_ho",nil)},
                        @{@"pic":@"zhanghu1",@"text":NSLocalizedString(@"zhanghu_ho",nil)}, nil];
    
}

//整体ui初始化
- (void)initUI{
    
    _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 480*SCREEN_HEIGHT/1136)];
    _headImageView.image=[UIImage imageNamed:@"head"];
    [self.view addSubview:_headImageView];
    
    
    _title=[[UILabel alloc]init];
    [_headImageView addSubview:_title];
    _title.text=@"鲸鲸";
    _title.textColor=[UIColor whiteColor];
    [_title setFont:[UIFont fontWithName:CUTI size:16]];

    _title.textAlignment=NSTextAlignmentCenter;
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_headImageView);
        make.height.mas_equalTo(50*HSCALE);
        make.top.mas_equalTo(40*HSCALE);
    }];
    

    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 65.0f);//头部视图的框架大小
    layout.itemSize = CGSizeMake(SCREEN_WIDTH/2, 220*SCREEN_HEIGHT/1136);//每个cell的大小
    layout.minimumLineSpacing = 0.0f;//每行的最小间距
    layout.minimumInteritemSpacing = 0.0f;//每列的最小间距
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//网格视图的/上/左/下/右,的边距
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _headImageView.frame.origin.y+_headImageView.frame.size.height+30*SCREEN_HEIGHT/1136, SCREEN_WIDTH, 440*SCREEN_HEIGHT/1136) collectionViewLayout:layout]; //初始化网格视图大小
    [self.collectionView registerClass:[TapCollectionViewCell class] forCellWithReuseIdentifier:tapCell];//cell重用设置ID
    //[self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeTapCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:tapCell];
    
    self.collectionView.delegate = self;//实现网格视图的delegate
    self.collectionView.dataSource = self;//实现网格视图的dataSource
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    
    _lineW=[[UIView alloc]init];
    _lineW.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    [self.collectionView addSubview:_lineW];
    [_lineW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(600*WSCALE, 1*HSCALE));
        make.left.mas_equalTo(20*WSCALE);
        make.top.mas_equalTo(219.5*HSCALE);
    }];
    
    _lineH=[[UIView alloc]init];
    _lineH.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    [self.collectionView addSubview:_lineH];
    [_lineH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1*WSCALE, 400*HSCALE));
        make.left.mas_equalTo(319.5*WSCALE);
        make.top.mas_equalTo(20*HSCALE);
    }];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.MenuArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //HomeTapCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:tapCell forIndexPath:indexPath];
    TapCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:tapCell forIndexPath:indexPath];
    NSDictionary *menuModel=[self.MenuArr objectAtIndex:indexPath.row];
    cell.model = menuModel;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            HousesSourceViewController *vc=[[HousesSourceViewController alloc] init];
            vc.view.backgroundColor=[UIColor whiteColor];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if(indexPath.row==1){
            OrderViewController *vc=[[OrderViewController alloc] init];
            vc.view.backgroundColor=[UIColor whiteColor];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==2){
            NewsViewController *vc=[[NewsViewController alloc] init];
            vc.view.backgroundColor=[UIColor whiteColor];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==3){
            AccountViewController *vc=[[AccountViewController alloc] init];
            vc.view.backgroundColor=[UIColor whiteColor];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
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
