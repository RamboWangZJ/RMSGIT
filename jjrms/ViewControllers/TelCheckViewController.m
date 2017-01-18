//
//  TelCheckViewController.m
//  jjrms
//
//  Created by user on 2016/11/17.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "TelCheckViewController.h"

@interface TelCheckViewController ()

@end

@implementation TelCheckViewController
{
    UIButton *_china;
    UIButton *_japan;
    UIButton *_usa;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak typeof(self) weakSelf = self;

    self.navBarView.backBut.hidden=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    self.navBarView.titleLab.text=NSLocalizedString(@"telcheck_lg",nil);
    self.navBarView.lineView.hidden=YES;
    
    _countryCodeArr=[[NSMutableArray alloc]init];
    [self initUI];
    /*
    _china=[UIButton buttonWithType:UIButtonTypeCustom];
    [_china setTitle:NSLocalizedString(@"china_lg",nil) forState:UIControlStateNormal];
    [_china addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
    [_china setTitleColor:[UIColor colorWithHexString:@"#00A6A6"] forState:UIControlStateNormal];
    _china.titleLabel.font=[UIFont fontWithName:CUTI size:18];
    [_china setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.view addSubview:_china];
    [_china mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.navBarView.mas_bottom).offset(60*HSCALE);
        make.height.mas_equalTo(40*HSCALE);
        make.left.mas_equalTo(60*WSCALE);
    }];
    
    _japan=[UIButton buttonWithType:UIButtonTypeCustom];
    [_japan setTitle:NSLocalizedString(@"japan_lg",nil) forState:UIControlStateNormal];
    [_japan addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
    [_japan setTitleColor:[UIColor colorWithHexString:@"#00A6A6"] forState:UIControlStateNormal];
    _japan.titleLabel.font=[UIFont fontWithName:CUTI size:18];
    [_japan setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.view addSubview:_japan];
    [_japan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_china.mas_bottom).offset(50*HSCALE);
        make.height.mas_equalTo(40*HSCALE);
        make.left.mas_equalTo(60*WSCALE);
    }];
    
    _usa=[UIButton buttonWithType:UIButtonTypeCustom];
    [_usa setTitle:NSLocalizedString(@"usa_lg",nil) forState:UIControlStateNormal];
    [_usa addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
    [_usa setTitleColor:[UIColor colorWithHexString:@"#00A6A6"] forState:UIControlStateNormal];
    _usa.titleLabel.font=[UIFont fontWithName:CUTI size:18];
    [_usa setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.view addSubview:_usa];
    [_usa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_japan.mas_bottom).offset(50*HSCALE);
        make.height.mas_equalTo(40*HSCALE);
        make.left.mas_equalTo(60*WSCALE);
    }];
    
    _china.tag=10001;
    _japan.tag=10002;
    _usa.tag=10003;
    
    //self.returnTextBlock(@"bbb");
    //[self.navigationController popViewControllerAnimated:YES];
     */
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
        if ([controller isKindOfClass:[LoginViewController class]]) {
            
            LoginViewController *VC=(LoginViewController *)controller;
            
            [VC.telZoneButton setTitle:model.phone_code forState:UIControlStateNormal];
            VC.contryModel=model;
            
            [self.navigationController popToViewController:VC animated:YES];
        }
    }
}

-(void)checkAction:(UIButton *)btn{
    NSString *str=@"";
    if (btn.tag==10001) {
        str=@"+86";
    }
    if (btn.tag==10002) {
        str=@"+10";
    }
    if (btn.tag==10003) {
        str=@"+00";
    }
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[LoginViewController class]]) {
            
            LoginViewController *VC=(LoginViewController *)controller;
            //[VC.telZoneButton setTitle:str forState:UIControlStateNormal];

            [self.navigationController popToViewController:VC animated:YES];
        }
    }
    //self.returnloginTextBlock(str);
    //[self.navigationController popViewControllerAnimated:YES];
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
