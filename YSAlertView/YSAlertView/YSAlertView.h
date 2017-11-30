//
//  YSAlertView.h
//  YSAlertView
//
//  Created by 杨森 on 2017/11/27.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSAlertView+Extension.h"
#import "YSAlertProtocol.h"

@interface YSAlertAction : NSObject

@property (nonatomic ,assign, readonly)YSAlertActionType  style;
@property (nonatomic ,  copy, readonly, nonnull)NSString *title;
@property (nonatomic ,  copy, nonnull)void(^handle)(YSAlertAction * _Nullable action);

+ (nullable instancetype)actionWithTitle:(nullable NSString *)title style:(YSAlertActionType)style handler:(void (^ __nullable)(YSAlertAction * _Nullable action))handle;

@end

@interface YSAlertView : UIView <YSAlertViewDelegate>

@property (nonatomic , assign)CGFloat animatedDuration;

@property (nonatomic , strong, readonly, nonnull)UILabel *titleLabel;
@property (nonatomic , strong, readonly, nonnull)UILabel *messageLabel;
@property (nonatomic , strong, readonly, nonnull)UIView  *contentView;

@property (nonatomic ,strong, nonnull)UIColor *canleBtnColor;
@property (nonatomic ,strong, nonnull)UIColor *otherBtnColor;

- (UIButton * _Nonnull)createAlertActionViewWithFrame:(CGRect)frame title:(NSString * _Nonnull)title index:(NSInteger)index actionHandle:(void(^_Nullable)(UIButton * __nonnull))actionHandle;

// 子类继承
- (void)setupUI;
- (void)setupData;
- (void)resetTitleLabel:(UILabel * _Nonnull)titleLabel messageLabel:(UILabel * _Nonnull)messageLabel;

@end





