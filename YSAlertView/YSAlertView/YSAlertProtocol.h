//
//  YSAlertProtocol.h
//  YSAlertView
//
//  Created by 杨森 on 2017/11/28.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSAlertType.h"
#import <UIKit/UIKit.h>

@class YSAlertAction;
@protocol YSAlertViewDelegate

@property (nonatomic , assign)CGFloat animatedDuration;

+ (UIView<YSAlertViewDelegate>* _Nullable)ys_alertViewWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message;

- (void)ys_setAlertActions:(NSArray <YSAlertAction *> * _Nullable)alertActions;

- (void)ys_dismiss;


@optional

- (void)ys_showAnimated:(BOOL)animated  completeHander:(dispatch_block_t _Nullable )completeHander;
- (BOOL)ys_canDismissWithClickBlank;


@end
