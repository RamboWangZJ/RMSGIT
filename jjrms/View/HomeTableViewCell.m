//
//  HomeTableViewCell.m
//  jjrms
//
//  Created by user on 16/9/27.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

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
    
    self.backgroundColor=[UIColor whiteColor];
    
    self.homeImg=[[UIImageView alloc]init];
    [self.contentView addSubview:self.homeImg];
    [self.homeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(99*2*WSCALE, 81*2*HSCALE));
        make.left.mas_equalTo(0*WSCALE);
        make.top.mas_equalTo(0*HSCALE);
    }];
    
    

    self.address=[[UILabel alloc]init];
    [self.contentView addSubview:self.address];
    self.address.font=[UIFont systemFontOfSize:15];
    self.address.numberOfLines=0;
    self.address.textColor=[UIColor colorWithHexString:@"#555555"];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(66*HSCALE);
        make.left.mas_equalTo(self.homeImg.mas_right).offset(38*WSCALE);
        make.top.mas_equalTo(30*HSCALE);
        make.width.mas_equalTo(262*WSCALE);
    }];
    
    _checkImag=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zhengque"]];
    [self.contentView addSubview:_checkImag];
    [_checkImag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(38*WSCALE, 26*HSCALE));
        make.centerY.equalTo(_address.mas_centerY);
        make.right.mas_equalTo(-30*WSCALE);
    }];
    _checkImag.hidden=YES;
   
    
    self.homeStates=[[UILabel alloc]init];
    self.homeStates.textColor=[UIColor colorWithHexString:@"#00A6A6"];
    self.homeStates.font=[UIFont systemFontOfSize:12];
    self.homeStates.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:self.homeStates];
    [self.homeStates mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.homeImg.mas_right).offset(38*WSCALE);
        make.top.mas_equalTo(self.address.mas_bottom).offset(12*HSCALE);
    }];


    
    self.info=[[UILabel alloc]init];
    [self.contentView addSubview:self.info];
    self.info.font=[UIFont systemFontOfSize:12];
    self.info.textColor=[UIColor colorWithHexString:@"#555555"];
    [self.info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.homeStates.mas_right).offset(28*WSCALE);
        make.top.mas_equalTo(self.homeStates.mas_top);
        make.right.mas_equalTo(-30*WSCALE);
    }];
    
    
}

- (void)setModel:(HomeSourceModel *)model{
    NSDictionary *dic=model.images[0];
    NSString *url=[dic objectForKey:@"url"];
    [self.homeImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"di"]];
    self.address.text=model.house_name;
    self.info.text=[NSString stringWithFormat:@"%@",model.house_rooms_txt];

        switch ([model.status integerValue]) {
        case 10:
            self.homeStates.text=NSLocalizedString(@"shenhezhong_hs",nil);
            break;
        case 20:
            self.homeStates.text=NSLocalizedString(@"yibohui_hs",nil);
            break;
        case 30:
            self.homeStates.text=NSLocalizedString(@"yishangxian_hs",nil);
            break;
        case 40:
            self.homeStates.text=NSLocalizedString(@"yixiaxian_hs",nil);
            break;
        default:
            break;
    }
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
