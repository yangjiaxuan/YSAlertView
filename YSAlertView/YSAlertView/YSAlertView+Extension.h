//
//  YSAlertView+Extension.h
//  YSAlertView
//
//  Created by 杨森 on 2017/11/29.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString(YSExtension)

/* 字符串高度 */
- (CGFloat)ys_stringHeightWithWidth:(CGFloat)width systemFontSize:(CGFloat)fontSize;
- (CGFloat)ys_stringHeightWithWidth:(CGFloat)width font:(UIFont *_Nullable)font;

/* 字符串宽度*/
- (CGFloat)ys_stringWidthWithHeight:(CGFloat)height systemFontSize:(CGFloat)fontSize;
- (CGFloat)ys_stringWidthWithHeight:(CGFloat)height font:(UIFont *_Nullable)font;

/* 字符串大小*/
- (CGSize)ys_stringSizeWithWidth:(CGFloat)width height:(CGFloat)height sytemFontSize:(CGFloat)fontSize;
- (CGSize)ys_stringSizeWithWidth:(CGFloat)width height:(CGFloat)height font:(UIFont *_Nullable)font;

@end

@interface UIButton(YSExtension)

@property (nonatomic ,  copy, nonnull)void (^clickHandle)(UIButton *_Nullable);

@end

@interface UIImage(YSExtension)

+ (UIImage *_Nullable)ys_imageWithColor:(UIColor *_Nullable)color;

+ (UIImage *_Nullable)ys_imageWithColor:(UIColor *_Nullable)color size:(CGSize)size;

@end

@interface NSObject(YSExtension)

@end

