//
//  DLCustomAlertController.h
//  整理
//
//  Created by 周冰烽 on 2020/7/20.
//  Copyright © 2020 周冰烽. All rights reserved.
//
// 该类适合已经固定的选择数据,如果是变动的数据比如网络请求的数据需要自定义,不联动

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLCustomAlertController : UIViewController

/// 弹出框数据,以[[]]的格式传入
@property(nonatomic, strong) NSArray * pickerDatas;

@property(nonatomic, copy) void(^selectValues)(NSArray *selectValues);

@end

NS_ASSUME_NONNULL_END
