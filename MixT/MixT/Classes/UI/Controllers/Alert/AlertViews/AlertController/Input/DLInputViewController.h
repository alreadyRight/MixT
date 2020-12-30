//
//  DLInputViewController.h
//  MixT
//
//  Created by 周冰烽 on 2020/10/26.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLInputViewController : UIViewController

@property(nonatomic, copy) void(^pinValue)(NSString *pinValue);

@end

NS_ASSUME_NONNULL_END
