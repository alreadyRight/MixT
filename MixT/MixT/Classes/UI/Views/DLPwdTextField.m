//
//  DLPwdTextField.m
//  MixT
//
//  Created by Aurora on 2023/9/9.
//  Copyright © 2023 周冰烽. All rights reserved.
//

#import "DLPwdTextField.h"

@interface DLPwdTextField ()

@property(nonatomic, assign)NSInteger gridCount; // 密码个数

@property (nonatomic, strong) NSMutableArray *contextLayers; // 总体框

@property (nonatomic, strong) NSMutableArray *shapeLayers; // 小圆点绘制layer

@property (nonatomic, assign) NSInteger pointCount; // 小圆点个数

@end

@implementation DLPwdTextField

- (BOOL)becomeFirstResponder {
    // 成为第一响应者时添加阴影
    [self setFocusColor];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    // 失去响应者身份时移除阴影
    self.layer.shadowOpacity = 0;
    [self.contextLayers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAShapeLayer *layer = obj;
        layer.shadowOpacity = 0;
        layer.strokeColor = [UIColor ColorWithHex:0xFFE5E5E5 alpha:1.0].CGColor;
    }];
    return [super resignFirstResponder];
}

- (void)setFocusColor {
    if (self.text.length == self.contextLayers.count) {
        // 最后一个聚焦
        CAShapeLayer *layer = self.contextLayers.lastObject;
        layer.strokeColor = [UIColor ColorWithHex:0xFF1677FF alpha:1.0].CGColor;
        layer.shadowColor = [UIColor ColorWithHex:0xFF1677FF alpha:1.0].CGColor;
        layer.shadowOffset = CGSizeMake(0, 0);
        layer.shadowOpacity = 2;
        return;
    }
    // 设置焦点
    [self.contextLayers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAShapeLayer *layer = obj;
        if (idx == self.text.length) {
            // 当前选中的更改颜色
            layer.strokeColor = [UIColor ColorWithHex:0xFF1677FF alpha:1.0].CGColor;
            layer.shadowColor = [UIColor ColorWithHex:0xFF1677FF alpha:10].CGColor;
            layer.shadowOffset = CGSizeMake(0, 0);
            layer.shadowOpacity = 2;
        } else {
            layer.strokeColor = [UIColor ColorWithHex:0xFFE5E5E5 alpha:1.0].CGColor;
            layer.shadowOpacity = 0;
        }
    }];
}

- (void)clear {
    // 清空密码大部分情况会在网络请求失败后执行, 所以放到主线程中执行UI操作
    dispatch_async(dispatch_get_main_queue(), ^{
        self.text = @"";
        self.pointCount = 0;
        [self.shapeLayers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperlayer];
        }];
        [self.shapeLayers removeAllObjects];
        // 设置焦点
        [self setFocusColor];
    });
}

- (void)textChanged {
    if (self.text.length <= self.gridCount) {
        self.isFinish = NO;
        CGFloat space = 12.f; // 间隔
        CGFloat width = (self.width - space * (self.gridCount-1)) / self.gridCount;
        // 绘制圆点
        [self setRoundPoint:CGPointMake((width+space) * self.text.length - width / 2.0 - space, width / 2.0) pointCount:self.text.length];
        // 设置焦点
        [self setFocusColor];
    }
    if (self.text.length >= self.gridCount) {
        // 输入密码完成
        self.text = [self.text substringToIndex:(self.gridCount)];
        if (!self.isFinish) {
            if (self.pwdDelegate && [self.pwdDelegate respondsToSelector:@selector(textFieldDidFinishEditing:)]) {
                [self.pwdDelegate textFieldDidFinishEditing:self];
            }
        }
    }
}

- (void)setRoundPoint:(CGPoint)center pointCount:(NSInteger)count {
    if (self.pointCount == count) {
        return;
    }
    if (self.pointCount > count) {
        CAShapeLayer *sp = self.shapeLayers.lastObject;
        [self.shapeLayers removeLastObject];
        [sp removeFromSuperlayer];
        self.pointCount = count;
        return;
    }
    self.pointCount = count;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:center radius:5 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    //线宽和颜色
    shapeLayer.lineWidth = 1;
    UIColor *color = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    shapeLayer.strokeColor = color.CGColor;
    
    shapeLayer.fillColor = color.CGColor;
    shapeLayer.path = path.CGPath;
    
    [self.layer addSublayer:shapeLayer];
    [self.shapeLayers addObject:shapeLayer];
}
// 去掉复制粘贴功能
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

- (instancetype)init {
    // 默认创建4位密码
    return [self initWithFrame:CGRectZero gridCount:4];
}

- (instancetype)initWithFrame:(CGRect)frame {
    // 默认创建4位密码
    return [self initWithFrame:frame gridCount:4];
}

- (instancetype)initWithFrame:(CGRect)frame gridCount:(NSInteger)gridCount {
    if (self = [super initWithFrame:frame]) {
        self.gridCount = gridCount;
        self.isFinish = NO;
        self.shapeLayers = [NSMutableArray array];
        self.contextLayers = [NSMutableArray array];
        self.pointCount = 0;
        self.tintColor = [UIColor clearColor];
        self.textColor = [UIColor clearColor];
        // 为防止用masonry布局获取不到frame具体信息,延迟0.0秒执行UI渲染操作
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setupUI];
        });
        self.keyboardType = UIKeyboardTypeNumberPad;
        [self addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)setupUI {
    CGFloat space = 12.f; // 间隔
    CGFloat width = (self.width - space * (self.gridCount-1)) / self.gridCount;
    CGFloat height = width;
    
    for (int i = 0; i < self.gridCount; i ++) {
        // 绘制输入框
        UIBezierPath *path;
        if (i == 0) {
            path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, width, height) cornerRadius:5.0];
        } else {
            path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(i*(width+space), 0, width, height) cornerRadius:5.0];
        }
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        //线宽和颜色
        shapeLayer.lineWidth = 1;
        shapeLayer.strokeColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:212/255.0 alpha:1].CGColor;
        shapeLayer.fillColor = [UIColor whiteColor].CGColor;
        shapeLayer.path = path.CGPath;
        [self.contextLayers addObject:shapeLayer];
        [self.layer addSublayer:shapeLayer];
    }
}

- (void)dealloc {
    [self.contextLayers removeAllObjects];
    [self.shapeLayers removeAllObjects];
}

@end
