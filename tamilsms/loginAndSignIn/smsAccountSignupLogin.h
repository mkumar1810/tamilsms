//
//  smsAccountSignupLogin.h
//  tamilsms
//
//  Created by Mohan Kumar on 01/10/15.
//  Copyright © 2015 arun benjamin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol smsAccountSignUpDelegates <NSObject>

- (void) invokeSignUpScreen;

@end

@interface smsAccountSignupLogin : UIScrollView

@property (nonatomic, weak) id<smsAccountSignUpDelegates> signUpLoginDelegate;

@end
