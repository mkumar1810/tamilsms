//
//  smsMainScrollView.h
//  tamilsms
//
//  Created by Mohan Kumar on 21/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "smsCategoryListTv.h"
#import "smsAccountSignupLogin.h"



@interface smsMainScrollView : UIScrollView

@property (nonatomic,weak) id<smsCategoriesListDelegate> txtMsgCategoriesDelegate;
@property (nonatomic,weak) id<smsCategoriesListDelegate> imgMsgCategoriesDelegate;
@property (nonatomic,weak) id<smsAccountSignUpDelegates> signUpLoginDelegate;

- (void)reloadTextCategoriesList;
- (void) reloadImageCategoriesList;

@end
