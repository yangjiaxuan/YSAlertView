//
//  YSAlertWindow.m
//  YSAlertView
//
//  Created by 杨森 on 2017/11/29.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "YSAlertWindow.h"

@interface YSAlertWindow()

@property (nonatomic ,strong, nonnull)YSAlertViewManager *alertViewManager;

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
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
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
    alertWindow.hidden = NO;
}

+ (void)hide{
    YSAlertWindow *alertWindow = [YSAlertWindow shareAlertWindow];
    for (UIView *subView in alertWindow.subviews) {
        [subView removeFromSuperview];
    }
    [alertWindow setHidden:true];
}

+ (void)hideView:(UIView *)view{
    if (!view) {
        return;
    }
    YSAlertWindow *alertWindow = [YSAlertWindow shareAlertWindow];
    for (UIView *viewP in alertWindow.subviews) {
        if (view == viewP) {
            [viewP removeFromSuperview];
            break;
        }
    }
    if (alertWindow.subviews.count == 0) {
        [alertWindow setHidden:true];
    }
}


@end



