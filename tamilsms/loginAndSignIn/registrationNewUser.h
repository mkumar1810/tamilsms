//
//  registrationNewUser.h
//  tamilsms
//
//  Created by Mohan Kumar on 05/10/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol registerNewUserDelegates <NSObject>

- (void) newUserSignedUp;
- (void) newUserSignUpCancelled;

@end

@interface registrationNewUser : UIScrollView

@property (nonatomic,weak) id<registerNewUserDelegates> userDelegate;

@end
