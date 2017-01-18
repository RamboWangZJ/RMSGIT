//
//  NewsTableViewCell.m
//  jjrms
//
//  Created by user on 16/10/24.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

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
    
    self.headImageV=[[UIImageView alloc]init];
    self.headImageV.backgroundColor=[UIColor lightGrayColor];
    [self.contentView addSubview:self.headImageV];
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(580*WSCALE, 282*HSCALE));
        make.top.mas_equalTo(30*HSCALE);
        make.centerX.mas_equalTo(weakSelf.contentView);
    }];
    


    self.blackV=[[UIView alloc]init];
    self.blackV.backgroundColor= [UIColor colorWithWhite:0.f alpha:0.3];;
    [self.headImageV addSubview:self.blackV];
    [self.blackV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0*HSCALE);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(55*HSCALE);
    }];
    
    self.titleLB=[[UILabel alloc]init];
    self.titleLB.textColor=[UIColor whiteColor];
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    [self.headImageV addSubview:self.titleLB];
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.headImageV.mas_bottom).offset(-20*HSCALE);
        make.height.mas_equalTo(30*HSCALE);
        make.left.mas_equalTo(24*WSCALE);
        make.right.mas_equalTo(-24*WSCALE);

    }];
    
    
    self.timeLB=[[UILabel alloc]init];
    self.timeLB.textColor=[UIColor blackColor];
    self.timeLB.font=[UIFont systemFontOfSize:12];
    self.timeLB.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:self.timeLB];
    [self.timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageV.mas_bottom).offset(20*HSCALE);
        make.height.mas_equalTo(30*HSCALE);
        make.left.mas_equalTo(58*WSCALE);
    }];
    
    self.DetailLB=[[UILabel alloc]init];
    self.DetailLB.textColor=[UIColor colorWithHexString:@"#444444"];
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
        make.left.mas_equalTo(50*WSCALE);
        make.right.mas_equalTo(-50*WSCALE);
        make.bottom.mas_equalTo(-2*HSCALE);
    }];
}


-(void)setModel:(NewsModel *)model{

    
    [_headImageV sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"di"]];
    _titleLB.text=model.notice_title;


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
