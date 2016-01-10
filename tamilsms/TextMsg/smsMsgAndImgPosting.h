//
//  smsMsgAndImgPosting.h
//  tamilsms
//
//  Created by arun benjamin on 23/11/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface smsMsgAndImgPosting : UIScrollView<UITextFieldDelegate,UITextViewDelegate>
{
    UITextField * txt_smsText,*txt_catgry;
    UIButton * but_Catname,* but_help,*but_submit;
    CAShapeLayer * _Underline;
    UIView * _activeTxtFldOrVw;
}
@end
