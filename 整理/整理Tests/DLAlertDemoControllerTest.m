//
//  DLAlertDemoControllerTest.m
//  整理Tests
//
//  Created by 周冰烽 on 2020/7/23.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DLAlertDemoController.h"
@interface DLAlertDemoControllerTest : XCTestCase

@end

@interface DLAlertDemoController (Test)

- (void)setupUI;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end

@implementation DLAlertDemoControllerTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testSetupUI {
    DLAlertDemoController *alertVC = [[DLAlertDemoController alloc] init];
    for (int i = 0; i < 100; i++) {
        XCTAssertNoThrow([alertVC setupUI]);
    }
}

- (void)testTableViewDidSelectRow {
    NSIndexPath *indexPath = nil;
    DLAlertDemoController *alertDemoVC = [[DLAlertDemoController alloc] init];
    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 10; j++) {
            indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            UITableView *tableView = [[UITableView alloc] init];
            XCTAssertNoThrow([alertDemoVC tableView:tableView didSelectRowAtIndexPath:indexPath]);
        }
    }
}

@end
