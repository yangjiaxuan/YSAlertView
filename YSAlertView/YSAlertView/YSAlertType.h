//
//  YSAlertType.h
//  YSAlertView
//
//  Created by 杨森 on 2017/11/28.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YSAlertActionType){
    YSAlertActionTypeDefault,
    YSAlertActionTypeCancle
};

#define kYS_ScreenW ([UIScreen mainScreen].bounds.size.width)
#define kYS_ScreenH ([UIScreen mainScreen].bounds.size.height)
#define kYS_SpareatLineH 0.5f

#define YS_WeakObject(obj)   __weak typeof(obj) weak##obj = self
#define YS_StrongObject(obj) __strong typeof(obj) self = weak##obj


