//
//  HousesSourceViewController.m
//  jjrms
//
//  Created by user on 16/9/23.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "HousesSourceViewController.h"

@interface HousesSourceViewController ()<UIScrollViewDelegate>

@end

@implementation HousesSourceViewController
{
    NavBarView *_navBarView;
    UIView *_topView;
    UIButton *_butAll;
    UIButton *_but1;
    UIButton *_but2;
    UIButton *_but3;
    UIButton *_but4;
    UIView *_lineView;
    BaseScrollView *_bottomScroll;
    UIViewController *currentVC;
    
    UIScrollView *_TOPScroll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarView.titleLab.text=NSLocalizedString(@"fangyuan_ho",nil);
    [self initUI];
}


-(void)titleButAction:(UIButton *)but{
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
    for (int i=0; i<5; i++) {
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
    for (int i=0; i<5; i++) {
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
    for (int i=0; i<5; i++) {
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
    for (int i=0; i<5; i++) {
        UIButton *button = (UIButton *)[_TOPScroll viewWithTag:1000+i];
        if (button.tag!=1004) {
            [button setSelected:NO];
        }
    }
    _bottomScroll.contentOffset=CGPointMake(SCREEN_WIDTH*4, 0);
    
}



-(void)initUI {
    
    
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

    
    NSMutableArray *titleArr=[[NSMutableArray alloc]initWithObjects:NSLocalizedString(@"quanbu_hs",nil),NSLocalizedString(@"shenhezhong_hs",nil),NSLocalizedString(@"yibohui_hs",nil),NSLocalizedString(@"yishangxian_hs",nil),NSLocalizedString(@"yixiaxian_hs",nil), nil];
    
    
    for (int i=0; i<titleArr.count; i++) {
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        NSString *butTitle=titleArr[i];
        [but setTitle:butTitle forState:UIControlStateNormal];//设置文字之后，button宽度依然是0
        [but addTarget:self action:@selector(titleButAction:) forControlEvents:UIControlEventTouchUpInside];
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
    

    _bottomScroll=[[BaseScrollView alloc]init];
    _bottomScroll.contentSize=CGSizeMake(SCREEN_WIDTH*5, SCREEN_HEIGHT-80*HSCALE-64);
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
    
    //[[self screenEdgePanGestureRecognizer] requireGestureRecognizerToFail:_bottomScroll.panGestureRecognizer];
    //[_bottomScroll.panGestureRecognizer requireGestureRecognizerToFail:[self screenEdgePanGestureRecognizer]] ;

    
    ChildTableViewController * table1 = [[ChildTableViewController alloc] init];
    [self addChildViewController:table1];
    table1.status=9999;
    [table1.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, _bottomScroll.frame.size.height)];
    
    
    ChildTableViewController *table2 = [[ChildTableViewController alloc] init];
    [self addChildViewController:table2];
    table2.status=10;
    [table2.view setFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, _bottomScroll.frame.size.height)];
    
    
    ChildTableViewController *table3 = [[ChildTableViewController alloc] init];
    [self addChildViewController:table3];
    table3.status=20;
    [table3.view setFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, _bottomScroll.frame.size.height)];
    
    
    ChildTableViewController *table4 = [[ChildTableViewController alloc] init];
    [self addChildViewController:table4];
    table4.status=30;
    [table4.view setFrame:CGRectMake(SCREEN_WIDTH*3, 0, SCREEN_WIDTH, _bottomScroll.frame.size.height)];
    
    
    ChildTableViewController *table5 = [[ChildTableViewController alloc] init];
    [self addChildViewController:table5];
    table5.status=40;
    [table5.view setFrame:CGRectMake(SCREEN_WIDTH*4, 0, SCREEN_WIDTH, _bottomScroll.frame.size.height)];

    [_bottomScroll addSubview:table1.view];
    [_bottomScroll addSubview:table2.view];
    [_bottomScroll addSubview:table3.view];
    [_bottomScroll addSubview:table4.view];
    [_bottomScroll addSubview:table5.view];
    
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
