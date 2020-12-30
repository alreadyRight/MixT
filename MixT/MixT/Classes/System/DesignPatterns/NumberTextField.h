//
//  NumberTextField.h
//  设计模式-01
//
//  Created by 周冰烽 on 2020/12/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NumberTextField : UIView

@property(nonatomic, assign) CGFloat res;

@property(nonatomic, copy) NSString * placeholder;

@property(nonatomic, copy) NSString * text;

@end

NS_ASSUME_NONNULL_END
