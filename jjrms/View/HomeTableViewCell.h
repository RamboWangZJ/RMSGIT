//
//  HomeTableViewCell.h
//  jjrms
//
//  Created by user on 16/9/27.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "Commen.h"
#import "HomeSourceModel.h"
#import "UIColor+Helper.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"

@interface HomeTableViewCell : UITableViewCell
@property(nonatomic,retain)UILabel *name;
//@property(nonatomic,retain)UILabel *address;
@property(nonatomic,retain)UILabel *info;
@property(nonatomic,retain)UILabel *homeTime;
//@property(nonatomic,retain)UIImageView *homeImg;
@property(nonatomic,retain)UIImageView *addressImg;
@property(nonatomic,retain)UIImageView *infoImg;
@property(nonatomic,retain)UIImageView *homeTimeImg;


@property(nonatomic,retain)UIImageView *homeImg;
@property(nonatomic,retain)UILabel *address;
@property(nonatomic,retain)UIImageView *checkImag;

@property(nonatomic,retain)UILabel *homeStates;
@property(nonatomic,retain)HomeSourceModel *model;
@end
