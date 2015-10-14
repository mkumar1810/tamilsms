//
//  smsBaseNavController.h
//  tamilsms
//
//  Created by Mohan Kumar on 10/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "smsDefaults.h"

@interface smsBaseNavController : UINavigationController<UINavigationControllerDelegate>

@end

@interface smsNavControllerTransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning>
- (instancetype) initWithNavOperation:(UINavigationControllerOperation) p_navOperation;

@end

