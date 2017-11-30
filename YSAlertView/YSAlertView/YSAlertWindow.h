//
//  YSAlertWindow.h
//  YSAlertView
//
//  Created by 杨森 on 2017/11/29.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSAlertViewManager.h"

@interface YSAlertWindow : UIWindow

+ (instancetype _Nonnull)shareAlertWindow;

+ (void)addViewWithAlertViewManager:(YSAlertViewManager * _Nonnull)viewManager;
+ (void)show;
+ (void)hide;

@end
