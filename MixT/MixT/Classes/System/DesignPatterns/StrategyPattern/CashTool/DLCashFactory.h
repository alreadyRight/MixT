//
//  DLCashFactory.h
//  MixT
//
//  Created by 周冰烽 on 2021/2/3.
//  Copyright © 2021 周冰烽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLCashSuper.h"
NS_ASSUME_NONNULL_BEGIN

@interface DLCashFactory : NSObject

- (DLCashSuper *)createCashWithType:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
