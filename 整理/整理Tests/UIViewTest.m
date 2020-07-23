//
//  UIView+DLSizeTest.m
//  整理Tests
//
//  Created by 周冰烽 on 2020/7/23.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIView+DLSize.h"
@interface UIViewTest : XCTestCase

@property(nonatomic, strong) UIView * testView;

@end

/**
 @property (nonatomic, assign) CGSize size;

 @property (nonatomic, assign) CGPoint origin;

 @property (nonatomic,assign) CGFloat centerX;

 @property (nonatomic,assign) CGFloat centerY;
 
 */
@implementation UIViewTest

- (void)setUp {
    [super setUp];
    self.testView = [[UIView alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testX {
    self.testView.x = 80;
    XCTAssertEqual(self.testView.x, 80, @"视图x测试不通过");
    XCTAssertEqual(self.testView.x, self.testView.frame.origin.x, @"视图x测试不通过");
    XCTAssertEqual(self.testView.frame.origin.x, 80, @"视图x测试不通过");
}

- (void)testY {
    self.testView.y = 80;
    XCTAssertEqual(self.testView.y, 80, @"视图sy测试不通过");
    XCTAssertEqual(self.testView.frame.origin.y, 80, @"视图sy测试不通过");
    XCTAssertEqual(self.testView.y, self.testView.frame.origin.y, @"视图sy测试不通过");
}

- (void)testWidth {
    self.testView.width = 200;
    XCTAssertEqual(self.testView.width, 200, @"视图width测试不通过");
    XCTAssertEqual(self.testView.frame.size.width, 200, @"视图width测试不通过");
    XCTAssertEqual(self.testView.width, self.testView.frame.size.width, @"视图width测试不通过");
}

- (void)testHeight {
    self.testView.height = 400;
    XCTAssertEqual(self.testView.height, 400, @"视图height测试不通过");
    XCTAssertEqual(self.testView.frame.size.height, 400, @"视图height测试不通过");
    XCTAssertEqual(self.testView.height, self.testView.frame.size.height, @"视图height测试不通过");
}

- (void)testSize{
    self.testView.dl_size = CGSizeMake(100, 200);
    XCTAssertTrue(CGSizeEqualToSize(self.testView.dl_size, CGSizeMake(100, 200)), @"视图size测试不通过");
    XCTAssertTrue(CGSizeEqualToSize(self.testView.frame.size, CGSizeMake(100, 200)), @"视图size测试不通过");
    XCTAssertTrue(CGSizeEqualToSize(self.testView.dl_size, self.testView.frame.size), @"视图size测试不通过");
}

- (void)testOrigin {
    self.testView.dl_origin = CGPointMake(40, 50);
    XCTAssertTrue(CGPointEqualToPoint(self.testView.dl_origin, CGPointMake(40, 50)), @"视图origin测试不通过");
    XCTAssertTrue(CGPointEqualToPoint(self.testView.frame.origin, CGPointMake(40, 50)), @"视图origin测试不通过");
    XCTAssertTrue(CGPointEqualToPoint(self.testView.dl_origin, self.testView.frame.origin), @"视图origin测试不通过");
}

- (void)testCenterX {
    self.testView.centerX = 50;
    XCTAssertEqual(self.testView.centerX, 50, @"视图centerX测试不通过");
    XCTAssertEqual(self.testView.center.x, 50, @"视图centerX测试不通过");
    XCTAssertEqual(self.testView.center.x, self.testView.centerX, @"视图centerX测试不通过");
}

- (void)testCenterY {
    self.testView.centerY = 50;
    XCTAssertEqual(self.testView.centerY, 50, @"视图centerY测试不通过");
    XCTAssertEqual(self.testView.center.y, 50, @"视图centerY测试不通过");
    XCTAssertEqual(self.testView.center.y, self.testView.centerY, @"视图centerY测试不通过");
}
@end
