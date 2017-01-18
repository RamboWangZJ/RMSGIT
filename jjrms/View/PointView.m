//
//  PointView.m
//  jjrms
//
//  Created by user on 16/9/28.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "PointView.h"
#import "UIColor+Helper.h"
@implementation PointView


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
    
}

-(void)initView{
    self.backgroundColor=[UIColor whiteColor];
    //__weak typeof(self) weakSelf = self;
    /*
    self.icon=[[UIImageView alloc]init];
    [self addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(88*WSCALE, 88*HSCALE));
        make.top.mas_equalTo(180*HSCALE);
        //make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.left.mas_equalTo(276*WSCALE);
    }];
     */
    self.iconBT=[UIButton buttonWithType:UIButtonTypeCustom];
    //self.iconBT setBackgroundImage:[UIImage imageNamed:@""] forState:<#(UIControlState)#>
    [self addSubview:self.iconBT];
    [self.iconBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(88*WSCALE, 88*HSCALE));
        make.top.mas_equalTo(180*HSCALE);
        make.left.mas_equalTo(276*WSCALE);
    }];
    
    self.txt=[[UILabel alloc]init];
    self.txt.textAlignment=NSTextAlignmentCenter;
    self.txt.textColor=[UIColor colorWithHexString:@"#aaaaaa"];
    self.txt.font=[UIFont systemFontOfSize:15];
    [self addSubview:self.txt];
    [self.txt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconBT.mas_bottom).offset(30*HSCALE);
        make.centerX.mas_equalTo(self.iconBT.mas_centerX);
        make.height.mas_equalTo(26*HSCALE);
    }];
    
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    
    
}



@end
