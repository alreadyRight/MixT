//
//  DLCompareProtocol.h
//  MixT
//
//  Created by 周冰烽 on 2020/8/24.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DLCompareProtocol <NSObject>
@required

- (int)compareWithObject1:(id)object1 object2:(id)object2;

@end

NS_ASSUME_NONNULL_END
