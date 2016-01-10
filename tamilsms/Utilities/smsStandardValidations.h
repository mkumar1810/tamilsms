//
//  smsStandardValidations.h
//  tamilsms
//
//  Created by Mohan Kumar on 22/11/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface smsStandardValidations : NSObject

+ (BOOL) isTextFieldIsempty:(UITextField*) p_txtField;
+ (BOOL) isTextValueIsValidEMail:(NSString*) p_eMailText;

@end
