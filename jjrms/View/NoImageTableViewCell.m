//
//  NoImageTableViewCell.m
//  jjrms
//
//  Created by user on 16/10/26.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "NoImageTableViewCell.h"

@implementation NoImageTableViewCell
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

-(void)initCell {
    
    __weak typeof(self) weakSelf = self;
    
    
    
    self.titleLB2=[[UILabel alloc]init];
    self.titleLB2.textColor=[UIColor blackColor];
    self.titleLB2.font=[UIFont systemFontOfSize:15];
    self.titleLB2.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLB2];
    [self.titleLB2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30*HSCALE);
        make.size.mas_equalTo(CGSizeMake(580*WSCALE, 68*HSCALE));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
    
    
    self.timeLB=[[UILabel alloc]init];
    self.timeLB.textColor=[UIColor blackColor];
    self.timeLB.font=[UIFont systemFontOfSize:12];
    self.timeLB.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:self.timeLB];
    [self.timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLB2.mas_bottom).offset(20*HSCALE);
        make.height.mas_equalTo(30*HSCALE);
        make.left.mas_equalTo(58*WSCALE);
    }];
    
    
    self.DetailLB=[[UILabel alloc]init];
    self.DetailLB.textColor=[UIColor blackColor];
    self.DetailLB.font=[UIFont systemFontOfSize:15];
    self.DetailLB.numberOfLines=0;
    [self.contentView addSubview:self.DetailLB];
    [self.DetailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-52*HSCALE);
        make.bottom.mas_equalTo(-30*HSCALE);
        make.left.mas_equalTo(52*WSCALE);
        make.height.mas_equalTo(130*HSCALE);
    }];
    
    self.lineView=[[UIView alloc]init];
    self.lineView.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(2*HSCALE);
        make.left.mas_equalTo(54*WSCALE);
        make.right.mas_equalTo(-54*WSCALE);
        make.bottom.mas_equalTo(-2*HSCALE);
    }];
}


-(void)setModel:(NewsModel *)model{
    
    
    _titleLB2.text=model.notice_title;
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];//@"yyyy-MM-dd-HHMMss"
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[model.create_time doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    
    _timeLB.text=dateString;
    
    _DetailLB.text=model.summary;
    
    
    //[self layoutIfNeeded];
    
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
