//
//  YSAlertView.m
//  YSAlertView
//
//  Created by 杨森 on 2017/11/27.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "YSAlertView.h"
#import "YSAlertViewManager.h"

@implementation YSAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(YSAlertActionType)style handler:(void (^)(YSAlertAction * _Nullable))handler{
    YSAlertAction *action = [[YSAlertAction alloc] init];
    action->_title        = title;
    action->_style        = style;
    action->_handle       = handler;
    return action;
}

- (void)dealloc{
    NSLog(@"[* %@ 释放了 *]", NSStringFromClass(self.class));
}
@end

@interface YSAlertView()
{
    UIFont *_titleFont;
    UIFont *_messageFont;
    UIColor *_titleColor;
    UIColor *_messageColor;
}
@end
@implementation YSAlertView

+ (instancetype _Nullable)ys_alertViewWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message{
    YSAlertView *alertView = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [alertView setData];
    [alertView setUI];
    [alertView setupTitle:title message:message];
    [alertView setupUI];
    return alertView;
}

- (void)setData{
    _animatedDuration = 0.25;
    _titleFont        = [UIFont boldSystemFontOfSize:18];
    _messageFont      = [UIFont systemFontOfSize:15];
    _titleColor       = [UIColor blackColor];
    _messageColor     = [UIColor grayColor];
    _canleBtnColor    = [UIColor redColor];
    _otherBtnColor    = [UIColor blueColor];
    _separateLineColor= [UIColor colorWithWhite:0.9 alpha:1];
    [self setupData];
}

- (void)setupData{}

- (void)setUI{
    self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    _contentView         = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
}



- (void)setupTitle:(NSString *)title message:(NSString *)message{
    _titleLabel               = [[UILabel alloc] init];
    _titleLabel.text          = title;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;

    _titleLabel.font          = _titleFont;
    _titleLabel.textColor     = _titleColor;
    
    _messageLabel               = [[UILabel alloc] init];
    _messageLabel.text          = message;
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.numberOfLines = 0;

    _messageLabel.font          = _messageFont;
    _messageLabel.textColor     = _messageColor;
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_messageLabel];
    
    [self resetTitleLabel:_titleLabel messageLabel:_messageLabel];
}

- (void)ys_showAnimated:(BOOL)animated completeHander:(dispatch_block_t _Nullable )completeHander{
    if (animated) {
        self.alpha = 0.2;
        [UIView animateWithDuration:self.animatedDuration animations:^{
            self.alpha = 1;
        }completion:^(BOOL finished) {
            if (completeHander) {
                completeHander();
            }
        }];
    }else{
        if (completeHander) {
            completeHander();
        }
    }
}

- (void)ys_dismissAnimated:(BOOL)animated completeHander:(dispatch_block_t _Nullable )completeHander{
    
    if (animated) {
        [UIView animateWithDuration:self.animatedDuration animations:^{
            self.alpha = 0.2;
        }completion:^(BOOL finished) {
            
            if (completeHander) {
                completeHander();
            }
        }];
    }else{
        if (completeHander) {
            completeHander();
        }
    }
}


- (UIButton *)createAlertActionViewWithFrame:(CGRect)frame title:(NSString *)title index:(NSInteger)index actionHandle:(void(^)(UIButton *))actionHandle{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.tag   = 1000+index;
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage ys_imageWithColor:[UIColor whiteColor] size:frame.size] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage ys_imageWithColor:_separateLineColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(actionHandle:) forControlEvents:UIControlEventTouchUpInside];
    button.clickHandle = actionHandle;
    return button;
}

- (void)actionHandle:(UIButton *)sender{}
- (void)setupUI{}
- (void)resetTitleLabel:(UILabel * _Nonnull)titleLabel messageLabel:(UILabel * _Nonnull)messageLabel{}

- (void)dealloc{
    NSLog(@"[* %@ 释放了 *]", NSStringFromClass(self.class));
}

@end
