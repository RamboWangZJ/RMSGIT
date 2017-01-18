//
//  CreateTelCheckViewController.m
//  jjrms
//
//  Created by user on 2016/12/7.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "ForgetTelCheckViewController.h"

@interface ForgetTelCheckViewController ()

@end

@implementation ForgetTelCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBarView.backBut.hidden=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    self.navBarView.titleLab.text=NSLocalizedString(@"telcheck_lg",nil);
    self.navBarView.lineView.hidden=YES;
    
    _countryCodeArr=[[NSMutableArray alloc]init];
    [self initUI];
    
}

-(void)initUI{
    
    self.contryCodeTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.navBarView.frame.size.height + 30*HSCALE, SCREEN_WIDTH, SCREEN_HEIGHT-self.navBarView.frame.size.height-20) style:UITableViewStylePlain];
    self.contryCodeTableView.delegate=self;
    self.contryCodeTableView.dataSource=self;
    self.contryCodeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contryCodeTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.contryCodeTableView];
    //[self.listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"countryCodeCell"];
    //self.listTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTop)];
    //self.listTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadBottom)];
    //[self.listTableView.mj_header beginRefreshing];
    
    [self initData];
}

-(void)initData{
    NSDictionary *dic=[[NSDictionary alloc]init];
    dic=@{@"current_page":@1,@"page_size":@100};
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"util/worldalllist"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"util/worldalllist" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){
            NSDictionary *info=[responseDic objectForKey:@"info"];
            
            NSArray *list=[info objectForKey:@"list"];
            
            self.countryCodeArr=[ContryCodeModel objectArrayWithKeyValuesArray:list];
            
            [self.contryCodeTableView reloadData];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.countryCodeArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell  *cell  = [self.contryCodeTableView dequeueReusableCellWithIdentifier: @"countryCodeCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"countryCodeCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ContryCodeModel *model = self.countryCodeArr[indexPath.row];
    UILabel *country=[[UILabel alloc]init];
    [country setFont:[UIFont systemFontOfSize:30]];
    country.textColor=[UIColor colorWithHexString:@"#00A6A6"];
    country.text=model.country;
    [cell.contentView addSubview:country];
    [country mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(cell.contentView.mas_centerY);
        make.left.mas_equalTo(50*WSCALE);
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    return 135*HSCALE;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ContryCodeModel *model = self.countryCodeArr[indexPath.row];
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ForgrtPasswordViewController class]]) {
            
            ForgrtPasswordViewController *VC=(ForgrtPasswordViewController *)controller;
            
            [VC.telZoneButton setTitle:model.phone_code forState:UIControlStateNormal];
            VC.contryModel=model;
            
            [self.navigationController popToViewController:VC animated:YES];
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
