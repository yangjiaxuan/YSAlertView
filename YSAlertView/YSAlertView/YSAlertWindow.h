//
//  YSAlertWindow.h
//  YSAlertView
//
//  Created by 杨森 on 2017/11/29.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSAlertWindow : UIWindow

+ (instancetype)shareAlertWindow;

+ (void)addView:(UIView *)view;
+ (void)show;

+ (void)hideView:(UIView *)view;
+ (void)hide;

@end
