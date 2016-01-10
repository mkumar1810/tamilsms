//
//  loginWelcomeScreeen.m
//  tamilsms
//
//  Created by arun benjamin on 14/11/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import "loginWelcomeScreeen.h"

@interface loginWelcomeScreeen()
{
    UILabel * lbl_welcom, *lbl_name, *lbl_count, *lbl_watng;
    UIButton * but_newSms, *but_newImg, *but_viewSms, *but_viewImg, * but_logout;
}

@end

@implementation loginWelcomeScreeen


-(instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:0.19 green:0.47 blue:0.72 alpha:1.0]];
        self.scrollEnabled = YES;
        //[self setContentSize:CGSizeMake(45, 56)];
        
    }
    return self;
}


-(void)drawRect:(CGRect)rect
{
    lbl_welcom = [UILabel new];
    [lbl_welcom setText:@"Welcome"];
    [lbl_welcom setTextAlignment:NSTextAlignmentCenter];
    [lbl_welcom setBackgroundColor:[UIColor redColor]];
    lbl_welcom.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:lbl_welcom];
    
    [lbl_welcom addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LW(30)]" options:0 metrics:nil views:@{@"LW":lbl_welcom}]];
    [lbl_welcom addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LW(300)]" options:0 metrics:nil views:@{@"LW":lbl_welcom}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[LW]" options:0 metrics:nil views:@{@"LW":lbl_welcom}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_welcom
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    lbl_name = [UILabel new];
    [lbl_name setText:[[NSUserDefaults standardUserDefaults] valueForKey:@"username"]];
    [lbl_name setTextAlignment:NSTextAlignmentCenter];
    [lbl_name setBackgroundColor:[UIColor blueColor]];
    lbl_name.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:lbl_name];
    
    [lbl_name addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LN(20)]" options:0 metrics:nil views:@{@"LN":lbl_name}]];
    [lbl_name addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LN(300)]" options:0 metrics:nil views:@{@"LN":lbl_name}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-60-[LN]" options:0 metrics:nil views:@{@"LN":lbl_name}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_name
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    lbl_count = [UILabel new];
    [lbl_count setText:[NSString stringWithFormat:@"Total SMS by me:%d",[[[NSUserDefaults standardUserDefaults] valueForKey:@"total"] intValue]]];
    [lbl_count setTextAlignment:NSTextAlignmentCenter];
    [lbl_count setBackgroundColor:[UIColor yellowColor]];
    lbl_count.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:lbl_count];
    
    [lbl_count addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LC(20)]" options:0 metrics:nil views:@{@"LC":lbl_count}]];
    [lbl_count addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LC(300)]" options:0 metrics:nil views:@{@"LC":lbl_count}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[LC]" options:0 metrics:nil views:@{@"LC":lbl_count}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_count
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    
    lbl_watng = [UILabel new];
    [lbl_watng setText:[NSString stringWithFormat:@"SMS waiting for Moderation:%d",[[[NSUserDefaults standardUserDefaults] valueForKey:@"mod"] intValue]]];
    [lbl_watng setTextAlignment:NSTextAlignmentCenter];
    [lbl_watng setBackgroundColor:[UIColor cyanColor]];
    lbl_watng.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:lbl_watng];
    
    [lbl_watng addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LW(20)]" options:0 metrics:nil views:@{@"LW":lbl_watng}]];
    [lbl_watng addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LW(300)]" options:0 metrics:nil views:@{@"LW":lbl_watng}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[LW]" options:0 metrics:nil views:@{@"LW":lbl_watng}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_watng
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    but_newSms = [UIButton new];
    [but_newSms setTitle:@"Write New SMS" forState:UIControlStateNormal];
    [but_newSms setBackgroundColor:[UIColor whiteColor]];
    [but_newSms setTitleColor:[UIColor colorWithRed:0.29 green:0.53 blue:0.91 alpha:1.0] forState:UIControlStateNormal];
    [but_newSms addTarget:self action:@selector(eventForNewMsgPosting) forControlEvents:UIControlEventTouchUpInside];
    but_newSms.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:but_newSms];
    
    [but_newSms addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BN(30)]" options:0 metrics:nil views:@{@"BN":but_newSms}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-140-[BN]" options:0 metrics:nil views:@{@"BN":but_newSms}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[BN]" options:0 metrics:nil views:@{@"BN":but_newSms}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:but_newSms
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-20.0]];
    
    but_newImg = [UIButton new];
    [but_newImg setTitle:@"New Image" forState:UIControlStateNormal];
    [but_newImg setBackgroundColor:[UIColor whiteColor]];
    [but_newImg setTitleColor:[UIColor colorWithRed:0.29 green:0.53 blue:0.91 alpha:1.0] forState:UIControlStateNormal];
    [but_newImg addTarget:self action:@selector(eventForNewImgPosting) forControlEvents:UIControlEventTouchUpInside];
    but_newImg.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:but_newImg];
    
    [but_newImg addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BNI(30)]" options:0 metrics:nil views:@{@"BNI":but_newImg}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-180-[BNI]" options:0 metrics:nil views:@{@"BNI":but_newImg}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[BNI]" options:0 metrics:nil views:@{@"BNI":but_newImg}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:but_newImg
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-20.0]];
    
    but_viewSms = [UIButton new];
    [but_viewSms setTitle:@"View my SMS" forState:UIControlStateNormal];
    [but_viewSms setBackgroundColor:[UIColor whiteColor]];
    [but_viewSms setTitleColor:[UIColor colorWithRed:0.29 green:0.53 blue:0.91 alpha:1.0] forState:UIControlStateNormal];
    but_viewSms.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:but_viewSms];
    
    [but_viewSms addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BVS(30)]" options:0 metrics:nil views:@{@"BVS":but_viewSms}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-220-[BVS]" options:0 metrics:nil views:@{@"BVS":but_viewSms}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[BVS]" options:0 metrics:nil views:@{@"BVS":but_viewSms}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:but_viewSms
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-20.0]];
    
    but_viewImg = [UIButton new];
    [but_viewImg setTitle:@"View my Image" forState:UIControlStateNormal];
    [but_viewImg setBackgroundColor:[UIColor whiteColor]];
    [but_viewImg setTitleColor:[UIColor colorWithRed:0.29 green:0.53 blue:0.91 alpha:1.0] forState:UIControlStateNormal];
    but_viewImg.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:but_viewImg];
    
    [but_viewImg addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BVI(30)]" options:0 metrics:nil views:@{@"BVI":but_viewImg}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-260-[BVI]" options:0 metrics:nil views:@{@"BVI":but_viewImg}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[BVI]" options:0 metrics:nil views:@{@"BVI":but_viewImg}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:but_viewImg
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-20.0]];
    
    but_logout = [UIButton new];
    [but_logout setTitle:@"Logout" forState:UIControlStateNormal];
    [but_logout setBackgroundColor:[UIColor whiteColor]];
    [but_logout setTitleColor:[UIColor colorWithRed:0.29 green:0.53 blue:0.91 alpha:1.0] forState:UIControlStateNormal];
    but_logout.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:but_logout];
    
    [but_logout addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BL(30)]" options:0 metrics:nil views:@{@"BL":but_logout}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-300-[BL]" options:0 metrics:nil views:@{@"BL":but_logout}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[BL]" options:0 metrics:nil views:@{@"BL":but_logout}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:but_logout
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-20.0]];

    


    [self layoutIfNeeded];
    
}

-(void)eventForNewMsgPosting
{
    [self.screenDelegate postNewTextSMSMessage];
}

-(void)eventForNewImgPosting
{
    [self.screenDelegate postNewImageSMSMessage];
}

@end
