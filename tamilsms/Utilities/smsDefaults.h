//
//  smsDefaults.h
//  tamilsms
//
//  Created by Mohan Kumar on 10/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define MAIN_URL @"http://tamilsms.info/"
#define MAIN_IMAGES_URL @"http://tamilsms.info/upload/"

typedef enum {
    noanimation,
    horizontalWithoutBounce,
    vertical,
    popOutVerticalOpen,
    horizontalWithBounce,
    pageCurlRightToTop,
    rotatedFreeFallFromTop,
    horizontalFlipFromRight
} TransitionType;

typedef void (^NOPARAMCALLBACK) ();
typedef void (^DICTIONARYCALLBACK) (NSDictionary*);
typedef void (^ARRAYCALLBACK) (NSArray*);
typedef void (^GENERICCALLBACK) (id);
typedef void (^STRINGCALLBACK) (NSString *);

@protocol smsCustNaviDelegates <NSObject>

@property (nonatomic) TransitionType transitionType;
@property (nonatomic,retain) NSDictionary * navigateParams;
@property (nonatomic, assign) BOOL hideStatusBar;


@optional

- (void) pushAnimation:(TransitionType) p_pushAnimationType;
- (void) popAnimation:(TransitionType) p_popAnimationType;
- (void) popAnimationCompleted;
- (void) pushanimationCompleted;
- (CGRect) getPopOutFrame;
- (UIImage*) getPopOutTopImage;
- (UIImage*) getPopOutBottomImage;
- (UIImage*) getPopOutImage;
- (void) initializeDataWithParams:(NSDictionary*) p_initParams;
- (void) navigationAnimationCompleted;

@end

@interface smsDefaults : NSObject

+ (UILabel*) getStandardLabelWithText:(NSString*) p_lblText;
+ (UITextField*) getStandardTextField;
+ (UIButton*) getStandardButton;
+ (UIButton*) getStandardButtonWithText:(NSString*) p_btnText;
+ (UIColor*) getDefaultTextColor;
+ (UIColor*) getColorRandomly:(int) p_colorNo withAlpha:(CGFloat) p_alpha;

@end

