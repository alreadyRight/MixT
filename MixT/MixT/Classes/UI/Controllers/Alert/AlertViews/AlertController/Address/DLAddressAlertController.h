//
//  DLAddressAlertController.h
//  整理
//
//  Created by 周冰烽 on 2020/7/21.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLAddressAlertController : UIViewController

@property(nonatomic, copy) void(^selectValues)(NSArray *addressArray);

@end

NS_ASSUME_NONNULL_END
