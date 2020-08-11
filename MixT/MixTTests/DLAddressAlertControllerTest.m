//
//  DLAddressAlertControllerTest.m
//  整理Tests
//
//  Created by 周冰烽 on 2020/7/22.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DLAddressAlertController.h"
@interface DLAddressAlertControllerTest : XCTestCase

@end

@interface DLAddressAlertController (DLAddressAlertControllerTest)
// 私有方法测试
- (id)getDataFromPathName:(NSString *)pathName;

@end

@implementation DLAddressAlertControllerTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testGetDataFromPathName {
    DLAddressAlertController *addAlertC = [[DLAddressAlertController alloc] init];
    XCTAssertNotNil([addAlertC getDataFromPathName:@"area"], @"area.json数据获取失败");
    XCTAssertNotNil([addAlertC getDataFromPathName:@"city"], @"city.json数据获取失败");
    XCTAssertNotNil([addAlertC getDataFromPathName:@"province"], @"province.json数据获取失败");
    XCTAssertNotNil([addAlertC getDataFromPathName:@"hotCity"], @"hotCity.json数据获取失败");
    XCTAssertNil([addAlertC getDataFromPathName:@"xxzasd"], @"不存在的json文件测试失败");
}

@end
