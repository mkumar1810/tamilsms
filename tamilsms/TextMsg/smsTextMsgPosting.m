//
//  smsTextMsgPosting.m
//  tamilsms
//
//  Created by Mohan Kumar on 10/01/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import "smsTextMsgPosting.h"
#import "categoryNameForMsgPosting.h"
#import "smsRESTProxy.h"

@interface smsTextMsgPosting()<categoryNameDelegate, UIGestureRecognizerDelegate>
{
    UIGestureRecognizer * _justGesture;
}
@property (nonatomic,strong) categoryNameForMsgPosting * catNamePostVw;
@property (nonatomic) NSInteger msgCategoryId;

@end

@implementation smsTextMsgPosting

-(void)drawRect:(CGRect)rect
{
    if (txtvw_sms)
    {
        return;
    }
    txtvw_sms = [[UITextView alloc]initWithFrame:CGRectMake(10, 20, rect.size.width-20, 100)];
    [txtvw_sms setTextAlignment:NSTextAlignmentCenter];
    [txtvw_sms setFont:[UIFont systemFontOfSize:15]];
    [txtvw_sms setBackgroundColor:[UIColor lightGrayColor]];
    [self addSubview:txtvw_sms];

    
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
    [but_submit addTarget:self action:@selector(submitTheMessage) forControlEvents:UIControlEventTouchDown];
    but_submit.layer.cornerRadius = 8;
    but_submit.layer.borderWidth = 1;
    but_submit.layer.borderColor = [UIColor purpleColor].CGColor;
    [but_submit setTitle:@"Submit" forState:UIControlStateNormal];
    [self addSubview:but_submit];
    
    
    txt_catgry = [[UITextField alloc]initWithFrame:CGRectMake(10, 130, rect.size.width-20.0f, 30)];
    [txt_catgry setBackgroundColor:[UIColor lightGrayColor]];
    [txt_catgry setDelegate:self];
    [txt_catgry setTextAlignment:NSTextAlignmentCenter];
    //[txt_catgry addTarget:self action:@selector(InstanceForMsgPosting) forControlEvents:UIControlEventTouchUpInside];
    //[txt_catgry addTarget:delegate action:@selector(InstanceForMsgPosting:) forControlEvents:UIControlEventEditingDidBegin];
    [txt_catgry setPlaceholder:@"select category"];
    [self addSubview:txt_catgry];
    
    _justGesture = [[UIGestureRecognizer alloc] init];
    _justGesture.delegate = self;
    [self addGestureRecognizer:_justGesture];
}

-(void)InstanceForMsgPosting
{
    [txtvw_sms resignFirstResponder];
    [txt_catgry resignFirstResponder];
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
                                                    multiplier:1.0 constant:(20)]];
    
    
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
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:txt_catgry
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:0]];
}

- (void) submitTheMessage
{
    NSInteger l_userid = [[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] integerValue];
    NSDictionary * l_inputParams = @{@"news_heading":txtvw_sms.text,
                                     @"cat_id":@(self.msgCategoryId),
                                     @"user_id":@(l_userid)};
    [[smsRESTProxy alloc]
     initDatawithAPIType:@"POSTTXTMSG"
     andInputParams:l_inputParams
     andReturnMethod:^(NSData * p_returnData){
         NSLog(@"the received is %@", [[NSString alloc] initWithData:p_returnData encoding:NSUTF8StringEncoding]);
         [self.txtMsgDelegate textMsgPostedSuccessfully];
     }];
}

#pragma mark
#pragma text field delegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self InstanceForMsgPosting];
    return NO;
}

#pragma mark - category selection delegates

-(void)categoryNameClickedForTheCell:(NSDictionary*)p_catInfo
{
    txt_catgry.text = [p_catInfo valueForKey:@"category_name"];
    self.msgCategoryId = [[p_catInfo valueForKey:@"cid"] integerValue];
    [self.catNamePostVw removeFromSuperview];
}

#pragma mark - gesture recognizer delegates

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint l_touchPoint = [touch locationInView:self];
    if ((CGRectContainsPoint(txtvw_sms.frame, l_touchPoint)==NO) && (CGRectContainsPoint(txt_catgry.frame, l_touchPoint)==NO))
    {
        [txtvw_sms resignFirstResponder];
        [txt_catgry resignFirstResponder];
    }
    return NO;
}



@end

