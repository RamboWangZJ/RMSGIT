//
//  FirstViewController.h
//  jjrms
//
//  Created by user on 16/11/7.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Commen.h"
#import "Masonry.h"

@interface FirstViewController : UIViewController<UIScrollViewDelegate>
@property(nonatomic, strong)UIScrollView *scroll;
@property(nonatomic, strong)UIPageControl *pageControll;
@property(nonatomic, strong)UIButton *cancelbtn;

@end
