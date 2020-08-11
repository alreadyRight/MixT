/*
 *  BMKAnnotationView.h
 *  BMapKit
 *
 *  Copyright 2011 Baidu Inc. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>
#import "BMKActionPaopaoView.h"

#if __IPHONE_3_2 <= __IPHONE_OS_VERSION_MAX_ALLOWED

enum {
    BMKAnnotationViewDragStateNone = 0,      ///< 静止状态.
    BMKAnnotationViewDragStateStarting,      ///< 开始拖动
    BMKAnnotationViewDragStateDragging,      ///< 拖动中
    BMKAnnotationViewDragStateCanceling,     ///< 取消拖动
    BMKAnnotationViewDragStateEnding         ///< 拖动结束
};

typedef NSUInteger BMKAnnotationViewDragState;

#endif

typedef float BMKFeatureDisplayPriority;
//常规annotationView级别高
static const BMKFeatureDisplayPriority BMKFeatureDisplayPriorityDefaultHigh = 750;
//常规annotationView级别中，其中罗盘模式下，罗盘中的图片使用本级别,精度圈使用本级别。
static const BMKFeatureDisplayPriority BMKFeatureDisplayPriorityDefaultMiddle = 500;
//常规annotationView级别低
static const BMKFeatureDisplayPriority BMKFeatureDisplayPriorityDefaultLow = 250;

@class BMKAnnotationViewInternal;
@protocol BMKAnnotation;
@class BMKMapView;
@class BMKMapViewInternal;
/**
 * 标注view
 * 注意：如果在BMKAnnotationView中添加手势，会覆盖原本的点击和长按事件，不推荐这样使用。
 * 如必须添加，请将手势的delegate设置到BMKAnnotationView中。
 */
@interface BMKAnnotationView : UIView
{
@private
    BMKAnnotationViewInternal *_internal;
    BOOL _enabled3D;
    CGPoint _originPt;
    CGPoint startPoint;
}

/**
 *初始化并返回一个annotation view
 *@param annotation 关联的annotation对象
 *@param reuseIdentifier 如果要重用view,传入一个字符串,否则设为nil,建议重用view
 *@return 初始化成功则返回annotation view,否则返回nil
 */
- (id)initWithAnnotation:(id <BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;

///复用标志
@property (nonatomic, readonly) NSString *reuseIdentifier;
///paopaoView
@property (nonatomic, strong) BMKActionPaopaoView* paopaoView;

/**
 *当view从reuse队列里取出时被调用
 *默认不做任何事
 */
- (void)prepareForReuse;

///关联的annotation
@property (nonatomic, strong) id <BMKAnnotation> annotation;

///annotation view显示的图像
@property (nonatomic, strong) UIImage *image;

///默认情况下, annotation view的中心位于annotation的坐标位置，可以设置centerOffset改变view的位置，正的偏移使view朝右下方移动，负的朝左上方，单位是像素
@property (nonatomic) CGPoint centerOffset;

///默认情况下, 弹出的气泡位于view正中上方，可以设置calloutOffset改变view的位置，正的偏移使view朝右下方移动，负的朝左上方，单位是像素
@property (nonatomic) CGPoint calloutOffset;

///默认情况下,标注没有3D效果，可以设置enabled3D改变使用3D效果，使得标注在地图旋转和俯视时跟随旋转、俯视
@property (nonatomic) BOOL enabled3D;

///默认为YES,当为NO时view忽略触摸事件
@property (nonatomic, getter=isEnabled) BOOL enabled;

///默认为NO,初始化时设置为YES时会默认弹出气泡。V5.2.0以后版本可以直接设置该值来控制隐藏和弹出气泡，无需调用强制刷新
@property (nonatomic, getter=isSelected) BOOL selected;

/**
 *设定view的选中状态
 *该方法被BMKMapView调用
 *@param selected 如果view需要显示为选中状态，该值为YES
 *@param animated 如果需要动画效果，该值为YES,暂不支持
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

///当为YES时，view被选中时会弹出气泡，annotation必须实现了title这个方法
@property (nonatomic) BOOL canShowCallout;

///显示在气泡左侧的view(使用默认气泡时，view的width最大值为32，height最大值为41，大于则使用最大值）
@property (strong, nonatomic) UIView *leftCalloutAccessoryView;

///显示在气泡右侧的view(使用默认气泡时，view的width最大值为32，height最大值为41，大于则使用最大值）
@property (strong, nonatomic) UIView *rightCalloutAccessoryView;

///当设为YES并实现了setCoordinate:方法时，支持将view在地图上拖动, iOS 3.2以后支持
@property (nonatomic, getter=isDraggable) BOOL draggable __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_2);

///当前view的拖动状态, iOS 3.2以后支持
@property (nonatomic) BMKAnnotationViewDragState dragState __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_2);

///当发生单击地图事件时，当前的annotation的泡泡是否隐藏，默认值为YES，V4.2.1以后支持
@property (nonatomic, assign) BOOL hidePaopaoWhenSingleTapOnMap;
///当发生双击地图事件时，当前的annotation的泡泡是否隐藏，默认值为NO，V4.2.1以后支持
@property (nonatomic, assign) BOOL hidePaopaoWhenDoubleTapOnMap;
///当发生两个手指点击地图（缩小地图）事件时，当前的annotation的泡泡是否隐藏，默认值为NO，V4.2.1以后支持
@property (nonatomic, assign) BOOL hidePaopaoWhenTwoFingersTapOnMap;
///当选中其他annotation时，当前annotation的泡泡是否隐藏，默认值为YES，V4.2.1以后支持
@property (nonatomic, assign) BOOL hidePaopaoWhenSelectOthers;
///当拖拽当前的annotation时，当前annotation的泡泡是否隐藏，默认值为NO，V4.2.1以后支持
@property (nonatomic, assign) BOOL hidePaopaoWhenDrag;
///当拖拽其他annotation时，当前annotation的泡泡是否隐藏，默认值为NO，V4.2.1以后支持
@property (nonatomic, assign) BOOL hidePaopaoWhenDragOthers;
///annotationView展示优先级，提供三种级别，其他级别开发者可自行设置，
///默认值为BMKFeatureDisplayPriorityDefaultMiddle，V4.2.1以后支持,
///级别数值越大越优先展示，同级别按照添加的先后顺序进行覆盖展示。
@property (nonatomic, assign) BMKFeatureDisplayPriority displayPriority;

@end
