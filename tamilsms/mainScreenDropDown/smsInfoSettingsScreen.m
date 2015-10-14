//
//  smsInfoSettingsScreen.m
//  tamilsms
//
//  Created by Mohan Kumar on 30/09/15.
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
    //img_logoImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    img_logoImg = [UIImageView new];
    [img_logoImg setImage:[UIImage imageNamed:@"app_icon"]];
    img_logoImg.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:img_logoImg];
    
    [img_logoImg addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[IL(60)]" options:0 metrics:nil views:@{@"IL":img_logoImg}]];
    [img_logoImg addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[IL(60)]" options:0 metrics:nil views:@{@"IL":img_logoImg}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[IL]" options:0 metrics:nil views:@{@"IL":img_logoImg}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:img_logoImg
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.0
                                                      constant:10.0]];

    
    lbl_tamilsms = [[UILabel alloc]initWithFrame:CGRectMake(150, 70, rect.size.width/4.0, 20)];
    lbl_tamilsms = [UILabel new];
    [lbl_tamilsms setTextAlignment:NSTextAlignmentCenter];
    [lbl_tamilsms setText:@"Tamil Sms"];
    lbl_tamilsms.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:lbl_tamilsms];
    
    [lbl_tamilsms addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LT(30)]" options:0 metrics:nil views:@{@"LT":lbl_tamilsms}]];
    [lbl_tamilsms addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LT(100)]" options:0 metrics:nil views:@{@"LT":lbl_tamilsms}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-60-[LT]" options:0 metrics:nil views:@{@"LT":lbl_tamilsms}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_tamilsms
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    //lbl_vrson = [[UILabel alloc]initWithFrame:CGRectMake(150, 100, 100, 20)];
    lbl_vrson = [UILabel new];
    [lbl_vrson setText:@"Ver: 1.8.1"];
    [lbl_vrson setTextAlignment:NSTextAlignmentCenter];
    lbl_vrson.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_vrson];
    
    [lbl_vrson addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LT(30)]" options:0 metrics:nil views:@{@"LT":lbl_vrson}]];
    [lbl_vrson addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LT(100)]" options:0 metrics:nil views:@{@"LT":lbl_vrson}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-90-[LT]" options:0 metrics:nil views:@{@"LT":lbl_vrson}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_vrson
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    //lbl_email = [[UILabel alloc]initWithFrame:CGRectMake(130, 130, 50, 20)];
    lbl_email = [UILabel new];
    [lbl_email setText:@"Email:"];
    lbl_email.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_email];
    
    [lbl_email addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LE(30)]" options:0 metrics:nil views:@{@"LE":lbl_email}]];
    [lbl_email addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LE(100)]" options:0 metrics:nil views:@{@"LE":lbl_email}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-120-[LE]" options:0 metrics:nil views:@{@"LE":lbl_email}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_email
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:-20.0]];
    
    //but_email = [[UIButton alloc]initWithFrame:CGRectMake(185, 130, 100, 20)];
    but_email = [UIButton new];
    [but_email setTitle:@"binu@live.in" forState:UIControlStateNormal];
    [but_email setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    but_email.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:but_email];
    
    [but_email addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BE(30)]" options:0 metrics:nil views:@{@"BE":but_email}]];
    [but_email addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[BE(100)]" options:0 metrics:nil views:@{@"BE":but_email}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-120-[BE]" options:0 metrics:nil views:@{@"BE":but_email}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:but_email
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:30.0]];
    
    //lbl_rights = [[UILabel alloc]initWithFrame:CGRectMake(130, 160, 150, 20)];
    lbl_rights = [UILabel new];
    [lbl_rights setText:@"All Rights Reserved"];
    [lbl_rights setTextAlignment:NSTextAlignmentCenter];
    lbl_rights.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_rights];
    
    [lbl_rights addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LR(30)]" options:0 metrics:nil views:@{@"LR":lbl_rights}]];
    [lbl_rights addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LR(150)]" options:0 metrics:nil views:@{@"LR":lbl_rights}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-150-[LR]" options:0 metrics:nil views:@{@"LR":lbl_rights}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_rights
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];

    
    //but_coPolicy = [[UIButton alloc]initWithFrame:CGRectMake(130, 190, 150, 20)];
    but_coPolicy = [UIButton new];
    [but_coPolicy setTitle:@"Content Policy" forState:UIControlStateNormal];
    [but_coPolicy setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    but_coPolicy.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:but_coPolicy];
    
    [but_coPolicy addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BC(30)]" options:0 metrics:nil views:@{@"BC":but_coPolicy}]];
    [but_coPolicy addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[BC(150)]" options:0 metrics:nil views:@{@"BC":but_coPolicy}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-180-[BC]" options:0 metrics:nil views:@{@"BC":but_coPolicy}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:but_coPolicy
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    //but_terCond = [[UIButton alloc]initWithFrame:CGRectMake(130, 220, 150, 20)];
    but_terCond = [UIButton new];
    [but_terCond setTitle:@"Terms & Condition" forState:UIControlStateNormal];
    [but_terCond setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    but_terCond.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:but_terCond];
    
    
    [but_terCond addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BT(30)]" options:0 metrics:nil views:@{@"BT":but_terCond}]];
    [but_terCond addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[BT(150)]" options:0 metrics:nil views:@{@"BT":but_terCond}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-210-[BT]" options:0 metrics:nil views:@{@"BT":but_terCond}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:but_terCond
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    //but_priPolicy = [[UIButton alloc]initWithFrame:CGRectMake(130, 250, 150, 20)];
    but_priPolicy = [UIButton new];
    [but_priPolicy setTitle:@"Privacy Policy" forState:UIControlStateNormal];
    [but_priPolicy setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    but_priPolicy.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:but_priPolicy];
    
    [but_priPolicy addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BP(30)]" options:0 metrics:nil views:@{@"BP":but_priPolicy}]];
    [but_priPolicy addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[BP(150)]" options:0 metrics:nil views:@{@"BP":but_priPolicy}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-240-[BP]" options:0 metrics:nil views:@{@"BP":but_priPolicy}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:but_priPolicy
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];

    
    //but_seting = [[UIButton alloc]initWithFrame:CGRectMake(100, 280, 250, 20)];
    but_seting = [UIButton new];
    [but_seting setTitle:@"Settings" forState:UIControlStateNormal];
    [but_seting setBackgroundColor:[UIColor colorWithRed:0.38 green:0.38 blue:0.75 alpha:1.0]];
    but_seting.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:but_seting];
    
    [but_seting addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BS(30)]" options:0 metrics:nil views:@{@"BS":but_seting}]];
    [but_seting addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[BS(200)]" options:0 metrics:nil views:@{@"BS":but_seting}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-270-[BS]" options:0 metrics:nil views:@{@"BS":but_seting}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:but_seting
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];

    
    //but_fedbk = [[UIButton alloc]initWithFrame:CGRectMake(100, 310, 250, 20)];
    but_fedbk = [UIButton new];
    [but_fedbk setTitle:@"Send Feedback" forState:UIControlStateNormal];
    [but_fedbk setBackgroundColor:[UIColor colorWithRed:0.38 green:0.38 blue:0.75 alpha:1.0]];
    but_fedbk.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:but_fedbk];
    
    [but_fedbk addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BF(30)]" options:0 metrics:nil views:@{@"BF":but_fedbk}]];
    [but_fedbk addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[BF(250)]" options:0 metrics:nil views:@{@"BF":but_fedbk}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-310-[BF]" options:0 metrics:nil views:@{@"BF":but_fedbk}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:but_fedbk
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
     [self setContentSize:CGSizeMake(rect.size.width, 350)];
    
     [self layoutIfNeeded];

}
@end
