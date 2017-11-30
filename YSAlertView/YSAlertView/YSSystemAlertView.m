//
//  YSSystemAlertView.m
//  YSAlertView
//
//  Created by 杨森 on 2017/11/28.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "YSSystemAlertView.h"

#define kSystemAlertContentCornerRadius 5
#define kSystemAlertSpace               20

@interface YSSystemAlertView()
{
    UIButton *_cancleView;
    NSArray  *_otherActionsViews;
    NSInteger _contentViewW;
    NSInteger _actionItemH;
    
    UIView   *_actionBgView;
}
@end
@implementation YSSystemAlertView

- (void)setupData{
    _contentViewW    = kYS_ScreenW * 0.7;
    _actionItemH     = kYS_ScreenW * 0.12;

}

- (void)setupUI{
    _actionBgView = [[UIView alloc] init];
    [self.contentView addSubview:_actionBgView];
}

- (void)didMoveToSuperview{
    self.contentView.layer.cornerRadius  = kSystemAlertContentCornerRadius;
    self.contentView.layer.masksToBounds = true;
    _actionBgView.backgroundColor        = self.separateLineColor;

    [_cancleView setTitleColor:self.canleBtnColor forState:UIControlStateNormal];
    for (UIButton *actionView in _otherActionsViews) {
        [actionView setTitleColor:self.otherBtnColor forState:UIControlStateNormal];
    }
}

- (void)ys_setAlertActions:(NSArray<YSAlertAction *> *)alertActions{
    NSInteger messageMaxY = CGRectGetMaxY(self.messageLabel.frame) + kSystemAlertSpace;
    NSInteger count       = alertActions.count;
    NSInteger actionW     = _contentViewW;
    CGFloat   actionWA    = 0;
    NSInteger actionH     = _actionItemH;
    CGFloat   actionHA    = 0;
    if (count == 0) {
        return;
    }
    else if(count == 2){
        actionW  = _contentViewW/2;
        actionWA = actionW + kYS_SpareatLineH;
    }
    else{
        actionHA = actionH + kYS_SpareatLineH;
    }
    NSMutableArray *otherActionViews = [NSMutableArray array];
    UIButton *actionView = nil;
    for (NSInteger i=0; i<count; i++) {
        YSAlertAction *action = alertActions[i];
        actionView = [self createAlertActionViewWithFrame:CGRectMake(i*actionWA, 0.5+i*actionHA, actionW, actionH) title:action.title index:i actionHandle:^(UIButton * button) {
            if (action.handle) {
                action.handle(action);
            }
        }];
        if (action.style == YSAlertActionTypeCancle) {
            _cancleView = actionView;
        }
        else{
            [otherActionViews addObject:actionView];
        }
        [_actionBgView addSubview:actionView];
    }
    _actionBgView.frame = CGRectMake(0, messageMaxY, _contentViewW, CGRectGetMaxY(actionView.frame));
    _otherActionsViews = [otherActionViews copy];
    [self resetContentViewFrameWithRealHeight:CGRectGetMaxY(_actionBgView.frame)];
}

- (void)resetTitleLabel:(UILabel *)titleLabel messageLabel:(UILabel *)messageLabel{
    
    NSString *title     = titleLabel.text;
    NSString *message   = messageLabel.text;
    
    NSInteger titleH    = [title ys_stringHeightWithWidth:_contentViewW font:titleLabel.font];
    NSInteger messageH  = [message ys_stringHeightWithWidth:_contentViewW font:titleLabel.font];
    
    titleLabel.frame    = CGRectMake(0, kSystemAlertSpace, _contentViewW, titleH);
    messageLabel.frame  = CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+kSystemAlertContentCornerRadius, _contentViewW, messageH);
}

- (void)resetContentViewFrameWithRealHeight:(NSInteger)height{
    NSInteger contentViewH = height;
    NSInteger contentViewX = (kYS_ScreenW - _contentViewW)*0.5;
    NSInteger contentViewY = (kYS_ScreenH - contentViewH)*0.5;
    self.contentView.frame = CGRectMake(contentViewX, contentViewY, _contentViewW, contentViewH);
}

@end
