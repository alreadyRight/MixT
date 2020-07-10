//
//  DLCustomPresentationController.m
//  整理
//
//  Created by 周冰烽 on 2020/7/9.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLCustomPresentationController.h"
#import "DLAnimationFading.h"
@interface DLCustomPresentationController () // <UIViewControllerAnimatedTransitioning>

@property(nonatomic, weak) UIView * dimmingView;

@property(nonatomic, strong) DLAnimationFading *animationFading;

@end

@implementation DLCustomPresentationController

#pragma mark -
#pragma mark - TouchUpEvent

- (void)dimmingClicked:(UITapGestureRecognizer *)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -
#pragma mark - Layout


- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize
{
    if (container == self.presentedViewController)
        return ((UIViewController*)container).preferredContentSize;
    else
        return [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
}

//在我们的自定义呈现中，被呈现的 view 并没有完全完全填充整个屏幕，
//被呈现的 view 的过渡动画之后的最终位置，是由 UIPresentationViewController 来负责定义的。
//我们重载 frameOfPresentedViewInContainerView 方法来定义这个最终位置
- (CGRect)frameOfPresentedViewInContainerView
{
    CGRect containerViewBounds = self.containerView.bounds;
    CGSize presentedViewContentSize = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
    
    // The presented view extends presentedViewContentSize.height points from
    // the bottom edge of the screen.
    CGRect presentedViewControllerFrame = containerViewBounds;
    presentedViewControllerFrame.size.height = presentedViewContentSize.height;
    presentedViewControllerFrame.origin.y = CGRectGetMaxY(containerViewBounds) - presentedViewContentSize.height;
    return presentedViewControllerFrame;
}

//  This method is similar to the -viewWillLayoutSubviews method in
//  UIViewController.  It allows the presentation controller to alter the
//  layout of any custom views it manages.
//
- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    self.dimmingView.frame = self.containerView.bounds;
}


//  This method is invoked whenever the presentedViewController's
//  preferredContentSize property changes.  It is also invoked just before the
//  presentation transition begins (prior to -presentationTransitionWillBegin).
//  建议就这样重写就行，这个应该是控制器内容大小变化时，就会调用这个方法， 比如适配横竖屏幕时，翻转屏幕时
//  可以使用UIContentContainer的方法来调整任何子视图控制器的大小或位置。
- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container
{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    
    if (container == self.presentedViewController)
        [self.containerView setNeedsLayout];
}



#pragma mark -
#pragma mark - Overried UIPresentationController methods

/// 构造方法,建议使用这个方法来初始化一个UIPresentationController
/// @param presentedViewController 将要跳转的目标控制器
/// @param presentingViewController 跳转前的原控制器
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController {
    self = [super initWithPresentedViewController:presentedViewController
                         presentingViewController:presentingViewController];
    if(self) {
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}


/// 跳转将要开始
- (void)presentationTransitionWillBegin {
    // 添加遮罩视图
    UIView *dimmingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
    dimmingView.backgroundColor = [UIColor blackColor];
    // 设置遮罩视图宽度和高度根据父视图(containerView)自动适配
    dimmingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    // 将此视图设置成透明的
    dimmingView.opaque = NO;
    [dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingClicked:)]];
    self.dimmingView = dimmingView;
    [self.containerView addSubview:dimmingView];
    
    id<UIViewControllerTransitionCoordinator> transitionCoordinate = self.presentingViewController.transitionCoordinator;
    self.dimmingView.alpha = 0.f;
    [transitionCoordinate animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.5f;
    } completion:NULL];
}

/// 跳转完成
- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        self.dimmingView = nil;
    }
}


/// dismiss将要开始
- (void)dismissalTransitionWillBegin {
    id<UIViewControllerTransitionCoordinator> transitionCoordinate = self.presentingViewController.transitionCoordinator;
    [transitionCoordinate animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.0f;
    } completion:NULL];
}

/// dismiss完成
- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        [self.dimmingView removeFromSuperview];
        self.dimmingView = nil;
    }
}

#pragma mark -
#pragma mark - UIViewControllerTransitionDelegate

/// 指定动画主管
/// @param presented 将要跳转的目标控制器
/// @param presenting 跳转前的原控制器
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(UIViewController *)presenting
                                                          sourceViewController:(UIViewController *)source {
    return self;
}

/// 指定弹出时显示的动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    // 返回一个遵守UIViewControllerAnimatedTransitioning的类,其内部实现动画的细节
    self.animation.presentingViewController = self.presentingViewController;
    return self.animation;
    
}

/// 指定消失(dismiss)时显示的动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    // 返回一个遵守UIViewControllerAnimatedTransitioning的类,其内部实现动画的细节
    self.animation.presentingViewController = self.presentingViewController;
    return self.animation;
}


//#pragma mark -
//#pragma mark - UIViewControllerAnimatedTransitioning
//
//- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
//    CGFloat time = 0;
//    if (self.animationStyle == DLPresentationAnimationStylePop) {
//        time = 0.55;
//    } else {
//        time = 0.35;
//    }
//    return [transitionContext isAnimated] ? time : 0;
//}

//- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
//
//    // 1.获取源控制器、目标控制器、动画容器View
//    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//
//    UIView *containerView = transitionContext.containerView;
//
//    // 2. 获取源控制器、目标控制器 的View，但是注意二者在开始动画，消失动画，身份是不一样的：
//    // 也可以直接通过上面获取控制器获取，比如：toViewController.view
//    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
//    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//    [containerView addSubview:toView];  //必须添加到动画容器View上。
//    // 判断是present 还是 dismiss
//    BOOL isPresenting = (fromViewController == self.presentingViewController);
//
//    CGFloat screenW = CGRectGetWidth(containerView.bounds);
//    CGFloat screenH = CGRectGetHeight(containerView.bounds);
//    NSArray *arr = nil;
//    switch (self.animationType) {
//        case DLPresentationAnimationTypeTopToBottomCenter:
//            arr = [self fromTopToBottomAnimationCenterWithScreenW:screenW screenH:screenH];
//            break;
//        case DLPresentationAnimationTypeBottomToTopCenter:
//            arr = [self fromBottomToTopAnimationCenterWithScreenW:screenW screenH:screenH];
//        default:
//            break;
//    }
//    CGRect beginFrame = CGRectZero;
//    CGRect showFrame = CGRectZero;
//    CGRect endFrame = CGRectZero;
//    if (arr.count == 3) {
//        beginFrame = CGRectFromString(arr[0]);
//        showFrame = CGRectFromString(arr[1]);
//        endFrame = CGRectFromString(arr[2]);
//    }
//
//    if (isPresenting) toView.frame = beginFrame;
//
//    NSTimeInterval duration = [self transitionDuration:transitionContext];
//    if (self.animationStyle == DLPresentationAnimationStyleTranslation) {
//        [UIView animateWithDuration:duration animations:^{
//            if (isPresenting) {
//                toView.frame = showFrame;
//            } else {
//                fromView.frame = endFrame;
//            }
//        } completion:^(BOOL finished) {
//            BOOL wasCancelled = [transitionContext transitionWasCancelled];
//            [transitionContext completeTransition:!wasCancelled];
//        }];
//    } else if (self.animationStyle == DLPresentationAnimationStylePop) {
//        // duration： 动画时长
//        // delay： 决定了动画在延迟多久之后执行
//        // damping：速度衰减比例。取值范围0 ~ 1，值越低震动越强
//        // velocity：初始化速度，值越高则物品的速度越快
//        // UIViewAnimationOptionCurveEaseInOut 加速，后减速
//        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:0.3f options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            if (isPresenting)
//                toView.frame = showFrame;
//            else
//                fromView.frame = endFrame;
//        } completion:^(BOOL finished) {
//            BOOL wasCancelled = [transitionContext transitionWasCancelled];
//            [transitionContext completeTransition:!wasCancelled];
//        }];
//    }
//}
//
//- (NSArray *)fromBottomToTopAnimationCenterWithScreenW:(CGFloat)screenW screenH:(CGFloat)screenH {
//    // 左右留35
//    // 上下留120
//    // 屏幕顶部：
//    CGFloat x = 35.f;
//    CGFloat y = -1 * screenH;
//    CGFloat w = screenW - x * 2;
//    CGFloat h = screenH - 120.f * 2;
//    // 屏幕顶部
//    CGRect beginFrame = CGRectMake(x, screenH + 10, w, h);  //加10是因为动画果冻效果，会露出屏幕一点
//    // 屏幕中间：
//    CGRect showFrame = CGRectMake(x, 120.0, w, h);
//    // 屏幕底部
//    CGRect endFrame = CGRectMake(x, y, w, h);
//
//    NSArray *arr = @[NSStringFromCGRect(beginFrame), NSStringFromCGRect(showFrame), NSStringFromCGRect(endFrame)];
//
//    return arr;
//}
//
//
//- (NSArray *)fromTopToBottomAnimationCenterWithScreenW:(CGFloat)screenW screenH:(CGFloat)screenH {
//    // 左右留35
//    // 上下留120
//    // 屏幕顶部：
//    CGFloat x = 35.f;
//    CGFloat y = -1 * screenH;
//    CGFloat w = screenW - x * 2;
//    CGFloat h = screenH - 120.f * 2;
//    // 屏幕顶部
//    CGRect beginFrame = CGRectMake(x, y, w, h);
//    // 屏幕中间：
//    CGRect showFrame = CGRectMake(x, 120.0, w, h);
//    // 屏幕底部
//    CGRect endFrame = CGRectMake(x, screenH + 10, w, h);  //加10是因为动画果冻效果，会露出屏幕一点
//
//    NSArray *arr = @[NSStringFromCGRect(beginFrame), NSStringFromCGRect(showFrame), NSStringFromCGRect(endFrame)];
//
//    return arr;
//
//}


@end
