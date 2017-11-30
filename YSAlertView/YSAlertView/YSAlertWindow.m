//
//  YSAlertWindow.m
//  YSAlertView
//
//  Created by 杨森 on 2017/11/29.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "YSAlertWindow.h"

#define kAlertWindowShowColor [UIColor colorWithWhite:0.3 alpha:0.3]
#define kAlertWindowHideColor [UIColor colorWithWhite:0.3 alpha:0]

@interface YSAlertWindow()

@property (nonatomic ,strong, nullable)YSAlertViewManager *alertViewManager;

@end
static YSAlertWindow *__alertWindow__ = nil;
@implementation YSAlertWindow

+ (instancetype)shareAlertWindow{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __alertWindow__ = [[self alloc] init];
    });
    return __alertWindow__;
}

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = kAlertWindowShowColor;
    }
    return self;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    if (__alertWindow__) {
        return __alertWindow__;
    }else{
        return [super allocWithZone:zone];
    }
}

- (id)copy{
    return __alertWindow__;
}

+ (void)addViewWithAlertViewManager:(YSAlertViewManager *)viewManager{
    if (!viewManager.alertView) {
        return;
    }
    YSAlertWindow *alertWindow = [YSAlertWindow shareAlertWindow];
    alertWindow.alertViewManager = viewManager;
    [alertWindow addSubview:viewManager.alertView];
}

+ (void)show{
    YSAlertWindow *alertWindow = [YSAlertWindow shareAlertWindow];
    [alertWindow makeKeyWindow];
    alertWindow.hidden          = NO;
    alertWindow.backgroundColor = kAlertWindowHideColor;
    [UIView animateWithDuration:alertWindow.alertViewManager.alertView.animatedDuration animations:^{
        alertWindow.backgroundColor = kAlertWindowShowColor;
    }];
}

+ (void)hideAll{
    
    [YSAlertWindow hideComplete:^{
        YSAlertWindow *alertWindow = [YSAlertWindow shareAlertWindow];
        for (UIView *subView in alertWindow.subviews) {
            [subView removeFromSuperview];
        }
    }];
}

+ (void)hideView:(UIView *)view{
    if (!view) {
        return;
    }
    YSAlertWindow *alertWindow = [YSAlertWindow shareAlertWindow];
    for (UIView *viewP in alertWindow.subviews) {
        if (view == viewP) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(alertWindow.alertViewManager.alertView.animatedDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [viewP removeFromSuperview];
            });
            break;
        }
    }
    if (alertWindow.subviews.count == 0) {
        [self hideAll];
    }
}

+ (void)hideComplete:(dispatch_block_t)complete{
    
    YSAlertWindow *alertWindow = [YSAlertWindow shareAlertWindow];
    alertWindow.backgroundColor = kAlertWindowShowColor;
    [UIView animateWithDuration:alertWindow.alertViewManager.alertView.animatedDuration animations:^{
        alertWindow.backgroundColor = kAlertWindowHideColor;
    }completion:^(BOOL finished) {
        if (complete) {
            complete();
        }
        [alertWindow setHidden:true];
        alertWindow.alertViewManager = nil;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.alertViewManager ys_dismiss];
}

@end



