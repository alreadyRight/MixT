//
//  UIView+DLSize.m
//  回顾
//
//  Created by 周冰烽 on 2017/11/28.
//  Copyright © 2017年 devil. All rights reserved.
//

#import "UIView+DLSize.h"

@implementation UIView (DLSize)

- (void)setX:(CGFloat)x{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setDl_size:(CGSize)dl_size {
    CGRect rect = self.frame;
    rect.size = dl_size;
    self.frame = rect;
}

- (CGSize)dl_size {
    return self.frame.size;
}

- (void)setDl_origin:(CGPoint)dl_origin {
    CGRect rect = self.frame;
    rect.origin = dl_origin;
    self.frame = rect;
}

- (CGPoint)dl_origin {
    return self.frame.origin;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY{
    return self.center.y;
}
@end
