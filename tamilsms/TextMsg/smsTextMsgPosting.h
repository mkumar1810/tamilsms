//
//  smsTextMsgPosting.h
//  tamilsms
//
//  Created by Mohan Kumar on 10/01/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol smsTextMsgPostDelegate <NSObject>

- (void) textMsgPostedSuccessfully;

@end

@interface smsTextMsgPosting : UIScrollView<UITextFieldDelegate,UITextViewDelegate>
{
    UITextView * txtvw_sms;
    UITextField *txt_catgry;
    UIButton * but_Catname,* but_help,*but_submit;
    CAShapeLayer * _Underline;
    UIView * _activeTxtFldOrVw;
}

@property (nonatomic,weak) id<smsTextMsgPostDelegate> txtMsgDelegate;

@end
