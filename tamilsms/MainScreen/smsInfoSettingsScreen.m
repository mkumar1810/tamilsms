//
//  smsInfoSettingsScreen.m
//  tamilsms
//
//  Created by arun benjamin on 30/09/15.
//  Copyright © 2015 arun benjamin. All rights reserved.
//

#import "smsInfoSettingsScreen.h"

@interface smsInfoSettingsScreen()
{
    UIImageView * img_logoImg;
    UILabel *lbl_tamilsms, *lbl_vrson,*lbl_email,*lbl_rights;
    UIButton * but_email, *but_coPolicy, *but_terCond, *but_priPolicy, *but_fedbk, *but_seting;
}
@end

@implementation smsInfoSettingsScreen

-(void)drawRect:(CGRect)rect
{
    img_logoImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    [img_logoImg setImage:[UIImage imageNamed:@"app_icon"]];
    [self addSubview:img_logoImg];
    
    lbl_tamilsms = [[UILabel alloc]initWithFrame:CGRectMake(150, 70, rect.size.width/4.0, 20)];
    [lbl_tamilsms setText:@"Tamil Sms"];
    [self addSubview:lbl_tamilsms];
    
    lbl_vrson = [[UILabel alloc]initWithFrame:CGRectMake(150, 100, 100, 20)];
    [lbl_vrson setText:@"Ver: 1.8.1"];
    [self addSubview:lbl_vrson];
    
    lbl_email = [[UILabel alloc]initWithFrame:CGRectMake(130, 130, 50, 20)];
    [lbl_email setText:@"Email"];
    [self addSubview:lbl_email];
    
    but_email = [[UIButton alloc]initWithFrame:CGRectMake(185, 130, 100, 20)];
    [but_email setTitle:@"binu@live.in" forState:UIControlStateNormal];
    [but_email setBackgroundColor:[UIColor redColor]];
    [self addSubview:but_email];
    
    lbl_rights = [[UILabel alloc]initWithFrame:CGRectMake(130, 160, 150, 20)];
    [lbl_rights setText:@"All Rights Reserved"];
    [self addSubview:lbl_rights];
    
    but_coPolicy = [[UIButton alloc]initWithFrame:CGRectMake(130, 190, 150, 20)];
    [but_coPolicy setTitle:@"Content Policy" forState:UIControlStateNormal];
    [but_coPolicy setBackgroundColor:[UIColor redColor]];
    [self addSubview:but_coPolicy];
    
    but_terCond = [[UIButton alloc]initWithFrame:CGRectMake(130, 220, 150, 20)];
    [but_terCond setTitle:@"Terms & Condition" forState:UIControlStateNormal];
    [but_terCond setBackgroundColor:[UIColor redColor]];
    [self addSubview:but_terCond];
    
    but_priPolicy = [[UIButton alloc]initWithFrame:CGRectMake(130, 250, 150, 20)];
    [but_priPolicy setTitle:@"Privacy Policy" forState:UIControlStateNormal];
    [but_priPolicy setBackgroundColor:[UIColor redColor]];
    [self addSubview:but_priPolicy];
    
    but_seting = [[UIButton alloc]initWithFrame:CGRectMake(100, 280, 250, 20)];
    [but_seting setTitle:@"Settings" forState:UIControlStateNormal];
    [but_seting setBackgroundColor:[UIColor redColor]];
    [self addSubview:but_seting];
    
    but_fedbk = [[UIButton alloc]initWithFrame:CGRectMake(100, 310, 250, 20)];
    [but_fedbk setTitle:@"Send Feedback" forState:UIControlStateNormal];
    [but_fedbk setBackgroundColor:[UIColor redColor]];
    [self addSubview:but_fedbk];
}
@end
