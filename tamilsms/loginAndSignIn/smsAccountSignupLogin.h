//
//  smsAccountSignupLogin.h
//  tamilsms
//
//  Created by Mohan Kumar on 01/10/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginWelcomeScreeen.h"

@protocol smsAccountSignUpDelegates <NSObject,loginWelComeScreenDelegates>

- (void) invokeSignUpScreen;

@end

@interface smsAccountSignupLogin : UIScrollView

@property (nonatomic, strong) IBOutlet id<smsAccountSignUpDelegates> signUpLoginDelegate;

@end
