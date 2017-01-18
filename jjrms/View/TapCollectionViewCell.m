//
//  TapCollectionViewCell.m
//  jjrms
//
//  Created by user on 16/9/26.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "TapCollectionViewCell.h"

@implementation TapCollectionViewCell


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //initialize code...
        [self initCell];
    }
    return self;
}

-(void)initCell {
    
    __weak typeof(self) weakSelf = self;

    self.hImageView=[[UIImageView alloc]init];
    [self.contentView addSubview:self.hImageView];
    [self.hImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(88*WSCALE, 88*HSCALE));
        make.top.mas_equalTo(48*HSCALE);
        make.centerX.mas_equalTo(weakSelf.contentView);
    }];
    
    self.hLabel=[[UILabel alloc]init];
    self.hLabel.textColor=[UIColor colorWithHexString:@"#666666"];
    self.hLabel.font=[UIFont systemFontOfSize:14];

    self.hLabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:self.hLabel];
    [self.hLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.hImageView.mas_bottom).offset(20*HSCALE);
        make.centerX.mas_equalTo(weakSelf.contentView);
        make.height.mas_equalTo(30*HSCALE);
        make.right.mas_equalTo(50*WSCALE);
    }];
    

    
}

- (void)setModel:(NSDictionary *)model{
    self.hImageView.image=[UIImage imageNamed:[model objectForKey:@"pic"]];
    self.hLabel.text=[model objectForKey:@"text"];
}


@end
