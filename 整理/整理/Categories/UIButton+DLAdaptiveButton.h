//
//  UIButton+DLAdaptiveButton.h
//  整理
//
//  Created by 周冰烽 on 2020/6/5.
//  Copyright © 2020 周冰烽. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    DirectOptionVerticalTopImageBottomText, // The picture is above of the text
    DirectOptionVerticalTopTextBottomImage, // The text is above of the picture
    DirectOptionHorizontalLeftTextRightImage, // The text is on the left of the picture
    DirectOptionHorizontalLeftImageRightText, // The picture is on the right of the text
} DirectOption;

@interface UIButton (DLAdaptiveButton)

/// 自适应图片文字(横向,左图片右文字)按钮
/// @param title 按钮文字
/// @param image 按钮图片
- (instancetype)initHorizontalWithTitle:(NSString *)title image:(UIImage *)image;

/// 自适应图片文字(竖向)按钮
/// @param title 按钮文字
/// @param image 按钮图片
- (instancetype)initVerticalWithTitle:(NSString *)title image:(UIImage *)image;

/// 自适应图片文字按钮
/// @param title 按钮文字
/// @param titleFont 按钮文字字体样式
/// @param titleColor 按钮文字颜色
/// @param image 按钮图片
/// @param spacing 文字图片的间隔
/// @param directOption 摆放样式
- (instancetype)initWithTitle:(NSString *)title
                    titleFont:(nullable UIFont *)titleFont
                   titleColor:(nullable UIColor *)titleColor
                        image:(UIImage *)image
                      spacing:(CGFloat)spacing
                 directOption:(DirectOption)directOption;

@end

NS_ASSUME_NONNULL_END
