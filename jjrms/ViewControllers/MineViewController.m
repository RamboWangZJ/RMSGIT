//
//  MineViewController.m
//  jjrms
//
//  Created by user on 16/9/23.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "MineViewController.h"
#import "AboutViewController.h"
#import "FeedbackViewController.h"
@interface MineViewController ()

@end

@implementation MineViewController
{
    //UIView *_headView;
    UIImageView *_headImageView;

    UITableView *_listTableView;
    UIImageView *_headIcon;
    UIImageView *_jiantou;
    UIButton *_toDetailBT;
    UIButton *_clearBT;
    UILabel *_tel;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor clearColor];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{

    _headImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bei"]];
    _headImageView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 400*HSCALE);
    _headImageView.userInteractionEnabled=YES;
    
    
    _headIcon=[[UIImageView alloc]init];
    _headIcon.image=[UIImage imageNamed:@"toux2"];
    [_headImageView addSubview:_headIcon];
    [_headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(132*WSCALE, 132*HSCALE));
        make.centerX.mas_equalTo(_headImageView.mas_centerX);
        make.top.mas_equalTo(120*HSCALE);
    }];
    
    _toDetailBT=[UIButton buttonWithType:UIButtonTypeCustom];
    [_toDetailBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _toDetailBT.titleLabel.font=[UIFont systemFontOfSize:15];
    [_toDetailBT setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_toDetailBT setTitle:@"鲸鲸" forState:UIControlStateNormal];
    [_toDetailBT addTarget:self action:@selector(toDetailAction) forControlEvents:UIControlEventTouchUpInside];
    [_headImageView addSubview:_toDetailBT];
    [_toDetailBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(28*HSCALE);
        make.bottom.mas_equalTo(-80*HSCALE);
        make.centerX.mas_equalTo(_headImageView.mas_centerX);
    }];
    
    
    _clearBT=[UIButton buttonWithType:UIButtonTypeCustom];
    [_clearBT addTarget:self action:@selector(toDetailAction) forControlEvents:UIControlEventTouchUpInside];
    [_headImageView addSubview:_clearBT];
    [_clearBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(132*WSCALE, 200*HSCALE));
        make.centerX.mas_equalTo(_headImageView.mas_centerX);
        make.top.mas_equalTo(120*HSCALE);
    }];
    
    
    _jiantou=[[UIImageView alloc]init];
    _jiantou.image=[UIImage imageNamed:@"jin"];
    [_headImageView addSubview:_jiantou];
    [_jiantou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10*WSCALE, 18*HSCALE));
        make.left.mas_equalTo(_toDetailBT.mas_right).offset(6*WSCALE);
        make.centerY.mas_equalTo(_toDetailBT.mas_centerY);
    }];
    
    _listTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _listTableView.delegate=self;
    _listTableView.dataSource=self;
    _listTableView.tableHeaderView = _headImageView;
    _listTableView.scrollEnabled=NO;
    //_listTableView.separatorStyle = NO;
   _listTableView.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    [self.view addSubview:_listTableView];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        UILabel *txt=[[UILabel alloc]init];
        txt.text=NSLocalizedString(@"about_my",nil);
        txt.textAlignment=NSTextAlignmentLeft;
        txt.textColor=[UIColor colorWithHexString:@"#666666"];
        txt.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:txt];
        [txt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(32*HSCALE);
            make.left.mas_equalTo(30*WSCALE);
            make.height.mas_equalTo(30*HSCALE);
        }];
        
        
        return cell;
    }else {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        UILabel *txt=[[UILabel alloc]init];
        txt.text=NSLocalizedString(@"telkefu_my",nil);
        txt.textAlignment=NSTextAlignmentLeft;
        txt.textColor=[UIColor colorWithHexString:@"#666666"];
        txt.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:txt];
        [txt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(32*HSCALE);
            make.left.mas_equalTo(30*WSCALE);
            make.height.mas_equalTo(30*HSCALE);
        }];
        
        _tel=[[UILabel alloc]init];
        //tel.text=@"133224433222";
        _tel.textAlignment=NSTextAlignmentRight;
        _tel.textColor=[UIColor colorWithHexString:@"#999999"];
        _tel.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:_tel];
        [_tel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10*WSCALE);
            make.centerY.mas_equalTo(txt.mas_centerY);
            make.height.mas_equalTo(25*HSCALE);
        }];
        
        NSDictionary *dic=@{};
        NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
        NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"util/tel" timeString:dateStr];
        [[httpManager sharedManager]httpWithURL:@"util/tel" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
            
            NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
            if (status==1){
                NSDictionary *dic=[responseDic objectForKey:@"info"];
                _tel.text=[dic objectForKey:@"tel"];
            }
            
        } failure:^(NSError *error) {
            
        }];
        
        return cell;
    }
}

 


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    return 90*HSCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        AboutViewController *vc=[[AboutViewController alloc]init];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row==1) {
        
        if (_tel) {
            UIWebView*callWebview =[[UIWebView alloc] init];
            NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_tel.text]];
            [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
            //记得添加到view上
            [self.view addSubview:callWebview];
            
        }else{
            
            NSDictionary *dic=@{};
            NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
            NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"util/tel" timeString:dateStr];
            [[httpManager sharedManager]httpWithURL:@"util/tel" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
                
                NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
                if (status==1){
                    NSDictionary *dic=[responseDic objectForKey:@"info"];
                    UIWebView*callWebview =[[UIWebView alloc] init];
                    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[dic objectForKey:@"tel"]]];
                    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
                    //记得添加到view上
                    [self.view addSubview:callWebview];
                }
                
            } failure:^(NSError *error) {
                
                
            }];
            
            
        }
        

    }
    
    if (indexPath.row==2) {
        FeedbackViewController *vc=[[FeedbackViewController alloc]init];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)toDetailAction{
    MineDetailViewController *vc=[[MineDetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed=YES;
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
