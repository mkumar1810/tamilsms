//
//  smsFeedbackScreen.m
//  tamilsms
//
//  Created by Mohan Kumar on 29/09/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
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
        [self setScrollEnabled:YES];
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
    
    
    //lbl_name = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, rect.size.width/4.0, 30)];
    lbl_name = [UILabel new];
    [lbl_name setFont:[UIFont boldSystemFontOfSize:15]];
    [lbl_name setText:@"Name(*)"];
    lbl_name.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_name];
    
    [lbl_name addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[IN(30)]" options:0 metrics:nil views:@{@"IN":lbl_name}]];
    [lbl_name addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[IN(100)]" options:0 metrics:nil views:@{@"IN":lbl_name}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[IN]" options:0 metrics:nil views:@{@"IN":lbl_name}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_name
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.0
                                                      constant:10.0]];
    

    
    //txt_name = [[UITextField alloc]initWithFrame:CGRectMake(10, 50, rect.size.width-20, 30-1)];
    txt_name = [UITextField new];
    [txt_name setBackgroundColor:[UIColor colorWithRed:0.93 green:1.00 blue:1.00 alpha:1.0]];
    txt_name.delegate = self;
    txt_name.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:txt_name];
    
    [txt_name addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[TN(30)]" options:0 metrics:nil views:@{@"TN":txt_name}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-50-[TN]" options:0 metrics:nil views:@{@"TN":txt_name}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:txt_name
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-20.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:txt_name
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    //lbl_email = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, rect.size.width/4.0, 30)];
    //[lbl_email setBackgroundColor:[UIColor greenColor]];
    lbl_email = [UILabel new];
    [lbl_email setFont:[UIFont boldSystemFontOfSize:15]];
    [lbl_email setText:@"Email(*)"];
    lbl_email.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_email];
    
    [lbl_email addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[IE(30)]" options:0 metrics:nil views:@{@"IE":lbl_email}]];
    [lbl_email addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[IE(100)]" options:0 metrics:nil views:@{@"IE":lbl_email}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-90-[IE]" options:0 metrics:nil views:@{@"IE":lbl_email}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_email
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.0
                                                      constant:10.0]];
    
    //txt_email = [[UITextField alloc]initWithFrame:CGRectMake(10, 130, rect.size.width-20, 30-1)];
    txt_email = [UITextField new];
    txt_email.delegate = self;
    [txt_email setBackgroundColor:[UIColor colorWithRed:0.93 green:1.00 blue:1.00 alpha:1.0]];
    txt_email.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:txt_email];
    
    [txt_email addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[TN(30)]" options:0 metrics:nil views:@{@"TN":txt_email}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-130-[TN]" options:0 metrics:nil views:@{@"TN":txt_email}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:txt_email
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-20.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:txt_email
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    //lbl_suggestion = [[UILabel alloc]initWithFrame:CGRectMake(10, 170, rect.size.width/2.0, 30)];
    lbl_suggestion = [UILabel new];
    [lbl_suggestion setFont:[UIFont boldSystemFontOfSize:15]];
    [lbl_suggestion setText:@"Bugs/Suggestions(*)"];
    lbl_suggestion.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_suggestion];
    
    [lbl_suggestion addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[IN(30)]" options:0 metrics:nil views:@{@"IN":lbl_suggestion}]];
    [lbl_suggestion addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[IN(150)]" options:0 metrics:nil views:@{@"IN":lbl_suggestion}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-170-[IN]" options:0 metrics:nil views:@{@"IN":lbl_suggestion}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_suggestion
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.0
                                                      constant:10.0]];
    
    //txt_suggestion = [[UITextView alloc]initWithFrame:CGRectMake(10, 210, rect.size.width-20, 110-1)];
    txt_suggestion = [UITextView new];
    [txt_suggestion setBackgroundColor:[UIColor colorWithRed:0.93 green:1.00 blue:1.00 alpha:1.0]];
    txt_suggestion.delegate = self;
    txt_suggestion.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:txt_suggestion];
    
    [txt_suggestion addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[TS(130)]" options:0 metrics:nil views:@{@"TS":txt_suggestion}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-210-[TS]" options:0 metrics:nil views:@{@"TS":txt_suggestion}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:txt_suggestion
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-20.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:txt_suggestion
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];

    //but_submit = [[UIButton alloc]initWithFrame:CGRectMake(100, 370.0, 200.0, 35.0)];
    but_submit = [UIButton new];
    [but_submit addTarget:self
                 action:@selector(Submit:)
       forControlEvents:UIControlEventTouchUpInside];
    [but_submit setBackgroundColor:[UIColor colorWithRed:0.38 green:0.38 blue:0.75 alpha:1.0]];
    [but_submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but_submit setTitle:@"Submit" forState:UIControlStateNormal];
    but_submit.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:but_submit];
    
    [but_submit addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BS(30)]" options:0 metrics:nil views:@{@"BS":but_submit}]];
    [but_submit addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[BS(120)]" options:0 metrics:nil views:@{@"BS":but_submit}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-360-[BS]" options:0 metrics:nil views:@{@"BS":but_submit}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:but_submit
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    [self layoutIfNeeded];
     [self setContentSize:CGSizeMake(rect.size.width, 400)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardBecomesVisible:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardBecomesHidden:) name:UIKeyboardDidHideNotification object:nil];
    _Underline = [[CAShapeLayer alloc] init];
    [_Underline setLineWidth:1.0f];
    [_Underline setFillColor:[UIColor colorWithRed:0.00 green:1.00 blue:1.00 alpha:1.0].CGColor];
    //[_Underline setBorderColor:[UIColor colorWithRed:0.00 green:1.00 blue:1.00 alpha:1.0].CGColor];
    //[_Underline setStrokeColor:[UIColor colorWithRed:0.00 green:1.00 blue:1.00 alpha:1.0].CGColor];
    
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
    //NSLog(@"starting tv scroll for data entry");
    CGRect l_inputfieldbounds = [_activeTxtFldOrVw convertRect:_activeTxtFldOrVw.bounds toView:self];
    CGRect l_superbounds = self.superview.bounds;
    if ((l_inputfieldbounds.origin.y+l_inputfieldbounds.size.height+10.0)>(l_superbounds.size.height- _keyBoardSize.height))
    {
        CGFloat l_offsetheight = (l_inputfieldbounds.origin.y+l_inputfieldbounds.size.height) - (l_superbounds.size.height-_keyBoardSize.height)+10.0;
        [UIView
         animateWithDuration:0.2
         animations:^{
             [self setContentOffset:CGPointMake(0, self.contentOffset.y+ l_offsetheight)];
             NSLog(@"setting tv scroll for data entry %f", l_offsetheight);
         }];
    }
    //NSLog(@"ending tv scroll for data entry");
}

- (void) addUnderLineToTxtObj
{
    //return;
    //NSLog(@"addunderline to text start");
    /*if ([_activeTxtFldOrVw.layer.sublayers count]>1)
    {
        [[_activeTxtFldOrVw.layer.sublayers objectAtIndex:1] removeFromSuperlayer];
    }*/
    if (_Underline) {
        [_Underline removeFromSuperlayer];
    }
    UIBezierPath * l_undelinepath = [[UIBezierPath alloc] init];
    [l_undelinepath moveToPoint:CGPointMake(0, _activeTxtFldOrVw.bounds.size.height-8)];
    [l_undelinepath addLineToPoint:CGPointMake(0, _activeTxtFldOrVw.bounds.size.height)];
    [l_undelinepath addLineToPoint:CGPointMake(_activeTxtFldOrVw.bounds.size.width, _activeTxtFldOrVw.bounds.size.height)];
    [l_undelinepath addLineToPoint:CGPointMake(_activeTxtFldOrVw.bounds.size.width, _activeTxtFldOrVw.bounds.size.height-8)];
    [l_undelinepath addLineToPoint:CGPointMake(_activeTxtFldOrVw.bounds.size.width-2, _activeTxtFldOrVw.bounds.size.height-8)];
    [l_undelinepath addLineToPoint:CGPointMake(_activeTxtFldOrVw.bounds.size.width-2, _activeTxtFldOrVw.bounds.size.height-2)];
    [l_undelinepath addLineToPoint:CGPointMake(2, _activeTxtFldOrVw.bounds.size.height-2)];
    [l_undelinepath moveToPoint:CGPointMake(2, _activeTxtFldOrVw.bounds.size.height-8)];
    [l_undelinepath closePath];
    _Underline.path = l_undelinepath.CGPath;
    [_Underline setBackgroundColor:[UIColor clearColor].CGColor];
    [_activeTxtFldOrVw.layer addSublayer:_Underline];
    //NSLog(@"addunderline to text end");
}


#pragma notifications for keyboard will show and hide related

- (void) keyboardBecomesVisible:(NSNotification*) p_visibeNotification
{
    //NSLog(@"keyboard start envet fired");
    NSDictionary * l_userInfo = [p_visibeNotification userInfo];
    _keyBoardSize = [[l_userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    if (_activeTxtFldOrVw)
        [self setTVScrolledForDataEntry];
    //NSLog(@"keyboard start envet finished");
    
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

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}


@end
