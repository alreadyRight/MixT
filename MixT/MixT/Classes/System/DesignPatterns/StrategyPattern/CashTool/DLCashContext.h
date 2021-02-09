//
//  DLCashContext.h
//  MixT
//
//  Created by mintai on 2021/2/7.
//  Copyright © 2021 周冰烽. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLCashContext : NSObject

- (instancetype)initWithType:(NSString *)type;

- (CGFloat)getResultWithAmount:(CGFloat)amount;

@end

NS_ASSUME_NONNULL_END
