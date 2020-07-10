//
//  UIColor+DLGlobalColor.m
//  整理
//
//  Created by 周冰烽 on 2020/6/4.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "UIColor+DLGlobalColor.h"
#import "UIColor+DLAddtion.h"


@implementation UIColor (DLGlobalColor)

+ (UIColor *)screenColor {
    if (@available(iOS 13.0, *)) {
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            return [UIColor ColorWithHex:0xffffff alpha:1.0];
        } else {
            return [UIColor ColorWithHex:0x000000 alpha:1.0];
        }
    }  else {
        return [UIColor ColorWithHex:0xffffff alpha:1.0];
    }
}

+ (UIColor *)normalTextColor {
    if (@available(iOS 13.0, *)) {
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            return [UIColor ColorWithHex:0x292929 alpha:1.0];
        } else {
            return [UIColor ColorWithHex:0xffffff alpha:1.0];
        }
    }  else {
        return [UIColor ColorWithHex:0x292929 alpha:1.0];
    }
}

+ (UIColor *)detailTextColor {
    if (@available(iOS 13.0, *)) {
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            return [UIColor ColorWithHex:0x424242 alpha:1.0];
        } else {
            return [UIColor ColorWithHex:0xf5f5f5 alpha:1.0];
        }
    }  else {
        return [UIColor ColorWithHex:0x292929 alpha:1.0];
    }
}

+ (UIColor *)navigationColor {
    if (@available(iOS 13.0, *)) {
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            return [UIColor ColorWithHex:0xF7F6F6 alpha:1.0];
        } else {
            return [UIColor ColorWithHex:0x000000 alpha:1.0];
        }
    } else {
        return [UIColor ColorWithHex:0xF7F6F6 alpha:1.0];
    }
}

+ (UIColor *)lineColor {
    if (@available(iOS 13.0, *)) {
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            return [UIColor ColorWithHex:0xECEDEE alpha:1.0];
        } else {
            return [UIColor ColorWithHex:0x2E2F31 alpha:1.0];
        }
    } else {
        return [UIColor ColorWithHex:0xECEDEE alpha:1.0];
    }
}

@end
