//
//  loginWelcomeScreeen.h
//  tamilsms
//
//  Created by arun benjamin on 14/11/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol loginWelComeScreenDelegates <NSObject>

- (void) postNewTextSMSMessage;
- (void) postNewImageSMSMessage;

@end


@interface loginWelcomeScreeen :UIScrollView

@property (nonatomic,weak) id<loginWelComeScreenDelegates> screenDelegate;

@end
