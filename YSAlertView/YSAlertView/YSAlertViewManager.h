//
//  YSAlertViewManager.h
//  YSAlertView
//
//  Created by 杨森 on 2017/11/28.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSAlertProtocol.h"

@interface YSAlertViewManager : NSObject

+ (instancetype _Nonnull)ys_alertViewManagerWithAlertViewClass:(Class _Nonnull )clazz title:(NSString * _Nullable)title message:(NSString * _Nullable)message alertActions:(NSArray <YSAlertAction *> * _Nullable)alertActions;
;

- (void)ys_show;

- (void)ys_showAnimated:(BOOL)animated preHander:(void(^_Nullable)(UIView<YSAlertViewDelegate>* _Nonnull))preHander completeHander:(dispatch_block_t _Nullable )completeHander;

- (void)ys_dismiss;

- (void)ys_dismissAnimated:(BOOL)animated completeHander:(dispatch_block_t _Nullable )completeHander;

@end