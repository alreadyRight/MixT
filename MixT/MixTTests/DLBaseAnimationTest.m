//
//  DLBaseAnimationTest.m
//  整理Tests
//
//  Created by 周冰烽 on 2020/7/23.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DLBaseAnimation.h"
#import "DLAddressAnimation.h"
#import "DLDateAnimation.h"
#import "DLAnimationFading.h"
#import "DLAnimationLeft.h"
#import "DLAnimationRight.h"
#import "DLAnimationTop.h"
#import "DLAnimationBottom.h"
#import "DLAnimationCenterFromTop.h"
#import "DLAnimationCenterFromBottom.h"

@interface DLBaseAnimationTest : XCTestCase

@end

//@interface TestTransition : NSObject<UIViewControllerContextTransitioning>
//
//@end

@implementation DLBaseAnimationTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testTransitionDuration {
    
//    id<UIViewControllerContextTransitioning> transitionContext = [TestTransition new];
    
    DLBaseAnimation *animation1 = [[DLBaseAnimation alloc] init];
    XCTAssertEqual([animation1 transitionDuration:nil], 0);
    XCTAssertNoThrow([animation1 animateTransition:nil]);
    
    DLAddressAnimation *animation2 = [[DLAddressAnimation alloc] init];
    XCTAssertEqual([animation2 transitionDuration:nil], 0);
    XCTAssertNoThrow([animation2 animateTransition:nil]);
    
    DLDateAnimation *animation3 = [[DLDateAnimation alloc] init];
    XCTAssertEqual([animation3 transitionDuration:nil], 0);
    XCTAssertNoThrow([animation3 animateTransition:nil]);
    
    DLAnimationFading *animation4 = [[DLAnimationFading alloc] init];
    XCTAssertEqual([animation4 transitionDuration:nil], 0);
    XCTAssertNoThrow([animation4 animateTransition:nil]);
    
    DLAnimationLeft *animation5 = [[DLAnimationLeft alloc] init];
    XCTAssertEqual([animation5 transitionDuration:nil], 0);
    XCTAssertNoThrow([animation5 animateTransition:nil]);
    
    DLAnimationRight *animation6 = [[DLAnimationRight alloc] init];
    XCTAssertEqual([animation6 transitionDuration:nil], 0);
    XCTAssertNoThrow([animation6 animateTransition:nil]);
    
    DLAnimationTop *animation7 = [[DLAnimationTop alloc] init];
    XCTAssertEqual([animation7 transitionDuration:nil], 0);
    XCTAssertNoThrow([animation7 animateTransition:nil]);
    
    DLAnimationBottom *animation8 = [[DLAnimationBottom alloc] init];
    XCTAssertEqual([animation8 transitionDuration:nil], 0);
    XCTAssertNoThrow([animation8 animateTransition:nil]);
    
    DLAddressAnimation *animation9 = [[DLAddressAnimation alloc] init];
    XCTAssertEqual([animation9 transitionDuration:nil], 0);
    XCTAssertNoThrow([animation9 animateTransition:nil]);
    
    DLAnimationCenterFromTop *animation10 = [[DLAnimationCenterFromTop alloc] init];
    XCTAssertEqual([animation10 transitionDuration:nil], 0);
    XCTAssertNoThrow([animation10 animateTransition:nil]);
    
    DLAnimationCenterFromBottom *animation11 = [[DLAnimationCenterFromBottom alloc] init];
    XCTAssertEqual([animation11 transitionDuration:nil], 0);
    XCTAssertNoThrow([animation11 animateTransition:nil]);
}

@end
