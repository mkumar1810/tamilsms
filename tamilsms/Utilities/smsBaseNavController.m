//
//  smsBaseNavController.m
//  tamilsms
//
//  Created by Mohan Kumar on 10/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import "smsBaseNavController.h"
#import "smsLocalStore.h"

@interface smsBaseNavController ()

@end

@implementation smsBaseNavController

- (void)awakeFromNib
{
    self.delegate = self;
    [UINavigationBar appearance].translucent = YES;
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    //[self.navBar setBarTintColor:[UIColor colorWithWhite:0.84 alpha:0.90]];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.42 green:0.56 blue:0.78 alpha:0.90]];
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [UINavigationBar appearance].layer.masksToBounds = NO;
    [UINavigationBar appearance].layer.shadowOffset = CGSizeMake(0, -5);
    [UINavigationBar appearance].layer.shadowRadius = 6;
    [UINavigationBar appearance].layer.shadowOpacity = 0.4;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self setNavigationBarHidden:YES];
    // [self setNeedsStatusBarAppearanceUpdate];
    [self.view setBackgroundColor:[UIColor clearColor]];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma navigation controller delegates

- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight ;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return [[smsNavControllerTransitionAnimator alloc] initWithNavOperation:operation];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //_showingctrlr = (id<trcCustNaviDelegates>) viewController;
    //self.showingBaseController = (ibdcBaseController*) viewController;
//    _showingCtrlDelegates = (id<fmaCustNaviDelegates>) viewController;
}

@end


@interface smsNavControllerTransitionAnimator()
{
    UINavigationControllerOperation _navOperation;
}

@end

@implementation smsNavControllerTransitionAnimator

- (instancetype) initWithNavOperation:(UINavigationControllerOperation) p_navOperation
{
    self = [super init];
    if (self)
    {
        _navOperation = p_navOperation;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.7;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    id<smsCustNaviDelegates>  l_toViewController = (id<smsCustNaviDelegates>) [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect l_finalFrame = [transitionContext finalFrameForViewController:[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey]];
    id<smsCustNaviDelegates> l_fromViewController = (id<smsCustNaviDelegates>) [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    TransitionType l_currTransitionType;
    if (_navOperation==UINavigationControllerOperationPush)
        l_currTransitionType = l_toViewController.transitionType;
    else
        l_currTransitionType = l_fromViewController.transitionType;
    NOPARAMCALLBACK l_pushCB = ^(){
        if ([l_fromViewController respondsToSelector:@selector(pushAnimation:)])
        {
            [l_fromViewController pushAnimation:l_currTransitionType];
        }
    };
    
    NOPARAMCALLBACK l_popCB = ^(){
        if ([l_toViewController respondsToSelector:@selector(popAnimation:)])
        {
            [l_toViewController popAnimation:l_currTransitionType];
        }
    };
    
    NOPARAMCALLBACK l_completionCB = ^(){
        if (_navOperation==UINavigationControllerOperationPop)
        {
            if ([l_toViewController respondsToSelector:@selector(popAnimationCompleted)])
            {
                [l_toViewController popAnimationCompleted];
            }
//            [l_toViewController popAnimationCompleted];
        }
        
        if (_navOperation==UINavigationControllerOperationPush)
        {
            if ([l_fromViewController respondsToSelector:@selector(pushanimationCompleted)])
            {
                [l_fromViewController pushanimationCompleted];
            }
        }
        
        [transitionContext completeTransition:YES];
        
        if ([l_toViewController respondsToSelector:@selector(navigationAnimationCompleted:)])
        {
            [l_toViewController navigationAnimationCompleted:_navOperation];
        }
        if ([l_fromViewController respondsToSelector:@selector(navigationAnimationCompleted:)])
        {
            [l_fromViewController navigationAnimationCompleted:_navOperation];
        }
    };
    
    if (l_currTransitionType==noanimation)
    {
        if (_navOperation==UINavigationControllerOperationPush)
        {
            l_pushCB();
        }
        else
        {
            l_popCB();
        }
        [[transitionContext containerView] addSubview:[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view];
        l_completionCB();
        return;
    }
    else if (l_currTransitionType==horizontalWithoutBounce)
    {
        if (_navOperation==UINavigationControllerOperationPush)
            [self
             makeHorizontalNoBouncePushFrom:[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view
             to:[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view
             onContainer:[transitionContext containerView]
             duration:0.4
             finalFrame:l_finalFrame
             withCompletionCB:l_completionCB
             andPushCB:l_pushCB];
        else
            [self
             makeHorizontalNoBouncePopFrom:[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view
             to:[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view
             onContainer:[transitionContext containerView]
             duration:0.4
             finalFrame:l_finalFrame
             withCompletionCB:l_completionCB
             andPopCB:l_popCB];
    }
    else if (l_currTransitionType==popOutVerticalOpen)
    {
        if (_navOperation==UINavigationControllerOperationPush)
            [self
             makePopOutVerticalPushFrom:[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view
             to:[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view
             onContainer:[transitionContext containerView]
             duration:0.4
             finalFrame:l_finalFrame
             popOutFrame:[l_fromViewController getPopOutFrame]
             popOutImage:[l_fromViewController getPopOutImage]
             withCompletionCB:l_completionCB
             andPushCB:l_pushCB];
        else
            [self
             makePopOutVerticalPopFrom:[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view
             to:[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view
             onContainer:[transitionContext containerView]
             duration:0.4
             finalFrame:l_finalFrame
             popOutFrame:[l_toViewController getPopOutFrame]
             popOutImage:[l_toViewController getPopOutImage]
             withCompletionCB:l_completionCB
             andPopCB:l_popCB];
    }
    else if (l_currTransitionType==horizontalWithBounce)
    {
        if (_navOperation==UINavigationControllerOperationPush)
            [self
             makeHorizontalBouncePushFrom:[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view
             to:[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view
             onContainer:[transitionContext containerView]
             duration:0.7
             finalFrame:l_finalFrame
             withCompletionCB:l_completionCB
             andPushCB:l_pushCB];
        else
            [self
             makeHorizontalBouncePopFrom:[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view
             to:[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view
             onContainer:[transitionContext containerView]
             duration:0.7
             finalFrame:l_finalFrame
             withCompletionCB:l_completionCB
             andPopCB:l_popCB];
    }
    else if (l_currTransitionType == vertical )
    {
        if ( _navOperation == UINavigationControllerOperationPush )
            [self
             makeVerticalPushFrom:[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view
             to:[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view
             onContainer:[transitionContext containerView]
             duration:[self transitionDuration:transitionContext]
             finalFrame:l_finalFrame
             withCB:l_completionCB
             andPushCB:l_pushCB];
        else
            [self
             makeVerticalPopFrom:[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view
             to:[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view
             onContainer:[transitionContext containerView]
             duration:[self transitionDuration:transitionContext]
             finalFrame:l_finalFrame withCB:l_completionCB
             andPopCB:l_popCB];
    }
    else if (l_currTransitionType == rotatedFreeFallFromTop)
    {
        if ( _navOperation == UINavigationControllerOperationPush)
            [self
             makeRotatedFreefallPushFrom:[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view
             to:[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view
             onContainer:[transitionContext containerView]
             duration:[self transitionDuration:transitionContext]
             withCompletionCB:l_completionCB
             andPushCB:l_pushCB];
        else
            [self
             makeRotatedFreefallPopFrom:[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view
             to:[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view
             onContainer:[transitionContext containerView]
             duration:[self transitionDuration:transitionContext]
             withCompletionCB:l_completionCB
             andPopCB:l_popCB];
    }
    else if (l_currTransitionType==pageCurlRightToTop)
    {
        if ( _navOperation == UINavigationControllerOperationPush)
            [self
             makePageCurlRightPushFrom:[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view
             to:[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view
             onContainer:[transitionContext containerView]
             duration:[self transitionDuration:transitionContext]
             withCompletionCB:l_completionCB
             andPushCB:l_pushCB];
        else
            [self
             makePageCurlRightPopFrom:[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view
             to:[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view
             onContainer:[transitionContext containerView]
             duration:[self transitionDuration:transitionContext]
             withCompletionCB:l_completionCB
             andPopCB:l_popCB];
    }
    else if (l_currTransitionType==horizontalFlipFromRight)
    {
        if ( _navOperation == UINavigationControllerOperationPush)
            [self
             makeHorizontalRightFlipPushFrom:[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view
             to:[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view
             onContainer:[transitionContext containerView]
             duration:[self transitionDuration:transitionContext]
             withCB:l_completionCB
             andPushCB:l_pushCB];
        else
            [self
             makeHorizontalRightFlipPopFrom:[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view
             to:[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view
             onContainer:[transitionContext containerView]
             duration:[self transitionDuration:transitionContext]
             withCB:l_completionCB
             andPopCB:l_popCB];
    }
    else if (l_currTransitionType==rotatedStartFromCenter)
    {
        if ( _navOperation == UINavigationControllerOperationPush)
            [self makePushRotatedStartFromCenter:[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view to:[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view onContainer:[transitionContext containerView] duration:[self transitionDuration:transitionContext] withCompletionCB:l_completionCB andPushCB:l_pushCB];
        else
            [self
             makeHorizontalRightFlipPopFrom:[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view
             to:[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view
             onContainer:[transitionContext containerView]
             duration:[self transitionDuration:transitionContext]
             withCB:l_completionCB
             andPopCB:l_popCB];
    }
}

- (UIImage*) captureView:(UIView*) p_passview
{
    CGRect l_rect = p_passview.bounds;
    UIGraphicsBeginImageContext(l_rect.size);
    CGContextRef l_ctxref = UIGraphicsGetCurrentContext();
    [p_passview.layer renderInContext:l_ctxref];
    UIImage * l_reqdimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return l_reqdimage;
}

#pragma generic navigation delegate methods

- (void)makeRotatedFreefallPushFrom:(UIView *)p_fromView to:(UIView *)p_toView onContainer:(UIView *)p_containerView duration:(NSTimeInterval)p_duration withCompletionCB:(NOPARAMCALLBACK) p_completionCB andPushCB:(NOPARAMCALLBACK) p_pushCB
{
    
    CGAffineTransform rotation = CGAffineTransformMakeRotation(-1 * M_PI_2);
    CGRect fromRect = p_fromView.frame;
    CGAffineTransform translation = CGAffineTransformMakeTranslation(-1 * CGRectGetMidX(fromRect), -1 * CGRectGetMidY(fromRect));
    CGAffineTransform inverseTrans = CGAffineTransformInvert(translation);
    
    CGAffineTransform transform = CGAffineTransformConcat(CGAffineTransformConcat(inverseTrans, rotation), translation);
    
    p_toView.transform = transform;
    p_toView.alpha = 1;
    [p_containerView addSubview:p_toView];
    
    [UIView animateWithDuration:p_duration
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         p_toView.alpha = 1;
                         p_toView.transform = CGAffineTransformIdentity;
                         p_pushCB();
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [p_fromView removeFromSuperview];
                             p_completionCB(finished);
                         }
                     }];
    
}

- (void) makeRotatedFreefallPopFrom:(UIView*) p_fromView to:(UIView*) p_toView onContainer:(UIView*) p_containerView duration:(NSTimeInterval) p_duration withCompletionCB:(NOPARAMCALLBACK) p_completionCB andPopCB:(NOPARAMCALLBACK) p_popCB
{
    
    CGAffineTransform rotation = CGAffineTransformMakeRotation(-1 * M_PI_2);
    CGRect fromRect = p_fromView.frame;
    CGAffineTransform translation = CGAffineTransformMakeTranslation(-1 * CGRectGetMidX(fromRect), -1 * CGRectGetMidY(fromRect));
    CGAffineTransform inverseTrans = CGAffineTransformInvert(translation);
    
    CGAffineTransform transform = CGAffineTransformConcat(CGAffineTransformConcat(inverseTrans, rotation), translation);
    
    [p_containerView insertSubview:p_toView belowSubview:p_fromView];
    [UIView animateWithDuration:p_duration
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         //p_fromView.alpha = 0;
                         p_fromView.transform = transform;
                         p_popCB();
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [p_fromView removeFromSuperview];
                             p_completionCB(finished);
                         }
                     }];
}

- (void) makePageCurlRightPushFrom:(UIView*) p_fromView to:(UIView*) p_toView onContainer:(UIView*) p_containerView duration:(NSTimeInterval) p_duration withCompletionCB:(NOPARAMCALLBACK) p_completionCB andPushCB:(NOPARAMCALLBACK) p_pushCB
{
    [p_containerView insertSubview:p_toView belowSubview:p_fromView];
    [UIView transitionWithView:p_fromView
                      duration:p_duration
                       options: UIViewAnimationCurveEaseOut | UIViewAnimationOptionTransitionCurlUp
                    animations:^{
                        //p_fromView.frame = CGRectMake(-p_fromView.frame.size.width ,-p_fromView.frame.size.height , p_fromView.frame.size.width, p_fromView.frame.size.height);
                        p_fromView.transform = CGAffineTransformMakeTranslation(0 , -p_fromView.frame.size.height);
                        p_fromView.alpha = 0;
                        p_pushCB();
                    }
                    completion:^(BOOL finished){
                        [p_fromView removeFromSuperview];
                        p_completionCB(finished);
                    }
     ];
}

- (void) makePageCurlRightPopFrom:(UIView*) p_fromView to:(UIView*) p_toView onContainer:(UIView*) p_containerView duration:(NSTimeInterval) p_duration withCompletionCB:(NOPARAMCALLBACK) p_completionCB andPopCB:(NOPARAMCALLBACK) p_popCB
{
    [p_containerView addSubview:p_toView];
    [p_toView setFrame:CGRectMake(0, -p_fromView.frame.size.height, p_fromView.frame.size.width, p_fromView.frame.size.height)];
    p_toView.alpha = 1;
    [UIView transitionWithView:p_toView
                      duration:p_duration
                       options: UIViewAnimationCurveEaseIn | UIViewAnimationOptionTransitionCurlDown
                    animations:^{
                        [p_toView setFrame:p_fromView.frame];
                        p_popCB();
                    }
                    completion:^(BOOL finished){
                        [p_fromView removeFromSuperview];
                        p_completionCB(finished);
                    }
     ];
}


- (void) makeHorizontalNoBouncePushFrom:(UIView*) p_fromView to:(UIView*) p_toView onContainer:(UIView*) p_containerView duration:(NSTimeInterval) p_duration finalFrame:(CGRect) p_finalFrame withCompletionCB:(NOPARAMCALLBACK) p_completionCB andPushCB:(NOPARAMCALLBACK) p_pushCB
{
    CGRect l_finalFromFrame = CGRectMake(-p_finalFrame.size.width, 0, p_finalFrame.size.width, p_finalFrame.size.height);
    p_toView.frame = CGRectOffset(p_finalFrame, p_finalFrame.size.width, 0);
    [p_containerView addSubview:p_toView];
    [UIView animateWithDuration:p_duration
                     animations:^(){
                         p_fromView.frame = l_finalFromFrame;
                         p_toView.frame = p_finalFrame;
                         p_pushCB();
                     }
                     completion:^(BOOL p_finished){
                         p_completionCB();
                     }];
}

- (void) makeHorizontalNoBouncePopFrom:(UIView*) p_fromView to:(UIView*) p_toView onContainer:(UIView*) p_containerView duration:(NSTimeInterval) p_duration finalFrame:(CGRect) p_finalFrame withCompletionCB:(NOPARAMCALLBACK) p_completionCB andPopCB:(NOPARAMCALLBACK) p_popCB
{
    CGRect l_finalFromFrame = CGRectMake(p_finalFrame.size.width, 0, p_finalFrame.size.width, p_finalFrame.size.height);
    p_toView.frame = CGRectOffset(l_finalFromFrame, -p_finalFrame.size.width, 0);
    [p_containerView addSubview:p_toView];
    [p_containerView sendSubviewToBack:p_toView];
    [UIView animateWithDuration:p_duration
                     animations:^(){
                         [p_fromView setFrame:l_finalFromFrame];
                         [p_toView setFrame:p_finalFrame];
                         p_popCB();
                     }
                     completion:^(BOOL p_finished){
                         p_completionCB();
                     }];
}

- (void) makePopOutVerticalPushFrom:(UIView*) p_fromView to:(UIView*) p_toView onContainer:(UIView*) p_containerView duration:(NSTimeInterval) p_duration finalFrame:(CGRect) p_finalFrame popOutFrame:(CGRect) p_popOutFrame popOutImage:(UIImage*) p_popOutImage withCompletionCB:(NOPARAMCALLBACK) p_completionCB andPushCB:(NOPARAMCALLBACK) p_pushCB
{
    UIImageView * l_cellimgvw = [[UIImageView alloc] initWithImage:p_popOutImage];
    [l_cellimgvw setFrame:p_popOutFrame];
    CGFloat l_shrink_x = p_popOutFrame.size.width / p_finalFrame.size.width;
    CGFloat l_shrink_y = p_popOutFrame.size.height / p_finalFrame.size.height;
    CGFloat l_expand_x = p_finalFrame.size.width / p_popOutFrame.size.width;
    CGFloat l_expand_y = p_finalFrame.size.height / p_popOutFrame.size.height;
    [p_containerView addSubview:p_toView];
    p_toView.alpha = 0;
    [p_containerView addSubview:l_cellimgvw];
    [p_containerView bringSubviewToFront:p_toView];
    p_toView.transform = CGAffineTransformMakeScale(l_shrink_x, l_shrink_y);
    p_toView.center = CGPointMake(p_popOutFrame.origin.x + p_popOutFrame.size.width/2.0, p_popOutFrame.origin.y+p_popOutFrame.size.height/2.0);
    CGPoint l_finalcenter = CGPointMake(p_finalFrame.origin.x + p_finalFrame.size.width/2.0, p_finalFrame.origin.y+p_finalFrame.size.height/2.0);
    [UIView animateWithDuration:p_duration
                     animations:^(){
                         l_cellimgvw.alpha = 0;
                         p_toView.alpha = 1;
                         p_toView.transform = CGAffineTransformIdentity;
                         l_cellimgvw.transform = CGAffineTransformMakeScale(l_expand_x, l_expand_y);
                         p_toView.center = l_finalcenter;
                         l_cellimgvw.center = l_finalcenter;
                         p_pushCB();
                     }
                     completion:^(BOOL p_finished){
                         [l_cellimgvw removeFromSuperview];
                         p_completionCB();
                     }];
}

- (void) makePopOutVerticalPopFrom:(UIView*) p_fromView to:(UIView*) p_toView onContainer:(UIView*) p_containerView duration:(NSTimeInterval) p_duration finalFrame:(CGRect) p_finalFrame popOutFrame:(CGRect) p_popOutFrame popOutImage:(UIImage*) p_popOutImage withCompletionCB:(NOPARAMCALLBACK) p_completionCB andPopCB:(NOPARAMCALLBACK) p_popCB
{
    [p_containerView addSubview:p_toView];
    [p_toView setFrame:p_finalFrame];
    UIImageView * l_cellimgvw = [[UIImageView alloc] initWithImage:p_popOutImage];
    [l_cellimgvw setFrame:p_finalFrame];
    l_cellimgvw.alpha = 0;
    CGFloat l_shrink_x = p_popOutFrame.size.width / p_finalFrame.size.width;
    CGFloat l_shrink_y = p_popOutFrame.size.height / p_finalFrame.size.height;
    [p_containerView addSubview:p_fromView];
    p_fromView.alpha = 1;
    [p_containerView addSubview:l_cellimgvw];
    [p_containerView bringSubviewToFront:p_fromView];
    CGPoint l_finalcenter = CGPointMake(p_popOutFrame.origin.x + p_popOutFrame.size.width/2.0, p_popOutFrame.origin.y+p_popOutFrame.size.height/2.0);
    [UIView animateWithDuration:p_duration
                     animations:^(){
                         l_cellimgvw.alpha = 1;
                         p_fromView.alpha = 0;
                         p_fromView.transform = CGAffineTransformMakeScale(l_shrink_x, l_shrink_y);
                         l_cellimgvw.transform = CGAffineTransformMakeScale(l_shrink_x, l_shrink_y);
                         p_fromView.center = l_finalcenter;
                         l_cellimgvw.center = l_finalcenter;
                         p_popCB();
                     }
                     completion:^(BOOL p_finished){
                         [l_cellimgvw removeFromSuperview];
                         p_completionCB();
                     }];
    
}

- (void) makeHorizontalBouncePushFrom:(UIView*) p_fromView to:(UIView*) p_toView onContainer:(UIView*) p_containerView duration:(NSTimeInterval) p_duration finalFrame:(CGRect) p_finalFrame withCompletionCB:(NOPARAMCALLBACK) p_completionCB andPushCB:(NOPARAMCALLBACK) p_pushCB
{
    CGRect l_finalFromFrame = CGRectMake(-p_finalFrame.size.width, 0, p_finalFrame.size.width, p_finalFrame.size.height);
    p_toView.frame = CGRectOffset(p_finalFrame, p_finalFrame.size.width, 0);
    [p_containerView addSubview:p_toView];
    //return;
    [UIView animateWithDuration:p_duration
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.1
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(){
                         p_fromView.frame = l_finalFromFrame;
                         p_toView.frame = p_finalFrame;
                         p_pushCB();
                     }
                     completion:^(BOOL p_finished){
                         p_completionCB();
                     }];
}

- (void) makeHorizontalBouncePopFrom:(UIView*) p_fromView to:(UIView*) p_toView onContainer:(UIView*) p_containerView duration:(NSTimeInterval) p_duration finalFrame:(CGRect) p_finalFrame withCompletionCB:(NOPARAMCALLBACK) p_completionCB andPopCB:(NOPARAMCALLBACK) p_popCB
{
    CGRect l_finalFromFrame = CGRectMake(p_finalFrame.size.width, 0, p_finalFrame.size.width, p_finalFrame.size.height);
    p_toView.frame = CGRectOffset(p_finalFrame, -p_finalFrame.size.width, 0);
    [p_containerView addSubview:p_toView];
    [p_containerView sendSubviewToBack:p_toView];
    [UIView animateWithDuration:p_duration
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.1
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(){
                         [p_fromView setFrame:l_finalFromFrame];
                         [p_toView setFrame:p_finalFrame];
                         p_popCB();
                     }
                     completion:^(BOOL p_finished){
                         p_completionCB();
                     }];
}

- (void) makeVerticalPushFrom:(UIView*) p_fromView to:(UIView*) p_toView onContainer:(UIView*) p_containerView duration:(NSTimeInterval) p_duration finalFrame:(CGRect) p_finalFrame withCB:(NOPARAMCALLBACK) p_completionCB andPushCB:(NOPARAMCALLBACK) p_pushCB
{
    CGRect finalFromFrame = CGRectOffset(p_fromView.frame, 0, -p_finalFrame.size.height);
    p_toView.frame = CGRectOffset(p_finalFrame, 0, [[UIScreen mainScreen] bounds].size.height);
    [p_containerView addSubview:p_toView];
    
    [UIView animateWithDuration:p_duration
                          delay:0
         usingSpringWithDamping:.75
          initialSpringVelocity:.1
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         p_fromView.frame = finalFromFrame;
                         p_toView.frame = p_finalFrame;
                         p_pushCB();
                     } completion:^(BOOL finished) {
                         p_completionCB();
                     }];
}

- (void) makeVerticalPopFrom:(UIView*) p_fromView to:(UIView*) p_toView onContainer:(UIView*) p_containerView duration:(NSTimeInterval) p_duration finalFrame:(CGRect) p_finalFrame withCB:(NOPARAMCALLBACK) p_completionCB andPopCB:(NOPARAMCALLBACK) p_popCB
{
    CGRect finalFromFrame = CGRectOffset(p_fromView.frame, 0, p_finalFrame.size.height);
    p_toView.frame = CGRectOffset(p_finalFrame, 0, -[[UIScreen mainScreen] bounds].size.height);
    [p_containerView addSubview:p_toView];
    
    [UIView animateWithDuration:p_duration
                          delay:0
         usingSpringWithDamping:.75
          initialSpringVelocity:.1
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         p_fromView.frame = finalFromFrame;
                         p_toView.frame = p_finalFrame;
                         p_popCB();
                     } completion:^(BOOL finished) {
                         p_completionCB();
                     }];
}


- (void) makeHorizontalRightFlipPushFrom:(UIView*) p_fromView to:(UIView*) p_toView onContainer:(UIView*) p_containerView duration:(NSTimeInterval) p_duration withCB:(NOPARAMCALLBACK) p_completionCB andPushCB:(NOPARAMCALLBACK) p_pushCB
{
    
    [p_containerView insertSubview:p_toView belowSubview:p_fromView];
    [UIView animateWithDuration:p_duration animations:^(){
        p_pushCB();
    }];
    [UIView transitionFromView:p_fromView
                        toView:p_toView
                      duration:p_duration
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    completion:^(BOOL p_finished)
     {
         if (p_finished)
         {
             [p_fromView removeFromSuperview];
             p_completionCB(p_finished);
         }
     }];
    
}

- (void) makeHorizontalRightFlipPopFrom:(UIView*) p_fromView to:(UIView*) p_toView onContainer:(UIView*) p_containerView duration:(NSTimeInterval) p_duration withCB:(NOPARAMCALLBACK) p_completionCB andPopCB:(NOPARAMCALLBACK) p_popCB
{
    [p_containerView insertSubview:p_toView belowSubview:p_fromView];
    [UIView animateWithDuration:p_duration animations:^(){
        p_popCB();
    }];
    [UIView transitionFromView:p_fromView
                        toView:p_toView
                      duration:p_duration
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:^(BOOL p_finished)
     {
         if (p_finished)
         {
             [p_fromView removeFromSuperview];
             p_completionCB(p_finished);
         }
     }];
}

- (void)makePushRotatedStartFromCenter:(UIView *)p_fromView to:(UIView *)p_toView onContainer:(UIView *)p_containerView duration:(NSTimeInterval)p_duration withCompletionCB:(NOPARAMCALLBACK) p_completionCB andPushCB:(NOPARAMCALLBACK) p_pushCB
{
    CGFloat l_shrink_x = 0.25;
    CGFloat l_shrink_y = 0.25;
    CGAffineTransform transform = CGAffineTransformConcat(CGAffineTransformMakeScale(l_shrink_x, l_shrink_y), CGAffineTransformMakeRotation(M_PI-0.1));
    p_toView.transform = transform;
    p_toView.alpha = 0.5;
    [p_containerView addSubview:p_toView];
    
    [UIView animateWithDuration:p_duration
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         p_toView.alpha = 1;
                         p_toView.transform = CGAffineTransformIdentity;
                         p_pushCB();
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [p_fromView removeFromSuperview];
                             p_completionCB(finished);
                         }
                     }];
}

- (void) makePopRotatedStartFromCenter:(UIView*) p_fromView to:(UIView*) p_toView onContainer:(UIView*) p_containerView duration:(NSTimeInterval) p_duration withCompletionCB:(NOPARAMCALLBACK) p_completionCB andPopCB:(NOPARAMCALLBACK) p_popCB
{
    
    CGFloat l_shrink_x = 0.25;
    CGFloat l_shrink_y = 0.25;
    CGAffineTransform transform = CGAffineTransformConcat(CGAffineTransformMakeScale(l_shrink_x, l_shrink_y), CGAffineTransformMakeRotation(M_PI-0.1));
    //p_toView.transform = transform;
    [p_containerView insertSubview:p_toView aboveSubview:p_fromView];
    
    [UIView animateWithDuration:p_duration
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         p_fromView.transform = transform;
                         p_popCB();
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [p_fromView removeFromSuperview];
                             p_completionCB(finished);
                         }
                     }];
    
}


@end
