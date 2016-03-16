//
//  smsInfoSettingsScreen.h
//  tamilsms
//
//  Created by Mohan Kumar on 30/09/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol smsInfoSettingsDelegate <NSObject>

- (void) showAppFeedBackScreen;
- (void) showAppSettingsScreen;

@end

@interface smsInfoSettingsScreen : UIScrollView

@property (nonatomic,strong) id<smsInfoSettingsDelegate> infoSetDelegate;

@end
