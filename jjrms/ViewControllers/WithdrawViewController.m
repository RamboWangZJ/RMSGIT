//
//  WithdrawViewController.m
//  jjrms
//
//  Created by user on 2016/11/21.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "WithdrawViewController.h"
#import "AccountsModel.h"
#import "AccCheckTableViewCell.h"
#import "Withdraw2ViewController.h"
@interface WithdrawViewController ()

@end

@implementation WithdrawViewController

static NSString *AccCheckCell = @"AccCheckTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBarView.backBut.hidden=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    self.navBarView.titleLab.text=NSLocalizedString(@"xuanzetixian_tit",nil);
    if (iPhone5) {
        [self.navBarView.titleLab setFont:[UIFont fontWithName:CUTI size:18]];
    }else{
        [self.navBarView.titleLab setFont:[UIFont fontWithName:CUTI size:23]];
    }

    self.navBarView.lineView.hidden=YES;
    
    [self initUI];
}

-(void)initUI{
    
    self.checkArr=[[NSMutableArray alloc]init];
    
    
    self.checkTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.navBarView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-self.navBarView.frame.size.height) style:UITableViewStylePlain];
    self.checkTableView.delegate=self;
    self.checkTableView.dataSource=self;
    self.checkTableView.separatorStyle = NO;//无边线
    self.checkTableView.tableFooterView = [UIView new];
    self.checkTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.checkTableView];
    [self.checkTableView registerClass:[AccCheckTableViewCell class] forCellReuseIdentifier:AccCheckCell];
    
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    dic=@{@"page_size":@100,@"current_page":@1};
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"cashaccount/myaccountlist" timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"cashaccount/myaccountlist" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){
            
            NSDictionary *info=[responseDic objectForKey:@"info"];
            NSArray *listArr=[info objectForKey:@"list"];
            self.checkArr = [AccountsModel objectArrayWithKeyValuesArray:listArr];
            [self.checkTableView reloadData];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.checkArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AccCheckTableViewCell  *cell  = [self.checkTableView dequeueReusableCellWithIdentifier: AccCheckCell];
    if (cell == nil) {
        cell = [[AccCheckTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AccCheckCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model=self.checkArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    return 84*HSCALE;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AccountsModel *model=self.checkArr[indexPath.row];
    Withdraw2ViewController *vc=[[Withdraw2ViewController alloc]init];
    vc.model=model;
    vc.type=self.type;
    [self.navigationController pushViewController:vc animated:YES];
    //[_zhanghuNubBT setTitle:model.pay_account forState:UIControlStateNormal];
    //_id=model.id;
    //self.checkTableView.hidden=YES;
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
