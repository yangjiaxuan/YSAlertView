//
//  ViewController.m
//  YSAlertView
//
//  Created by 杨森 on 2017/11/27.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "ViewController.h"
#import "YSAlertViewManager.h"
#import "YSSystemAlertView.h"
#import "YSSheetView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"测试数据啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦" preferredStyle:UIAlertControllerStyleActionSheet];
    
//    UIAlertControllerStyleAlert
//    UIAlertControllerStyleActionSheet
    UIAlertAction *action_01 = [UIAlertAction actionWithTitle:@"010" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action_02 = [UIAlertAction actionWithTitle:@"01" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self alertTest_01];
    }];
    UIAlertAction *action_03 = [UIAlertAction actionWithTitle:@"02" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self alertTest_02];
    }];
    UIAlertAction *action_04 = [UIAlertAction actionWithTitle:@"03" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self alertTest_03];
    }];
    UIAlertAction *action_05 = [UIAlertAction actionWithTitle:@"sheet" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self sheetTest_01];
    }];
    
    
    [alertVC addAction:action_01];
    [alertVC addAction:action_02];
    [alertVC addAction:action_03];
    [alertVC addAction:action_04];
    [alertVC addAction:action_05];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)alertTest_01{
    
    YSAlertAction *alertActionCancle = [YSAlertAction actionWithTitle:@"取消" style:YSAlertActionTypeCancle handler:^(YSAlertAction * _Nullable action) {
        NSLog(@"取消");
    }];
    
    YSAlertAction *alertActionSure = [YSAlertAction actionWithTitle:@"01" style:YSAlertActionTypeDefault handler:^(YSAlertAction * _Nullable action) {
         NSLog(@"01");
    }];
    
    YSAlertAction *alertAction_01 = [YSAlertAction actionWithTitle:@"02" style:YSAlertActionTypeDefault handler:^(YSAlertAction * _Nullable action) {
         NSLog(@"02");
    }];
    
    YSAlertAction *alertAction_02 = [YSAlertAction actionWithTitle:@"03" style:YSAlertActionTypeDefault handler:^(YSAlertAction * _Nullable action) {
         NSLog(@"03");
    }];
    
    
    YSAlertViewManager *alertManager = [YSAlertViewManager ys_alertViewManagerWithAlertViewClass:YSSystemAlertView.class title:@"提示" message:@"啦啦啦啦啦啦" alertActions:@[ alertActionSure, alertAction_01, alertAction_02,alertActionCancle]];
    
    [alertManager ys_show];
}

- (void)alertTest_02{
    YSAlertAction *alertActionCancle = [YSAlertAction actionWithTitle:@"取消" style:YSAlertActionTypeCancle handler:^(YSAlertAction * _Nullable action) {
        NSLog(@"取消");
    }];
    
    YSAlertAction *alertActionSure = [YSAlertAction actionWithTitle:@"确定" style:YSAlertActionTypeDefault handler:^(YSAlertAction * _Nullable action) {
        NSLog(@"确定");
    }];
    
    YSAlertViewManager *alertManager = [YSAlertViewManager ys_alertViewManagerWithAlertViewClass:YSSystemAlertView.class title:@"提示" message:@"啦啦啦啦啦啦" alertActions:@[alertActionCancle, alertActionSure]];
    
    [alertManager ys_show];
    
}

- (void)alertTest_03{
    YSAlertAction *alertActionCancle = [YSAlertAction actionWithTitle:@"取消" style:YSAlertActionTypeCancle handler:^(YSAlertAction * _Nullable action) {
        NSLog(@"取消");
    }];
    
    YSAlertViewManager *alertManager = [YSAlertViewManager ys_alertViewManagerWithAlertViewClass:YSSystemAlertView.class title:@"提示" message:@"啦啦啦啦啦啦" alertActions:@[alertActionCancle]];
    [alertManager ys_show];
}


- (void)sheetTest_01{
    
    YSAlertAction *alertActionCancle = [YSAlertAction actionWithTitle:@"取消" style:YSAlertActionTypeCancle handler:^(YSAlertAction * _Nullable action) {
        NSLog(@"取消");
    }];
    
    YSAlertAction *alertActionSure = [YSAlertAction actionWithTitle:@"01" style:YSAlertActionTypeDefault handler:^(YSAlertAction * _Nullable action) {
        NSLog(@"01");
    }];
    
    YSAlertAction *alertAction_01 = [YSAlertAction actionWithTitle:@"02" style:YSAlertActionTypeDefault handler:^(YSAlertAction * _Nullable action) {
        NSLog(@"02");
    }];
    
    YSAlertAction *alertAction_02 = [YSAlertAction actionWithTitle:@"03" style:YSAlertActionTypeDefault handler:^(YSAlertAction * _Nullable action) {
        NSLog(@"03");
    }];
    
    
    YSAlertViewManager *alertManager = [YSAlertViewManager ys_alertViewManagerWithAlertViewClass:YSSheetView.class title:@"提示" message:@"啦啦啦啦啦啦" alertActions:@[ alertActionSure, alertAction_01, alertAction_02,alertActionCancle]];
    
    [alertManager ys_show];
}





@end
