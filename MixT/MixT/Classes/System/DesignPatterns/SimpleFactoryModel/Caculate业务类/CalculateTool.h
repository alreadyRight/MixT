//
//  CaculateTool.h
//  设计模式-01
//
//  Created by 周冰烽 on 2020/12/20.
//  计算类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CalculateTool : NSObject

@property(nonatomic, assign) CGFloat num1;

@property(nonatomic, assign) CGFloat num2;

- (CGFloat)calculateToolResult;

//+ (NSString *)getResultWithNum1:(CGFloat)num1 num2:(CGFloat)num2 operation:(NSString *)operation;

@end

NS_ASSUME_NONNULL_END
