//
//  OrderViewController.m
//  jjrms
//
//  Created by user on 16/9/23.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "OrderViewController.h"

@interface OrderViewController ()

@end

@implementation OrderViewController
{
    UIView *_topView;
    UIButton *_butAll;
    UIButton *_but1;
    UIButton *_but2;
    UIButton *_but3;
    UIButton *_but4;
    UIView *_lineView;
    BaseScrollView *_bottomScroll;
    UIViewController *currentVC;
    
    ChildOrderTableViewController  *_table1;
    //ChildOrderTableViewController  *_table2;
    ChildOrderTableViewController  *_table3;
    ChildOrderTableViewController  *_table4;
    ChildOrderTableViewController  *_table5;
    ChildOrderTableViewController  *_table6;


    UIScrollView *_TOPScroll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBarView.titleLab.text=NSLocalizedString(@"dingdan_ho",nil);
    [self initUI];

}

-(void)ortitleButAction:(UIButton *)but{
    
    but.selected=!but.selected;

    switch (but.tag) {
        case 1000:
            [self butAllChang];//字体颜色、下划线位置、scroll滑动偏移量
            break;
        case 1001:
            [self but1Chang];
            break;
        case 1002:
            [self but2Chang];
            break;
        case 1003:
            [self but3Chang];
            break;
        case 1004:
            [self but4Chang];
            break;
        case 1005:
            [self but5Chang];
            break;
        default:
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
        if (scrollView==_bottomScroll) {
            
            if (scrollView.contentOffset.x==0) {
                _TOPScroll.contentOffset=CGPointMake(0, 0);
                [self butAllChang];
            }else if (scrollView.contentOffset.x==SCREEN_WIDTH){
                [self but1Chang];
            }else if (scrollView.contentOffset.x==SCREEN_WIDTH*2){
                [self but2Chang];
            }else if (scrollView.contentOffset.x==SCREEN_WIDTH*3){
                [self but3Chang];
            }else if(scrollView.contentOffset.x==SCREEN_WIDTH*4){
                _TOPScroll.contentOffset=CGPointMake(_TOPScroll.contentSize.width-SCREEN_WIDTH, 0);
                [self but4Chang];
            }else if (scrollView.contentOffset.x==SCREEN_WIDTH*5){
                [self but5Chang];
            }else {
                
            }
        }
}








-(void)butAllChang {
    
    UIButton *button1 = (UIButton *)[_TOPScroll viewWithTag:1000];
    
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.frame = CGRectMake(button1.frame.origin.x, 76*HSCALE, button1.frame.size.width, 4*HSCALE);
        
    } completion:^(BOOL finished) {
        
    }];
    //_lineView.frame=CGRectMake(button1.frame.origin.x, 76*HSCALE, button1.frame.size.width, 4*HSCALE);
    for (int i=0; i<5; i++) {
        UIButton *button = (UIButton *)[_TOPScroll viewWithTag:1000+i];
        if (button.tag!=1000) {
            [button setSelected:NO];
        }
    }
    _bottomScroll.contentOffset=CGPointMake(0, 0);
}
-(void)but1Chang {
    UIButton *button1 = (UIButton *)[_TOPScroll viewWithTag:1001];
    
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.frame = CGRectMake(button1.frame.origin.x, 76*HSCALE, button1.frame.size.width, 4*HSCALE);
        
    } completion:^(BOOL finished) {
        
    }];
    //_lineView.frame=CGRectMake(button1.frame.origin.x, 76*HSCALE, button1.frame.size.width, 4*HSCALE);
    for (int i=0; i<6; i++) {
        UIButton *button = (UIButton *)[_TOPScroll viewWithTag:1000+i];
        if (button.tag!=1001) {
            [button setSelected:NO];
        }
    }
    _bottomScroll.contentOffset=CGPointMake(SCREEN_WIDTH, 0);
    
}
-(void)but2Chang {
    UIButton *button1 = (UIButton *)[_TOPScroll viewWithTag:1002];
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.frame = CGRectMake(button1.frame.origin.x, 76*HSCALE, button1.frame.size.width, 4*HSCALE);
        
    } completion:^(BOOL finished) {
        
    }];
    //_lineView.frame=CGRectMake(button1.frame.origin.x, 76*HSCALE, button1.frame.size.width, 4*HSCALE);
    for (int i=0; i<6; i++) {
        UIButton *button = (UIButton *)[_TOPScroll viewWithTag:1000+i];
        if (button.tag!=1002) {
            [button setSelected:NO];
        }
    }
    _bottomScroll.contentOffset=CGPointMake(SCREEN_WIDTH*2, 0);
}
-(void)but3Chang {
    UIButton *button1 = (UIButton *)[_TOPScroll viewWithTag:1003];
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.frame = CGRectMake(button1.frame.origin.x, 76*HSCALE, button1.frame.size.width, 4*HSCALE);
        
    } completion:^(BOOL finished) {
        
    }];
    //_lineView.frame=CGRectMake(button1.frame.origin.x, 76*HSCALE, button1.frame.size.width, 4*HSCALE);
    for (int i=0; i<6; i++) {
        UIButton *button = (UIButton *)[_TOPScroll viewWithTag:1000+i];
        if (button.tag!=1003) {
            [button setSelected:NO];
        }
    }
    _bottomScroll.contentOffset=CGPointMake(SCREEN_WIDTH*3, 0);
    
}
-(void)but4Chang {
    UIButton *button1 = (UIButton *)[_TOPScroll viewWithTag:1004];
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.frame = CGRectMake(button1.frame.origin.x, 76*HSCALE, button1.frame.size.width, 4*HSCALE);
        
    } completion:^(BOOL finished) {
        
    }];
    // _lineView.frame=CGRectMake(button1.frame.origin.x, 76*HSCALE, button1.frame.size.width, 4*HSCALE);
    for (int i=0; i<6; i++) {
        UIButton *button = (UIButton *)[_TOPScroll viewWithTag:1000+i];
        if (button.tag!=1004) {
            [button setSelected:NO];
        }
    }
    _bottomScroll.contentOffset=CGPointMake(SCREEN_WIDTH*4, 0);
    
}

-(void)but5Chang {
    UIButton *button1 = (UIButton *)[_TOPScroll viewWithTag:1005];
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.frame = CGRectMake(button1.frame.origin.x, 76*HSCALE, button1.frame.size.width, 4*HSCALE);
        
    } completion:^(BOOL finished) {
        
    }];
    // _lineView.frame=CGRectMake(button1.frame.origin.x, 76*HSCALE, button1.frame.size.width, 4*HSCALE);
    for (int i=0; i<6; i++) {
        UIButton *button = (UIButton *)[_TOPScroll viewWithTag:1000+i];
        if (button.tag!=1005) {
            [button setSelected:NO];
        }
    }
    _bottomScroll.contentOffset=CGPointMake(SCREEN_WIDTH*5, 0);
    
}

-(void)initUI {
    /*
    _topView=[[UIView alloc]init];
    _topView.backgroundColor=[UIColor colorWithHexString:@"#fafafa"];
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(640*WSCALE, 80*HSCALE));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
    }];
    */
    /*
    _butAll=[UIButton buttonWithType:UIButtonTypeCustom];
    [_butAll setTitle:NSLocalizedString(@"quanbu_or",nil) forState:UIControlStateNormal];
    [_butAll addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    [_butAll setTitleColor:[UIColor colorWithHexString:@"#64b8f0"] forState:UIControlStateNormal];
    _butAll.tag=1001;
    [_butAll setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_topView addSubview:_butAll];

    
    _but1=[UIButton buttonWithType:UIButtonTypeCustom];
    [_but1 setTitle:NSLocalizedString(@"daiqueren_ac",nil) forState:UIControlStateNormal];
    [_but1 addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    [_but1 setTitleColor:[UIColor colorWithHexString:@"#343b47"] forState:UIControlStateNormal];
    _but1.tag=1002;
    [_but1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_topView addSubview:_but1];

    
    _but2=[UIButton buttonWithType:UIButtonTypeCustom];
    [_but2 setTitle:NSLocalizedString(@"dairuzhu_ac",nil) forState:UIControlStateNormal];
    [_but2 addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    [_but2 setTitleColor:[UIColor colorWithHexString:@"#343b47"] forState:UIControlStateNormal];
    _but2.tag=1003;
    [_but2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_topView addSubview:_but2];

    
    _but3=[UIButton buttonWithType:UIButtonTypeCustom];
    [_but3 setTitle:NSLocalizedString(@"yiruzhu_ac",nil) forState:UIControlStateNormal];
    [_but3 addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    [_but3 setTitleColor:[UIColor colorWithHexString:@"#343b47"] forState:UIControlStateNormal];
    _but3.tag=1004;
    [_but3 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_topView addSubview:_but3];

    
    
    _but4=[UIButton buttonWithType:UIButtonTypeCustom];
    [_but4 setTitle:NSLocalizedString(@"yiwancheng_ac",nil) forState:UIControlStateNormal];
    [_but4 addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    [_but4 setTitleColor:[UIColor colorWithHexString:@"#343b47"] forState:UIControlStateNormal];
    _but4.tag=1005;
    [_but4 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_topView addSubview:_but4];

    
    
    _butAll.titleLabel.font=[UIFont systemFontOfSize:15];
    _but1.titleLabel.font=[UIFont systemFontOfSize:15];
    _but2.titleLabel.font=[UIFont systemFontOfSize:15];
    _but3.titleLabel.font=[UIFont systemFontOfSize:15];
    _but4.titleLabel.font=[UIFont systemFontOfSize:15];
    
    [_butAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*WSCALE, 26*HSCALE));
        make.left.mas_equalTo(36*WSCALE);
        make.top.mas_equalTo(25*HSCALE);
    }];
    [_but1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*WSCALE, 26*HSCALE));
        make.left.mas_equalTo(_butAll.mas_right).offset(17*WSCALE);
        make.top.mas_equalTo(_butAll.mas_top);
    }];
    [_but2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*WSCALE, 26*HSCALE));
        make.left.mas_equalTo(_but1.mas_right).offset(17*WSCALE);
        make.top.mas_equalTo(_butAll.mas_top);
    }];
    [_but3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*WSCALE, 26*HSCALE));
        make.left.mas_equalTo(_but2.mas_right).offset(17*WSCALE);
        make.top.mas_equalTo(_butAll.mas_top);
    }];
    [_but4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*WSCALE, 26*HSCALE));
        make.left.mas_equalTo(_but3.mas_right).offset(17*WSCALE);
        make.top.mas_equalTo(_butAll.mas_top);
    }];

    */
    
    _TOPScroll=[[UIScrollView alloc]init];
    _TOPScroll.backgroundColor=[UIColor colorWithHexString:@"#fafafa"];
    _TOPScroll.contentSize=CGSizeMake(SCREEN_WIDTH, 80*HSCALE);
    _TOPScroll.bounces=NO;
    _TOPScroll.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:_TOPScroll];
    [_TOPScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(640*WSCALE, 80*HSCALE));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
    }];
    
    NSMutableArray *titleArr=[[NSMutableArray alloc]initWithObjects:NSLocalizedString(@"quanbu_or",nil),NSLocalizedString(@"daiqueren_ac",nil),NSLocalizedString(@"daifukuan_ac",nil),NSLocalizedString(@"dairuzhu_ac",nil),NSLocalizedString(@"yiruzhu_ac",nil),NSLocalizedString(@"yiwancheng_ac",nil), nil];
    
    for (int i=0; i<titleArr.count; i++) {
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        NSString *butTitle=titleArr[i];
        [but setTitle:butTitle forState:UIControlStateNormal];//设置文字之后，button宽度依然是0
        [but addTarget:self action:@selector(ortitleButAction:) forControlEvents:UIControlEventTouchUpInside];
        [but setTitleColor:[UIColor colorWithHexString:@"#343b47"] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor colorWithHexString:@"#64b8f0"] forState:UIControlStateSelected];
        but.titleLabel.font=[UIFont systemFontOfSize:15];
        but.tag=1000+i;
        [but setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_TOPScroll addSubview:but];
        
        [but mas_makeConstraints:^(MASConstraintMaker *make) {
            if (but.tag==1000) {
                make.left.mas_equalTo(36*WSCALE);
            }else{
                UIButton *button = (UIButton *)[_TOPScroll viewWithTag:1000+i-1];
                make.left.mas_equalTo(button.mas_right).offset(17*WSCALE);
            }
            make.height.mas_equalTo(26*HSCALE);
            make.centerY.mas_equalTo(_TOPScroll.mas_centerY);
            make.width.mas_greaterThanOrEqualTo(100*WSCALE);//

        }];
    }
    
    //修改可滑动区域的宽度
    CGFloat contrntsize_width=0;
    for (int i=0; i<titleArr.count; i++) {
        UIButton *button = (UIButton *)[_TOPScroll viewWithTag:1000+i];
        [button layoutIfNeeded];//
        contrntsize_width += button.frame.size.width;
    }
    contrntsize_width=72*WSCALE + 17*WSCALE*4 + contrntsize_width;
    _TOPScroll.contentSize=CGSizeMake(contrntsize_width, 80*HSCALE);
    
    
    
    UIButton *button = (UIButton *)[_TOPScroll viewWithTag:1000];
    _lineView=[[UIView alloc]initWithFrame:CGRectMake(36*WSCALE,76*HSCALE, button.frame.size.width, 4*HSCALE)];
    [_TOPScroll addSubview:_lineView];
    _lineView.backgroundColor=[UIColor colorWithHexString:@"#64b8f0"];
    /*
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIButton *button = (UIButton *)[_TOPScroll viewWithTag:1000];
        NSLog(@"...%f",button.frame.size.width);
        make.size.mas_equalTo(CGSizeMake(button.frame.size.width, 10*HSCALE));
        make.left.mas_equalTo(36*WSCALE);
        make.bottom.mas_equalTo(0);
    }];
    NSLog(@"...%@",_lineView.frame);
     */
    
    _bottomScroll=[[BaseScrollView alloc]init];
    _bottomScroll.contentSize=CGSizeMake(SCREEN_WIDTH*6, SCREEN_HEIGHT-80*HSCALE-64);
    _bottomScroll.pagingEnabled=YES;
    _bottomScroll.bounces=NO;
    _bottomScroll.delegate=self;
    _bottomScroll.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:_bottomScroll];
    [_bottomScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_TOPScroll.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    

    
    
    
    _table1 = [[ChildOrderTableViewController alloc] init];
    [self addChildViewController:_table1];
    _table1.order_status=9999;
    [_table1.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, _bottomScroll.frame.size.height)];
    

    self.table2 = [[ChildOrderTableViewController alloc] init];
    [self addChildViewController:self.table2];
    self.table2.order_status=90;
    [self.table2.view setFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, _bottomScroll.frame.size.height)];
    
    
    _table3 = [[ChildOrderTableViewController alloc] init];
    [self addChildViewController:_table3];
    _table3.order_status=100;
    [_table3.view setFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, _bottomScroll.frame.size.height)];
    
    _table4 = [[ChildOrderTableViewController alloc] init];
    [self addChildViewController:_table4];
    _table4.order_status=110;
    [_table4.view setFrame:CGRectMake(SCREEN_WIDTH*3, 0, SCREEN_WIDTH, _bottomScroll.frame.size.height)];
    
    _table5 = [[ChildOrderTableViewController alloc] init];
    [self addChildViewController:_table5];
    _table5.order_status=150;
    [_table5.view setFrame:CGRectMake(SCREEN_WIDTH*4, 0, SCREEN_WIDTH, _bottomScroll.frame.size.height)];
    
    _table6 = [[ChildOrderTableViewController alloc] init];
    [self addChildViewController:_table6];
    _table6.order_status=900;
    [_table6.view setFrame:CGRectMake(SCREEN_WIDTH*5, 0, SCREEN_WIDTH, _bottomScroll.frame.size.height)];
    
    [_bottomScroll addSubview:_table1.view];
    [_bottomScroll addSubview:_table2.view];
    [_bottomScroll addSubview:_table3.view];
    [_bottomScroll addSubview:_table4.view];
    [_bottomScroll addSubview:_table5.view];
    [_bottomScroll addSubview:_table6.view];



    
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
