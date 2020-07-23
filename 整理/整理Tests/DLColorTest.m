//
//  DLColorTest.m
//  整理Tests
//
//  Created by 周冰烽 on 2020/7/23.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIColor+DLAddtion.h"
@interface DLColorTest : XCTestCase

@end

@implementation DLColorTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testRandomColor {
    for (int i = 0; i < 100; i++) {
        XCTAssertNotNil([UIColor RandomColor], @"UIColor+DLAddition的randomColor为空,测试失败");
    }

}

@end
