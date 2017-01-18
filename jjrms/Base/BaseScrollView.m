//
//  BaseScrollView.m
//  jjrms
//
//  Created by user on 16/9/30.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseScrollView.h"
#import "Commen.h"
@implementation BaseScrollView
/*
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        
        NSLog(@"%@",gestureRecognizer.view);
        CGPoint point = [touch locationInView:gestureRecognizer.view];

        if (point.x < 20.0 || point.x > SCREEN_WIDTH - 20.0) {
            return YES;
        } else {
            return NO;
        }

    }
    
    return YES;
}

*/

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]){
        //CGPoint t = [gestureRecognizer translationInView]
        //CGPoint translation = [gestureRecognizer velocityInView:gestureRecognizer.view];
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;

        //CGPoint point = [pan velocityInView:pan.view];
        CGPoint point = [pan translationInView:pan.view];
        
        //NSLog(@"x___%f", fabs(point.x));
        //NSLog(@"y___%f", fabs(point.y));
        
        if (fabs(point.x)<fabs(point.y)) {
            
            //上下方向的滑动
            
            return NO;
            
        }else{
            
            return YES;
        }
/*
        if (point.x > 0) {
            NSLog(@"向右滑动");
        }else{
            NSLog(@"向左滑动");
        }
        
        if (point.y > 0) {
            NSLog(@"向下滑动");
        }else{
            NSLog(@"向上滑动");
        }
 */
        



    }
    return YES;
}


/*
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
*/

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
