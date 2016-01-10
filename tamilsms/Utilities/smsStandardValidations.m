//
//  smsStandardValidations.m
//  tamilsms
//
//  Created by Mohan Kumar on 22/11/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import "smsStandardValidations.h"

@implementation smsStandardValidations

+ (BOOL) isTextFieldIsempty:(UITextField*) p_txtField
{
    NSString * l_textValue = p_txtField.text;
    l_textValue = l_textValue?l_textValue:@"";
    l_textValue = [l_textValue stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([l_textValue isEqualToString:@""]==YES)
        return YES;
    return NO;
}

+ (BOOL) isTextValueIsValidEMail:(NSString*) p_eMailText
{
    NSString * l_emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate * l_emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", l_emailRegex];
    BOOL l_isvalidemail = [l_emailTest evaluateWithObject:p_eMailText];
    return l_isvalidemail;
}

@end
