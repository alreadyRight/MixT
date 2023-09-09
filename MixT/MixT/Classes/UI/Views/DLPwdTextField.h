//
//  DLPwdTextField.h
//  MixT
//
//  Created by Aurora on 2023/9/9.
//  Copyright © 2023 周冰烽. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DLPwdTextFieldDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface DLPwdTextField : UITextField

@property(nonatomic, weak)id<DLPwdTextFieldDelegate> pwdDelegate;

@property (nonatomic, assign) BOOL isFinish;

/// 定义位数的初始化方法
/// - Parameters:
///   - frame: frame
///   - gridCount: 设定密码位数
- (instancetype) initWithFrame:(CGRect)frame gridCount:(NSInteger)gridCount;

- (void)clear;

@end

@protocol DLPwdTextFieldDelegate <NSObject>

@required
- (void)textFieldDidFinishEditing:(DLPwdTextField *)textField;

@end

NS_ASSUME_NONNULL_END
