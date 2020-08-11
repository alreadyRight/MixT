//
//  BMKMapVersion.h
//  MapComponent
//
//  Created by wzy on 15/9/9.
//  Copyright © 2015年 baidu. All rights reserved.
//

#ifndef BMKMapVersion_h
#define BMKMapVersion_h

#import <UIKit/UIKit.h>

/**
 *重要：
 *map组件的版本和base组件的版本必须一致，否则不能正常使用
 */

/**
 *获取当前地图API map组件 的版本号
 *return  返回当前API map组件 的版本号
 */
UIKIT_EXTERN NSString* BMKGetMapApiMapComponentVersion(void);

/**
 *检查map组件的版本号是否和base组件的版本号一致
 *return    版本号一致返回YES
 */
UIKIT_EXTERN BOOL BMKCheckMapComponentIsLegal(void);

#endif /* BMKMapVersion_h */
