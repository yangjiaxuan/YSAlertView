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

@property (nonatomic ,weak, nullable, readonly)UIView <YSAlertViewDelegate> *alertView;


+ (instancetype _Nullable)ys_alertViewManagerWithAlertViewClass:(Class _Nonnull )clazz title:(NSString * _Nullable)title message:(NSString * _Nullable)message alertActions:(NSArray <YSAlertAction *> * _Nullable)alertActions;
;

- (void)ys_show;

- (void)ys_showAnimated:(BOOL)animated preHander:(void(^_Nullable)(UIView<YSAlertViewDelegate>* _Nonnull))preHander completeHander:(dispatch_block_t _Nullable )completeHander;

- (void)ys_dismiss;

@end
