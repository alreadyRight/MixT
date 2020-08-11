//  自适应文字图片按钮
//
//  UIButton+DLAdaptiveButton.m
//  整理
//
//  Created by 周冰烽 on 2020/6/5.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "UIButton+DLAdaptiveButton.h"

#define kDefaultSpace 10.0f

@implementation UIButton (DLAdaptiveButton)

- (instancetype)initHorizontalWithTitle:(NSString *)title image:(UIImage *)image {
    return [self initWithTitle:title titleFont:nil titleColor:nil image:image spacing:0 directOption:DirectOptionHorizontalLeftImageRightText];
}

- (instancetype)initVerticalWithTitle:(NSString *)title image:(UIImage *)image {
    return [self initWithTitle:title titleFont:nil titleColor:nil image:image spacing:0 directOption:DirectOptionVerticalTopImageBottomText];
}

- (instancetype)initWithTitle:(NSString *)title
                      titleFont:(nullable UIFont *)titleFont
                     titleColor:(nullable UIColor *)titleColor
                          image:(UIImage *)image
                        spacing:(CGFloat)spacing
                   directOption:(DirectOption)directOption {
    if (self = [super init]) {
        // 设置允许为空的默认值
        titleFont = titleFont == nil ? [UIFont systemFontOfSize:18.0f] : titleFont;
        titleColor = titleColor == nil ? [UIColor normalTextColor] : titleColor;
        spacing = spacing == 0 ? 5 : spacing;
        self.frame = [self caculateFramesWithTitle:title font:titleFont image:image spacing:spacing option:directOption];
        UILabel *buttonLabel = [[UILabel alloc] init];
        buttonLabel.text = title;
        buttonLabel.font = titleFont;
        buttonLabel.textColor = titleColor;
        [self addSubview:buttonLabel];
        UIImageView *buttonImageView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:buttonImageView];
        [self addMasonryConstraintWithLabel:buttonLabel imageView:buttonImageView spacing:spacing option:directOption];
    }
    return self;
}

- (void)addMasonryConstraintWithLabel:(UILabel *)label imageView:(UIImageView *)imageView spacing:(CGFloat)spacing option:(DirectOption)option {
    switch (option) {
        case DirectOptionVerticalTopImageBottomText:
        {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(self).offset(kDefaultSpace / 2.0);
            }];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(imageView.mas_bottom).offset(spacing);
            }];
        }
            break;
        case DirectOptionVerticalTopTextBottomImage:
        {
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(self).offset(kDefaultSpace / 2.0);
            }];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(label.mas_bottom).offset(spacing);
            }];
        }
            break;
        case DirectOptionHorizontalLeftImageRightText:
        {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(kDefaultSpace / 2.0);
                make.centerY.equalTo(self);
            }];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(imageView.mas_right).offset(spacing);
            }];
        }
            break;
        case DirectOptionHorizontalLeftTextRightImage:
        {
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(kDefaultSpace / 2.0);
                make.centerY.equalTo(self);
            }];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(label.mas_right).offset(spacing);
            }];
        }
            break;
        default:
            break;
    }
}

// 计算按钮宽度和高度
- (CGRect)caculateFramesWithTitle:(NSString *)title font:(UIFont *)font image:(UIImage *)image spacing:(CGFloat)spacing option:(DirectOption)option {
    CGRect revFrame = CGRectZero;
    // 获取标题的size
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName: font}];
    // 获取图片的size
    CGSize imageSize = image.size;
    CGFloat width = 0;
    CGFloat height = 0;
    if (option == DirectOptionHorizontalLeftTextRightImage || option == DirectOptionHorizontalLeftImageRightText) {
        // 按钮为横向展示的
        width = titleSize.width + imageSize.width + spacing + kDefaultSpace;
        height = titleSize.height > imageSize.height ? titleSize.height + kDefaultSpace : imageSize.height + kDefaultSpace;
    } else {
        // 按钮为竖向展示的
        width = titleSize.width > imageSize.width ? titleSize.width + kDefaultSpace : imageSize.width + kDefaultSpace;
        height = titleSize.height + imageSize.height + spacing + kDefaultSpace;
    }
    revFrame = CGRectMake(0, 0, width, height);
    return revFrame;
}

@end
