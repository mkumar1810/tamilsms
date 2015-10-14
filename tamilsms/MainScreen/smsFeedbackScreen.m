//
//  smsFeedbackScreen.m
//  tamilsms
//
//  Created by arun benjamin on 29/09/15.
//  Copyright © 2015 arun benjamin. All rights reserved.
//

#import "smsFeedbackScreen.h"

@interface smsFeedbackScreen()<UITextViewDelegate,UITextFieldDelegate>
{
    UILabel * lbl_email, *lbl_name, *lbl_suggestion;
    UITextView  *txt_suggestion;
    UITextField * txt_email, *txt_name;
    UIButton * but_submit;
    CGSize _keyBoardSize;
    UIView * _activeTxtFldOrVw;
    CAShapeLayer * _Underline;
}

-(void)Submit:(UIButton*) p_but;
@end

@implementation smsFeedbackScreen

- (instancetype)init
{
    self = [super init];
    if (self) {
        //
        [self setScrollEnabled:NO];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    /*CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    CGContextMoveToPoint(context, 10, 80);
    CGContextAddLineToPoint(context, rect.size.width-10, 80);
    
    CGContextMoveToPoint(context, 10, 160);
    CGContextAddLineToPoint(context, rect.size.width-10, 160);
    
    CGContextMoveToPoint(context, 10, 320);
    CGContextAddLineToPoint(context, rect.size.width-10, 320);
    
    CGContextStrokePath(context);*/
    
    
    lbl_name = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, rect.size.width/4.0, 30)];
    //[lbl_name setBackgroundColor:[UIColor greenColor]];
    [lbl_name setFont:[UIFont boldSystemFontOfSize:15]];
    [lbl_name setText:@"Name(*)"];
    [self addSubview:lbl_name];
    
    txt_name = [[UITextField alloc]initWithFrame:CGRectMake(10, 50, rect.size.width-20, 30-1)];
    //[txt_name setBackgroundColor:[UIColor redColor]];
    txt_name.delegate = self;
    [self addSubview:txt_name];
    
    lbl_email = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, rect.size.width/4.0, 30)];
    //[lbl_email setBackgroundColor:[UIColor greenColor]];
    [lbl_email setFont:[UIFont boldSystemFontOfSize:15]];
    [lbl_email setText:@"Email(*)"];
    [self addSubview:lbl_email];
    
    txt_email = [[UITextField alloc]initWithFrame:CGRectMake(10, 130, rect.size.width-20, 30-1)];
    txt_email.delegate = self;
    //[txt_email setBackgroundColor:[UIColor redColor]];
    [self addSubview:txt_email];
    
    lbl_suggestion = [[UILabel alloc]initWithFrame:CGRectMake(10, 170, rect.size.width/2.0, 30)];
    //[lbl_suggestion setBackgroundColor:[UIColor greenColor]];
    [lbl_suggestion setFont:[UIFont boldSystemFontOfSize:15]];
    [lbl_suggestion setText:@"Bugs/Suggestions(*)"];
    [self addSubview:lbl_suggestion];
    
    txt_suggestion = [[UITextView alloc]initWithFrame:CGRectMake(10, 210, rect.size.width-20, 110-1)];
    //[txt_suggestion setBackgroundColor:[UIColor redColor]];
    txt_suggestion.delegate = self;
    [self addSubview:txt_suggestion];

    but_submit = [[UIButton alloc]initWithFrame:CGRectMake(100, 370.0, 200.0, 35.0)];
    [but_submit addTarget:self
                 action:@selector(Submit:)
       forControlEvents:UIControlEventTouchUpInside];
    [but_submit setBackgroundColor:[UIColor blueColor]];
    [but_submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but_submit setTitle:@"Submit" forState:UIControlStateNormal];
    [self addSubview:but_submit];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardBecomesVisible:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardBecomesHidden:) name:UIKeyboardDidHideNotification object:nil];
    _Underline = [[CAShapeLayer alloc] init];
    [_Underline setLineWidth:2.0f];
    [_Underline setStrokeColor:[UIColor grayColor].CGColor];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)Submit:(UIButton*) p_but
{
    
}

- (void) setTVScrolledForDataEntry
{
    CGRect l_inputfieldbounds = [_activeTxtFldOrVw convertRect:_activeTxtFldOrVw.bounds toView:self];
    CGRect l_superbounds = self.superview.bounds;
    if ((l_inputfieldbounds.origin.y+l_inputfieldbounds.size.height+10.0)>(l_superbounds.size.height- _keyBoardSize.height))
    {
        CGFloat l_offsetheight = (l_inputfieldbounds.origin.y+l_inputfieldbounds.size.height) - (l_superbounds.size.height-_keyBoardSize.height)+10.0;
        [UIView
         animateWithDuration:0.2
         animations:^{
             [self setContentOffset:CGPointMake(0, self.contentOffset.y+ l_offsetheight)];
         }];
    }
}

- (void) addUnderLineToTxtObj
{
    if ([_activeTxtFldOrVw.layer.sublayers count]>1)
    {
        [[_activeTxtFldOrVw.layer.sublayers objectAtIndex:1] removeFromSuperlayer];
    }
    if (_Underline) {
        [_Underline removeFromSuperlayer];
    }
    UIBezierPath * l_undelinepath = [[UIBezierPath alloc] init];
    [l_undelinepath moveToPoint:CGPointMake(0, _activeTxtFldOrVw.bounds.size.height-10)];
    [l_undelinepath addLineToPoint:CGPointMake(0, _activeTxtFldOrVw.bounds.size.height)];
    [l_undelinepath addLineToPoint:CGPointMake(_activeTxtFldOrVw.bounds.size.width, _activeTxtFldOrVw.bounds.size.height)];
    [l_undelinepath addLineToPoint:CGPointMake(_activeTxtFldOrVw.bounds.size.width, _activeTxtFldOrVw.bounds.size.height-10)];
    _Underline.path = l_undelinepath.CGPath;
    [_activeTxtFldOrVw.layer addSublayer:_Underline];
}


#pragma notifications for keyboard will show and hide related

- (void) keyboardBecomesVisible:(NSNotification*) p_visibeNotification
{
    NSDictionary * l_userInfo = [p_visibeNotification userInfo];
    _keyBoardSize = [[l_userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    if (_activeTxtFldOrVw)
        [self setTVScrolledForDataEntry];
    
}

- (void) keyboardBecomesHidden:(NSNotification*) p_hidingNotification
{
    if (self.contentOffset.y!=0)
    {
        [UIView animateWithDuration:.2
                         animations:^{
                             [self setContentOffset:CGPointZero];
                             
        }];
        _activeTxtFldOrVw = nil;
    }
}


#pragma text field delegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _activeTxtFldOrVw = (UIView*) textField;
    [self addUnderLineToTxtObj];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:txt_name])
    {
        [txt_email becomeFirstResponder];
    }
    else if ([textField isEqual:txt_email])
    {
        [txt_suggestion becomeFirstResponder];
    }
    else
        [textField resignFirstResponder];
    
    return YES;
}


#pragma text view delegates

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _activeTxtFldOrVw = (UIView*) textView;
    [self addUnderLineToTxtObj];
    return YES;
}


@end
