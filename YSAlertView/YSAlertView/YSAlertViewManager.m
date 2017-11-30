//
//  YSAlertViewManager.m
//  YSAlertView
//
//  Created by 杨森 on 2017/11/28.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "YSAlertViewManager.h"
#import "YSAlertWindow.h"
#import "YSAlertView.h"

@interface YSAlertViewManager()

@property (nonatomic ,weak, nullable)UIView <YSAlertViewDelegate> *alertView;

@end

@implementation YSAlertViewManager

+ (instancetype)ys_alertViewManagerWithAlertViewClass:(Class)clazz title:(NSString * _Nullable)title message:(NSString * _Nullable)message alertActions:(NSArray<YSAlertAction *> * _Nullable)alertActions{
    YSAlertViewManager *alertViewManager = [[YSAlertViewManager alloc] init];
    UIView <YSAlertViewDelegate> *alertView = nil;
    if ([clazz respondsToSelector:@selector(ys_alertViewWithTitle:message:)]) {
        alertView = [clazz ys_alertViewWithTitle:title message:message];
    }
    alertViewManager.alertView = alertView;
    [alertViewManager ys_setAlertActions:alertActions];
    [YSAlertWindow addView:alertView];
    return alertViewManager;
}

- (void)ys_setAlertActions:(NSArray <YSAlertAction *> * _Nullable)alertActions;
{
    for (YSAlertAction *action in alertActions) {
        if (action.style == YSAlertActionTypeCancle) {
            void(^ cancleActionP)(YSAlertAction *action) = [action.handle copy];
            void(^ cancleAction)(YSAlertAction *action) = ^(YSAlertAction *action){
                [YSAlertWindow hide];
                cancleActionP(action);
            };
            action.handle = [cancleAction copy];
            break;
        }
    }
    if ([self.alertView respondsToSelector:@selector(ys_setAlertActions:)]) {
        [self.alertView ys_setAlertActions:alertActions];
    }
    
}

- (void)ys_show{
    [self ys_showAnimated:false preHander:nil completeHander:nil];

}

- (void)ys_showAnimated:(BOOL)animated preHander:(void (^)(UIView<YSAlertViewDelegate> * _Nonnull))preHander completeHander:(dispatch_block_t)completeHander{
    
    [YSAlertWindow show];
    if ([self.alertView respondsToSelector:@selector(ys_showAnimated:completeHander:)]) {
        [self.alertView ys_showAnimated:animated completeHander:completeHander];
    }
    if (preHander) {
        preHander(self.alertView);
    }
}

- (void)ys_dismiss{
    [self ys_dismissAnimated:NO completeHander:nil];
}

- (void)ys_dismissAnimated:(BOOL)animated completeHander:(dispatch_block_t)completeHander{
    
    [YSAlertWindow hideView:self.alertView];
    if ([self.alertView respondsToSelector:@selector(ys_dismissAnimated:completeHander:)]) {
        [self.alertView ys_dismissAnimated:animated completeHander:completeHander];
    }
}

- (void)dealloc{
    NSLog(@"[* %@ 释放了 *]", NSStringFromClass(self.class));
}


@end
