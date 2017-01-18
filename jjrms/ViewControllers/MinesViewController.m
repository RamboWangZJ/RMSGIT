//
//  MinesViewController.m
//  jjrms
//
//  Created by user on 2016/11/15.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "MinesViewController.h"
#import "AboutViewController.h"
@interface MinesViewController ()

@end

@implementation MinesViewController
{
    UILabel *_name;
    UIImageView *_headIcon;
    UIButton *_infoBtn;
    UIView *_lineone;
    UITableView *_listTableView;

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBarView.hidden=YES;
    [self initUI];
}

-(void)initUI{
    
    _name=[[UILabel alloc]init];
    _name.text=@"——";
    _name.textColor=[UIColor colorWithHexString:@"#555555"];
    [_name setFont:[UIFont fontWithName:CUTI size:24]];
    _name.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(160*HSCALE);
        make.left.mas_equalTo(52*WSCALE);
    }];
    
    
    _headIcon=[[UIImageView alloc]init];
    _headIcon.image=[UIImage imageNamed:@"touxiang"];
    [self.view addSubview:_headIcon];
    [_headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*WSCALE, 100*HSCALE));
        make.right.mas_equalTo(-50*WSCALE);
        make.top.mas_equalTo(144*HSCALE);
    }];
    
    _infoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_infoBtn setTitle:NSLocalizedString(@"chakanziliao_my",nil) forState:UIControlStateNormal];
    [_infoBtn addTarget:self action:@selector(infoAction) forControlEvents:UIControlEventTouchUpInside];
    [_infoBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
    _infoBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [_infoBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.view addSubview:_infoBtn];
    [_infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_name.mas_left);
        make.top.mas_equalTo(_name.mas_bottom).offset(60*HSCALE);
    }];
    
    
    _listTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 344*HSCALE, SCREEN_WIDTH, 132*2*HSCALE) style:UITableViewStylePlain];
    _listTableView.delegate=self;
    _listTableView.dataSource=self;
    _listTableView.scrollEnabled=NO;
    _listTableView.separatorStyle = NO;//无边线
    _listTableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_listTableView];
    
    
    _lineone=[[UIView alloc]init];
    _lineone.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [self.view addSubview:_lineone];
    [_lineone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(97*WSCALE, 2*HSCALE));
        make.left.mas_equalTo(50*WSCALE);
        make.bottom.mas_equalTo(_listTableView.mas_top);
    }];
    
    [self initData];
    
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
            _name.text=family_name;

        }
        
    } failure:^(NSError *error) {
        
        
    }];

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
        UILabel *txt=[[UILabel alloc]init];
        txt.text=NSLocalizedString(@"qianbao_my",nil);
        txt.textAlignment=NSTextAlignmentLeft;
        txt.textColor=[UIColor colorWithHexString:@"#555555"];
        txt.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:txt];
        [txt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50*HSCALE);
            make.left.mas_equalTo(52*WSCALE);
        }];
        
        UIImageView *img=[[UIImageView alloc]init];
        img.image=[UIImage imageNamed:@"qianb"];
        [cell.contentView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(42*WSCALE, 42*HSCALE));
            make.centerY.mas_equalTo(txt.mas_centerY);
            make.right.mas_equalTo(-52*WSCALE);
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
    }else {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *txt=[[UILabel alloc]init];
        txt.text=NSLocalizedString(@"about_my",nil);
        txt.textAlignment=NSTextAlignmentLeft;
        txt.textColor=[UIColor colorWithHexString:@"#555555"];
        txt.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:txt];
        [txt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50*HSCALE);
            make.left.mas_equalTo(53*WSCALE);
        }];
        

        UIImageView *img=[[UIImageView alloc]init];
        img.image=[UIImage imageNamed:@"guany"];
        [cell.contentView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(42*WSCALE, 42*HSCALE));
            make.centerY.mas_equalTo(txt.mas_centerY);
            make.right.mas_equalTo(-52*WSCALE);
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
    }
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    return 128*HSCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        WalletViewController *vc=[[WalletViewController alloc]init];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row==1) {
        
        AboutViewController *vc=[[AboutViewController alloc]init];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    

}






-(void)infoAction{
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
