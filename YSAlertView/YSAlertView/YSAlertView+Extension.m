//
//  YSAlertView+Extension.m
//  YSAlertView
//
//  Created by 杨森 on 2017/11/29.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "YSAlertView+Extension.h"
#import <objc/runtime.h>

@implementation NSString(YSExtension)

- (CGFloat)ys_stringHeightWithWidth:(CGFloat)width systemFontSize:(CGFloat)fontSize{
    
    return [self ys_stringSizeWithWidth:width height:NSIntegerMax sytemFontSize:fontSize].height;
}
- (CGFloat)ys_stringHeightWithWidth:(CGFloat)width font:(UIFont *)font{
    
    return [self ys_stringSizeWithWidth:width height:NSUIntegerMax font:font].height;
}

- (CGFloat)ys_stringWidthWithHeight:(CGFloat)height systemFontSize:(CGFloat)fontSize{
    
    return [self ys_stringSizeWithWidth:NSIntegerMax height:height sytemFontSize:fontSize].width;
}
- (CGFloat)ys_stringWidthWithHeight:(CGFloat)height font:(UIFont *)font{
    return [self ys_stringSizeWithWidth:NSIntegerMax height:height font:font].width;
}

- (CGSize)ys_stringSizeWithWidth:(CGFloat)width height:(CGFloat)height sytemFontSize:(CGFloat)fontSize{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return [self ys_stringSizeWithWidth:NSIntegerMax height:height font:font];
}

- (CGSize)ys_stringSizeWithWidth:(CGFloat)width height:(CGFloat)height font:(UIFont *)font{
    return [self boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil].size;
}

@end

@implementation UIButton(YSExtension)

- (void (^)(UIButton *))clickHandle {
    return objc_getAssociatedObject(self, @"clickHandle");
}

- (void)setClickHandle:(void (^)(UIButton *))clickHandle {
    objc_setAssociatedObject(self, @"clickHandle", clickHandle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if (self.clickHandle) {
        self.clickHandle(self);
    }
}

@end

@implementation UIImage(YSExtension)

+ (UIImage *)ys_imageWithColor:(UIColor *)color{
    
    return [self ys_imageWithColor:color size:CGSizeMake(1.0, 1.0)];
}

+ (UIImage *)ys_imageWithColor:(UIColor *)color size:(CGSize)size{
    if (size.width < 0.5 || size.height < 0.5) {
        return nil;
    }
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef ct = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ct, color.CGColor);
    CGContextFillRect(ct, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

@implementation NSObject(YSExtension)


+ (void)ys_swizzingSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector{
    Method originalMethod = class_getInstanceMethod([self class], originalSelector);
    Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod([self class], originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod)
    {
        class_replaceMethod([self class], swizzledSelector, method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}




@end



