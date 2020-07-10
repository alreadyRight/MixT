//
//  UIImage+DLGlobalImage.m
//  整理
//
//  Created by 周冰烽 on 2020/6/5.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "UIImage+DLGlobalImage.h"

@implementation UIImage (DLGlobalImage)

+ (instancetype)backIcon {
    if (@available(iOS 13.0, *)) {
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            return [UIImage imageNamed:@"back_black_icon"];
        } else {
            return [UIImage imageNamed:@"back_white_icon"];
        }
    } else {
        return [UIImage imageNamed:@"back_black_icon"];
    }
}

/// 重新绘制图片尺寸
/// @param image 要绘制的图片
/// @param size 绘制后的大小
+ (instancetype)scaleImage:(UIImage *)image toSize:(CGSize)size {
    UIImage *oldImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(size);
    
    CGRect rect = CGRectZero;
    rect.origin = CGPointZero;
    rect.size.width = size.width;
    rect.size.height = size.height;
    
    [oldImage drawInRect:rect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
