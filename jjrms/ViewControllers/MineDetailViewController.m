//
//  MineDetailViewController.m
//  jjrms
//
//  Created by user on 16/10/24.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "MineDetailViewController.h"

@interface MineDetailViewController ()

@end

@implementation MineDetailViewController
{
    UITableView *_listTableView;
    UIButton *_loginOut;
    UIActionSheet *_sheet;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarView.titleLab.text=@"——";
    self.navBarView.backBut.hidden=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    
    _infoArr=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"", nil];
    [self initUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //状态栏
    /*
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor colorWithHexString:@"#343b47"];
    }*/
}


-(void)initData{
    
    NSDictionary *dic=@{};
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"user/userinfo" timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"user/userinfo" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        if (status==1){
            NSDictionary *dic=[responseDic objectForKey:@"info"];
            NSString *last_name=[dic objectForKey:@"last_name"];
            NSString *family_name=[dic objectForKey:@"family_name"];
            NSString *create_time=[dic objectForKey:@"create_time"];
            NSString *phone=[dic objectForKey:@"phone"];
            NSString *email=[dic objectForKey:@"email"];

            [_infoArr insertObject:last_name atIndex:0];
            [_infoArr insertObject:family_name atIndex:1];
            [_infoArr insertObject:create_time atIndex:2];
            [_infoArr insertObject:phone atIndex:3];
            [_infoArr insertObject:email atIndex:4];
            self.navBarView.titleLab.text=family_name;
            [_listTableView reloadData];
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    

}


-(void)initUI{
    
    _listTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 252*HSCALE, SCREEN_WIDTH, 212*2*HSCALE) style:UITableViewStyleGrouped];
    _listTableView.delegate=self;
    _listTableView.dataSource=self;
    _listTableView.scrollEnabled=NO;
    _listTableView.separatorStyle = NO;
    _listTableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_listTableView];
    
    
    
    _loginOut=[UIButton buttonWithType:UIButtonTypeCustom];
    [_loginOut setTitle:NSLocalizedString(@"tuichu_my",nil) forState:UIControlStateNormal];
    [_loginOut addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    _loginOut.backgroundColor=[UIColor whiteColor];
    
    [_loginOut setTitleColor:[UIColor colorWithHexString:@"#F06464"] forState:UIControlStateNormal];
    _loginOut.titleLabel.font=[UIFont systemFontOfSize:15];
    [_loginOut setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.view addSubview:_loginOut];
    [_loginOut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(56*WSCALE);
        make.top.mas_equalTo(382*2*HSCALE);
    }];
    
    
    
    [self initData];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView=[[UIView alloc]init];
    headView.backgroundColor=[UIColor whiteColor];
    UILabel *lab=[[UILabel alloc]init];
    lab.textColor=[UIColor colorWithHexString:@"#555555"];
    [lab setFont:[UIFont systemFontOfSize:15]];
    lab.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(54*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
    }];
    
    if (section==0) {
        lab.text=NSLocalizedString(@"gerenxinxi_my",nil);
    }
    
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 108*HSCALE;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *txt=[[UILabel alloc]init];
        txt.text=NSLocalizedString(@"time_my",nil);
        txt.textAlignment=NSTextAlignmentLeft;
        txt.textColor=[UIColor colorWithHexString:@"#999999"];
        txt.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:txt];
        [txt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.mas_centerY);
            make.left.mas_equalTo(50*WSCALE);
            make.height.mas_equalTo(28*HSCALE);
        }];
        
        UILabel *txt2=[[UILabel alloc]init];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyy.MM.dd"];//@"yyyy-MM-dd-HHMMss"
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:[_infoArr[2] doubleValue]];
        NSString* dateString = [formatter stringFromDate:date];
        txt2.text=[NSString stringWithFormat:@"%@", dateString];
        txt2.textAlignment=NSTextAlignmentLeft;
        txt2.textColor=[UIColor colorWithHexString:@"#555555"];
        txt2.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:txt2];
        [txt2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.mas_centerY);
            make.right.mas_equalTo(-50*WSCALE);
        }];
        
        UIView *line=[[UIView alloc]init];
        line.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
        [cell.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(540*WSCALE, 2*HSCALE));
            make.left.mas_equalTo(50*WSCALE);
            make.bottom.mas_equalTo(-2*HSCALE);
        }];
        
        return cell;

        }else if(indexPath.row==1){
            UITableViewCell *cell=[[UITableViewCell alloc]init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *txt=[[UILabel alloc]init];
            txt.text=NSLocalizedString(@"tel_my",nil);
            txt.textAlignment=NSTextAlignmentLeft;
            txt.textColor=[UIColor colorWithHexString:@"#999999"];
            txt.font=[UIFont systemFontOfSize:15];
            [cell.contentView addSubview:txt];
            [txt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell.mas_centerY);
                make.left.mas_equalTo(50*WSCALE);
            }];
            
            UILabel *txt2=[[UILabel alloc]init];
            txt2.text=_infoArr[3];
            txt2.textAlignment=NSTextAlignmentLeft;
            txt2.textColor=[UIColor colorWithHexString:@"#555555"];
            txt2.font=[UIFont systemFontOfSize:15];
            [cell.contentView addSubview:txt2];
            [txt2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell.mas_centerY);
                make.right.mas_equalTo(-50*WSCALE);
            }];
            
            UIView *line=[[UIView alloc]init];
            line.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
            [cell.contentView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(540*WSCALE, 2*HSCALE));
                make.left.mas_equalTo(50*WSCALE);
                make.bottom.mas_equalTo(-2*HSCALE);
            }];
            
            return cell;
    }else{
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *txt=[[UILabel alloc]init];
        txt.text=NSLocalizedString(@"email_my",nil);
        txt.textAlignment=NSTextAlignmentLeft;
        txt.textColor=[UIColor colorWithHexString:@"#999999"];
        txt.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:txt];
        [txt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.mas_centerY);
            make.left.mas_equalTo(50*WSCALE);
        }];
        
        UILabel *txt2=[[UILabel alloc]init];
        txt2.text=_infoArr[4];
        
        txt2.textAlignment=NSTextAlignmentLeft;
        txt2.textColor=[UIColor colorWithHexString:@"#555555"];
        txt2.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:txt2];
        [txt2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.mas_centerY);
            make.right.mas_equalTo(-50*WSCALE);
        }];

        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    return 108*HSCALE;
}


#pragma 退出登录
-(void)loginAction{
    
    _sheet=[[UIActionSheet alloc]initWithTitle:NSLocalizedString(@"querentuichu_my",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"qvxiao",nil) destructiveButtonTitle:NSLocalizedString(@"queren",nil) otherButtonTitles:nil, nil];
    [_sheet showInView:self.view];
    /*
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:ACCESS_TOKEN];
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:USER_SN];

    //是否需要强制登录
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:FORCIBLY_LOGIN];

    
    LoginViewController *login=[[LoginViewController alloc]init];
    UINavigationController *NaVC1=[[UINavigationController alloc]initWithRootViewController:login];
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    window.rootViewController=NaVC1;
    [window makeKeyAndVisible];
     */
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [[NSUserDefaults standardUserDefaults]setValue:nil forKey:ACCESS_TOKEN];
        [[NSUserDefaults standardUserDefaults]setValue:nil forKey:USER_SN];
        
        //是否需要强制登录
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:FORCIBLY_LOGIN];
        
        
        LoginViewController *login=[[LoginViewController alloc]init];
        UINavigationController *NaVC1=[[UINavigationController alloc]initWithRootViewController:login];
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        window.rootViewController=NaVC1;
        [window makeKeyAndVisible];
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
