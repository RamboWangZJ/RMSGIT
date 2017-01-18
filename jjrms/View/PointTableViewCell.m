//
//  PointTableViewCell.m
//  jjrms
//
//  Created by user on 16/11/2.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "PointTableViewCell.h"

@implementation PointTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // cell页面布局
        [self initCell];
    }
    return self;
}


-(void)initCell{
    /*
    self.icon=[[UIImageView alloc]init];
    [self.contentView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(88*WSCALE, 88*HSCALE));
        make.top.mas_equalTo(180*HSCALE);
        //make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.left.mas_equalTo(276*WSCALE);
    }];

    
    self.txt=[[UILabel alloc]init];
    self.txt.textAlignment=NSTextAlignmentCenter;
    self.txt.textColor=[UIColor colorWithHexString:@"#aaaaaa"];
    self.txt.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.txt];
    [self.txt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.icon.mas_bottom).offset(30*HSCALE);
        make.centerX.mas_equalTo(self.icon.mas_centerX);
        make.height.mas_equalTo(26*HSCALE);
    }];
     */
    __weak typeof(self) weakSelf = self;

    self.txt1=[[UILabel alloc]init];
    self.txt1.textAlignment=NSTextAlignmentCenter;
    self.txt1.textColor=[UIColor colorWithHexString:@"#555555"];
    self.txt1.font=[UIFont systemFontOfSize:17];
    [self.contentView addSubview:self.txt1];
    [self.txt1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(236*HSCALE);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(34*HSCALE);
    }];
    
    self.txt2=[[UILabel alloc]init];
    self.txt2.textAlignment=NSTextAlignmentCenter;
    self.txt2.textColor=[UIColor colorWithHexString:@"#999999"];
    self.txt2.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.txt2];
    [self.txt2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.txt1.mas_bottom).offset(50*HSCALE);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(30*HSCALE);
    }];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
