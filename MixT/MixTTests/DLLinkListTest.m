//
//  DLLinkListTest.m
//  整理Tests
//
//  Created by 周冰烽 on 2020/8/10.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DLSingleLinkList.h"
#import "DLSingleCircleList.h"

#import "DLLinkList.h"
#import "DLCircleLinkList.h"

@interface DLLinkListTest : XCTestCase

@property(nonatomic, strong) DLSingleLinkList * list1; // 单向链表

@property(nonatomic, strong) DLSingleCircleList * list2; // 单向环形链表

@property(nonatomic, strong) DLLinkList * list3; // 双向链表

@property(nonatomic, strong) DLCircleLinkList * list4; // 双向循环链表

@end

@implementation DLLinkListTest

- (void)setUp {
    self.list1 = [[DLSingleLinkList alloc] init];
    self.list2 = [[DLSingleCircleList alloc] init];
    self.list3 = [[DLLinkList alloc] init];
    self.list4 = [[DLCircleLinkList alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)reset {
    [self.list1 clear];
    [self.list2 clear];
    [self.list3 clear];
    [self.list4 clear];
    for (NSInteger i = 0; i < 10; i++) {
        [self.list1 addObject:@(i)];
        [self.list2 addObject:@(i)];
        [self.list3 addObject:@(i)];
        [self.list4 addObject:@(i)];
    }
}

- (void)testgetWithIndex {
    [self reset];
    for (NSInteger i = 0; i < 10; i++) {
        XCTAssertTrue([[self.list1 getWithIndex:i] isEqual:@(i)]);
        XCTAssertTrue([[self.list2 getWithIndex:i] isEqual:@(i)]);
        XCTAssertTrue([[self.list3 getWithIndex:i] isEqual:@(i)]);
        XCTAssertTrue([[self.list4 getWithIndex:i] isEqual:@(i)]);
    }
}

- (void)testSetIndex {
    [self reset];
    XCTAssertNoThrow([self.list1 setWithIndex:0 object:@0]);
    XCTAssertNoThrow([self.list2 setWithIndex:0 object:@0]);
    XCTAssertNoThrow([self.list3 setWithIndex:0 object:@0]);
    XCTAssertNoThrow([self.list4 setWithIndex:0 object:@0]);
}

- (void)testAddObject {
    [self reset];
    XCTAssertNoThrow([self.list1 addObject:@10]);
    XCTAssertNoThrow([self.list2 addObject:@10]);
    XCTAssertNoThrow([self.list3 addObject:@10]);
    XCTAssertNoThrow([self.list4 addObject:@10]);
}

- (void)testRemoveWithIndex {
    [self reset];
    NSInteger i = 9;
    while (i >= 0) {
        XCTAssertTrue([[self.list1 removeWithIndex:i] isEqual:@(i)]);
        XCTAssertTrue([[self.list2 removeWithIndex:i] isEqual:@(i)]);
        XCTAssertTrue([[self.list3 removeWithIndex:i] isEqual:@(i)]);
        XCTAssertTrue([[self.list4 removeWithIndex:i] isEqual:@(i)]);
        i--;
    }
}

- (void)testIndexOfWithIndex {
    [self reset];
    for (NSInteger i = 0; i < 10; i++) {
        XCTAssertEqual([self.list1 indexOfObject:@(i)], i);
        XCTAssertEqual([self.list2 indexOfObject:@(i)], i);
        XCTAssertEqual([self.list3 indexOfObject:@(i)], i);
        XCTAssertEqual([self.list4 indexOfObject:@(i)], i);
    }
}

- (void)testSize {
    [self reset];
    XCTAssertEqual([self.list1 size], 10);
    XCTAssertEqual([self.list2 size], 10);
    XCTAssertEqual([self.list3 size], 10);
    XCTAssertEqual([self.list4 size], 10);
}

- (void)testIsEmpty {
    [self reset];
    XCTAssertFalse([self.list1 isEmpty]);
    XCTAssertFalse([self.list2 isEmpty]);
    XCTAssertFalse([self.list3 isEmpty]);
    XCTAssertFalse([self.list4 isEmpty]);
    [self.list1 clear];
    [self.list2 clear];
    [self.list3 clear];
    [self.list4 clear];
    XCTAssertTrue([self.list1 isEmpty]);
    XCTAssertTrue([self.list2 isEmpty]);
    XCTAssertTrue([self.list3 isEmpty]);
    XCTAssertTrue([self.list4 isEmpty]);
}

- (void)testContainsObject {
    [self reset];
    for (NSInteger i = 0; i < 10; i++) {
        XCTAssertTrue([self.list1 containsObject:@(i)]);
        XCTAssertTrue([self.list2 containsObject:@(i)]);
        XCTAssertTrue([self.list3 containsObject:@(i)]);
        XCTAssertTrue([self.list4 containsObject:@(i)]);
    }
}



@end
