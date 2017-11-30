//
//  YSSheetView.m
//  YSAlertView
//
//  Created by 杨森 on 2017/11/28.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "YSSheetView.h"

#define kSheetContentCornerRadius 12
#define kSheetSpace 12

@interface YSSheetView()
{
    UIButton *_cancleView;
    NSArray  *_otherActionsViews;
    
    NSInteger _contentViewW;
    NSInteger _actionItemH;
}
@end
@implementation YSSheetView

- (void)setupData{
    _contentViewW = kYS_ScreenW * 0.94;
    _actionItemH  = _contentViewW * 0.15;
}

- (void)setupUI{
}

- (void)didMoveToSuperview{
    self.contentView.layer.cornerRadius  = kSheetContentCornerRadius;
    self.contentView.layer.masksToBounds = true;
    self.contentView.backgroundColor     = self.separateLineColor;
    
    [_cancleView setTitleColor:self.canleBtnColor forState:UIControlStateNormal];
    for (UIButton *actionView in _otherActionsViews) {
        [actionView setTitleColor:self.otherBtnColor forState:UIControlStateNormal];
    }
}

- (void)ys_setAlertActions:(NSArray<YSAlertAction *> *)alertActions{
    
    NSInteger contentViewX = (kYS_ScreenW - _contentViewW)*0.5;
    
    CGFloat messageMaxY   = CGRectGetMaxY(self.messageLabel.superview.frame);
    NSInteger actionW     = _contentViewW;
    NSInteger actionH     = _actionItemH;
    CGFloat   actionHA    = 0.5 + actionH;
    
    NSMutableArray *otherActionViews = [NSMutableArray array];
    UIButton *actionView = nil;
    NSInteger i = 0;
    for (YSAlertAction *action in alertActions) {
        if (action.style == YSAlertActionTypeCancle) {
            _cancleView = [self createAlertActionViewWithFrame:CGRectMake(0, 0.5+i*actionHA + messageMaxY, actionW, actionH) title:action.title index:i actionHandle:^(UIButton * button) {
                if (action.handle) {
                    action.handle(action);
                }
            }];
        }
        else{
            actionView = [self createAlertActionViewWithFrame:CGRectMake(0, 0.5+i*actionHA + messageMaxY, actionW, actionH) title:action.title index:i actionHandle:^(UIButton * button) {
                if (action.handle) {
                    action.handle(action);
                }
            }];
            [otherActionViews addObject:actionView];
            [self.contentView addSubview:actionView];
            i++;
        }
    }
    CGRect cancleFrame = CGRectMake(contentViewX, kYS_ScreenH - kSheetSpace - _actionItemH, _contentViewW, _actionItemH);
    if (!_cancleView) {
        _cancleView = [self createAlertActionViewWithFrame:cancleFrame title:@"取消" index:100 actionHandle:nil];
    }
    else{
        _cancleView.frame = cancleFrame;
    }
    _cancleView.layer.cornerRadius  = kSheetContentCornerRadius;
    _cancleView.layer.masksToBounds = YES;
    [self addSubview:_cancleView];
    
    NSInteger contentViewH = CGRectGetMaxY(actionView.frame);
    NSInteger contentViewY = CGRectGetMinY(_cancleView.frame) - contentViewH - kSheetSpace;
    self.contentView.frame = CGRectMake(contentViewX, contentViewY, _contentViewW, contentViewH);
    _otherActionsViews = [otherActionViews copy];
}

- (void)resetTitleLabel:(UILabel *)titleLabel messageLabel:(UILabel *)messageLabel{
    

    NSString *title     = titleLabel.text;
    NSString *message   = messageLabel.text;
    
    NSInteger titleH    = [title ys_stringHeightWithWidth:_contentViewW font:titleLabel.font];
    NSInteger messageH  = [message ys_stringHeightWithWidth:_contentViewW font:titleLabel.font];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _contentViewW, titleH+messageH+3.5*kSheetSpace)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    [bgView addSubview:titleLabel];
    [bgView addSubview:messageLabel];
    
    titleLabel.frame    = CGRectMake(0, 1.5*kSheetSpace, _contentViewW, titleH);
    messageLabel.frame  = CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+kSheetSpace, _contentViewW, messageH);

}

- (void)ys_showAnimated:(BOOL)animated completeHander:(dispatch_block_t)completeHander{
    NSInteger contentY = CGRectGetMinY(self.contentView.frame);
    NSInteger contentH = self.contentView.frame.size.height;
    NSInteger contentX = self.contentView.frame.origin.x;
    
    NSInteger cancleY  = _cancleView.frame.origin.y;
    
    self.contentView.frame = CGRectMake(contentX, contentY+kYS_ScreenH, _contentViewW, contentH);
    _cancleView.frame      = CGRectMake(contentX, cancleY +kYS_ScreenH, _contentViewW, _actionItemH);
    
    [UIView animateWithDuration:self.animatedDuration animations:^{
        self.contentView.frame = CGRectMake(contentX, contentY, _contentViewW, contentH);
        _cancleView.frame      = CGRectMake(contentX, cancleY, _contentViewW, _actionItemH);
    }completion:^(BOOL finished) {
        if (completeHander) {
            completeHander();
        }
    }];
}

- (void)ys_dismiss{
    
    NSInteger contentY = CGRectGetMinY(self.contentView.frame);
    NSInteger contentH = self.contentView.frame.size.height;
    NSInteger contentX = self.contentView.frame.origin.x;
    
    NSInteger cancleY  = _cancleView.frame.origin.y;
    [UIView animateWithDuration:self.animatedDuration animations:^{
        self.contentView.frame = CGRectMake(contentX, contentY+kYS_ScreenH, _contentViewW, contentH);
        _cancleView.frame      = CGRectMake(contentX, cancleY +kYS_ScreenH, _contentViewW, _actionItemH);
    }];
}

- (BOOL)ys_canDismissWithClickBlank{
    return YES;
}

@end
