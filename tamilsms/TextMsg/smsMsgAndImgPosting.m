//
//  smsMsgAndImgPosting.m
//  tamilsms
//
//  Created by arun benjamin on 23/11/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import "smsMsgAndImgPosting.h"
#import "categoryNameForMsgPosting.h"

@interface smsMsgAndImgPosting()<categoryNameDelegate>

@property (nonatomic,strong) categoryNameForMsgPosting * catNamePostVw;

@end

@implementation smsMsgAndImgPosting


-(void)drawRect:(CGRect)rect
{
    txt_smsText = [[UITextField alloc]initWithFrame:CGRectMake(10, 20, rect.size.width-20, 80)];
    [txt_smsText setTextAlignment:NSTextAlignmentCenter];
    [txt_smsText setFont:[UIFont systemFontOfSize:15]];
    [txt_smsText setBackgroundColor:[UIColor lightGrayColor]];
    [self addSubview:txt_smsText];
    
    /*but_Catname = [[UIButton alloc]initWithFrame:CGRectMake(rect.size.width/4.0, 250, rect.size.width/2.0, 30)];
    [but_Catname setBackgroundColor:[UIColor lightGrayColor]];
    [but_Catname addTarget:self action:@selector(InstanceForMsgPosting) forControlEvents:UIControlEventTouchUpInside];
    [but_Catname setTitle:@"Select Category" forState:UIControlStateNormal];
    [self addSubview:but_Catname];*/
    
    but_help = [[UIButton alloc]initWithFrame:CGRectMake(rect.size.width/4.0+40,230, rect.size.width/4.0, 30)];
    [but_help setBackgroundColor:[UIColor orangeColor]];
    //[but_Catname addTarget:self action:@selector(InstanceForMsgPosting) forControlEvents:UIControlEventTouchDown];
    but_help.layer.cornerRadius = 8;
    but_help.layer.borderWidth = 1;
    but_help.layer.borderColor = [UIColor purpleColor].CGColor;
    [but_help setTitle:@"Help" forState:UIControlStateNormal];
    [self addSubview:but_help];
    
    but_submit = [[UIButton alloc]initWithFrame:CGRectMake(rect.size.width/4.0+40,180, rect.size.width/4.0, 30)];
    [but_submit setBackgroundColor:[UIColor orangeColor]];
    //[but_Catname addTarget:self action:@selector(InstanceForMsgPosting) forControlEvents:UIControlEventTouchDown];
    but_submit.layer.cornerRadius = 8;
    but_submit.layer.borderWidth = 1;
    but_submit.layer.borderColor = [UIColor purpleColor].CGColor;
    [but_submit setTitle:@"Submit" forState:UIControlStateNormal];
    [self addSubview:but_submit];
    
    
    txt_catgry = [[UITextField alloc]initWithFrame:CGRectMake(rect.size.width/4.0, 130, rect.size.width/2.0, 30)];
    [txt_catgry setBackgroundColor:[UIColor lightGrayColor]];
    [txt_catgry setDelegate:self];
    [txt_catgry setTextAlignment:NSTextAlignmentCenter];
    //[txt_catgry addTarget:self action:@selector(InstanceForMsgPosting) forControlEvents:UIControlEventTouchUpInside];
     //[txt_catgry addTarget:delegate action:@selector(InstanceForMsgPosting:) forControlEvents:UIControlEventEditingDidBegin];
    [txt_catgry setPlaceholder:@"select category"];
    [self addSubview:txt_catgry];
    
    
}

/*- (void) keyboardBecomesHidden:(NSNotification*) p_hidingNotification
{
    if (self.contentOffset.y!=0)
    {
        [UIView animateWithDuration:.2
                         animations:^{
                             [self setContentOffset:CGPointZero];
                             
                         }];
        _activeTxtFldOrVw = nil;
    }
}*/


/*- (void) addUnderLineToTxtObj
{
    //return;
    //NSLog(@"addunderline to text start");*/
    /*if ([_activeTxtFldOrVw.layer.sublayers count]>1)
     {
     [[_activeTxtFldOrVw.layer.sublayers objectAtIndex:1] removeFromSuperlayer];
     }*/
   /* if (_Underline) {
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
}*/

/*- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _activeTxtFldOrVw = (UIView*) textField;
    [self addUnderLineToTxtObj];
    return YES;
}*/

-(void)InstanceForMsgPosting
{
    self.catNamePostVw = [categoryNameForMsgPosting new];
    self.catNamePostVw.translatesAutoresizingMaskIntoConstraints = NO;
    //self.dropDwnOptions.optionsDelegate = self;
    self.catNamePostVw.categoryDelegate=self;
    [self addSubview:self.catNamePostVw];
    [self.catNamePostVw setBackgroundColor:[UIColor whiteColor]];
    //[self bringSubviewToFront:self.smsMsgAndImgPostingSV];
    
    // Width constraint,
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.catNamePostVw
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual toItem:self
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:0.5 constant:0]];
    
    
    // Height constraint,
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.catNamePostVw
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.5
                                                           constant:0]];
    
    // Center horizontally
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.catNamePostVw
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    // Center vertically
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.catNamePostVw
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0]];
}

#pragma mark
#pragma text field delegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self InstanceForMsgPosting];
    return NO;
}

-(void)categoryNameClickedForTheCell:(NSArray *)p_array
{
    txt_catgry.text = [p_array valueForKey:@"category_name"];
    [self.catNamePostVw removeFromSuperview];
    NSLog(@"the log value is %@",p_array);
}
@end
