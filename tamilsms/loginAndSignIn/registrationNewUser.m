//
//  registrationNewUser.m
//  tamilsms
//
//  Created by Mohan Kumar on 05/10/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import "registrationNewUser.h"

@interface registrationNewUser()<UITextFieldDelegate>
{
    UILabel *lbl_name,*lbl_email,*lbl_password,*lbl_cnfPassword,*lbl_place,*lbl_mobno,*lbl_agre, *lbl_cntpolicy, *lbl_coma, *lbl_termCondi, *lbl_and, *lbl_privacy;
    UITextField *txt_name,*txt_email,*txt_password,*txt_cnfPassword,*txt_place,*txt_mobno;
    UIButton * btn_sumit;
    UIView * _activeTxtFldOrVw;
    CGSize _keyBoardSize;
    CAShapeLayer * _Underline;
}

@end


@implementation registrationNewUser

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.scrollEnabled = YES;
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    lbl_name = [UILabel new];
    [lbl_name setText:@"Name(*)"];
    [lbl_name setFont:[UIFont systemFontOfSize:15]];
    [lbl_name setTextColor:[UIColor blackColor]];
    [lbl_name setTextAlignment:NSTextAlignmentLeft];
    lbl_name.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_name];
    
    [lbl_name addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LN(20)]" options:0 metrics:nil views:@{@"LN":lbl_name}]];
    [lbl_name addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LN(100)]" options:0 metrics:nil views:@{@"LN":lbl_name}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[LN]" options:0 metrics:nil views:@{@"LN":lbl_name}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[LN]" options:0 metrics:nil views:@{@"LN":lbl_name}]];
    
    txt_name = [UITextField new];
    [txt_name setFont:[UIFont systemFontOfSize:15]];
    [txt_name setTextColor:[UIColor blackColor]];
    txt_name.delegate = self;
    [txt_name setBackgroundColor:[UIColor colorWithRed:0.93 green:1.00 blue:1.00 alpha:1.0]];
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
                                                      constant:-30.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:txt_name
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    lbl_email = [UILabel new];
    [lbl_email setText:@"Email(*)"];
    [lbl_email setFont:[UIFont systemFontOfSize:15]];
    [lbl_email setTextColor:[UIColor blackColor]];
    [lbl_email setTextAlignment:NSTextAlignmentLeft];
    lbl_email.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_email];
    
    [lbl_email addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LE(20)]" options:0 metrics:nil views:@{@"LE":lbl_email}]];
    [lbl_email addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LE(100)]" options:0 metrics:nil views:@{@"LE":lbl_email}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-90-[LE]" options:0 metrics:nil views:@{@"LE":lbl_email}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[LE]" options:0 metrics:nil views:@{@"LE":lbl_email}]];
    
    txt_email = [UITextField new];
    [txt_email setFont:[UIFont systemFontOfSize:15]];
    [txt_email setTextColor:[UIColor blackColor]];
    txt_email.delegate = self;
    [txt_email setBackgroundColor:[UIColor colorWithRed:0.93 green:1.00 blue:1.00 alpha:1.0]];
    txt_email.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:txt_email];
    
    [txt_email addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[TE(30)]" options:0 metrics:nil views:@{@"TE":txt_email}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-120-[TE]" options:0 metrics:nil views:@{@"TE":txt_email}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:txt_email
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-30.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:txt_email
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    lbl_password = [UILabel new];
    [lbl_password setText:@"Password(*)"];
    [lbl_password setFont:[UIFont systemFontOfSize:15]];
    [lbl_password setTextColor:[UIColor blackColor]];
    [lbl_password setTextAlignment:NSTextAlignmentLeft];
    lbl_password.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_password];
    
    [lbl_password addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LP(20)]" options:0 metrics:nil views:@{@"LP":lbl_password}]];
    [lbl_password addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LP(100)]" options:0 metrics:nil views:@{@"LP":lbl_password}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-160-[LP]" options:0 metrics:nil views:@{@"LP":lbl_password}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[LP]" options:0 metrics:nil views:@{@"LP":lbl_password}]];
    
    txt_password = [UITextField new];
    [txt_password setFont:[UIFont systemFontOfSize:15]];
    [txt_password setTextColor:[UIColor blackColor]];
    txt_password.delegate = self;
    [txt_password setBackgroundColor:[UIColor colorWithRed:0.93 green:1.00 blue:1.00 alpha:1.0]];
    txt_password.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:txt_password];
    
    [txt_password addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[TP(30)]" options:0 metrics:nil views:@{@"TP":txt_password}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-190-[TP]" options:0 metrics:nil views:@{@"TP":txt_password}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:txt_password
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-30.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:txt_password
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    lbl_cnfPassword = [UILabel new];
    [lbl_cnfPassword setText:@"Repeat Password(*)"];
    [lbl_cnfPassword setFont:[UIFont systemFontOfSize:15]];
    [lbl_cnfPassword setTextColor:[UIColor blackColor]];
    [lbl_cnfPassword setTextAlignment:NSTextAlignmentLeft];
    lbl_cnfPassword.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_cnfPassword];
    
    [lbl_cnfPassword addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LCP(20)]" options:0 metrics:nil views:@{@"LCP":lbl_cnfPassword}]];
    [lbl_cnfPassword addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LCP(200)]" options:0 metrics:nil views:@{@"LCP":lbl_cnfPassword}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-230-[LCP]" options:0 metrics:nil views:@{@"LCP":lbl_cnfPassword}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[LCP]" options:0 metrics:nil views:@{@"LCP":lbl_cnfPassword}]];
    
    txt_cnfPassword = [UITextField new];
    [txt_cnfPassword setFont:[UIFont systemFontOfSize:15]];
    [txt_cnfPassword setTextColor:[UIColor blackColor]];
    txt_cnfPassword.delegate = self;
    [txt_cnfPassword setBackgroundColor:[UIColor colorWithRed:0.93 green:1.00 blue:1.00 alpha:1.0]];
    txt_cnfPassword.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:txt_cnfPassword];
    
    [txt_cnfPassword addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[TCP(30)]" options:0 metrics:nil views:@{@"TCP":txt_cnfPassword}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-260-[TCP]" options:0 metrics:nil views:@{@"TCP":txt_cnfPassword}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:txt_cnfPassword
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-30.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:txt_cnfPassword
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];



    lbl_place = [UILabel new];
    [lbl_place setText:@"Place(*)"];
    [lbl_place setFont:[UIFont systemFontOfSize:15]];
    [lbl_place setTextColor:[UIColor blackColor]];
    [lbl_place setTextAlignment:NSTextAlignmentLeft];
    lbl_place.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_place];
    
    [lbl_place addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LPL(20)]" options:0 metrics:nil views:@{@"LPL":lbl_place}]];
    [lbl_place addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LPL(200)]" options:0 metrics:nil views:@{@"LPL":lbl_place}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-300-[LPL]" options:0 metrics:nil views:@{@"LPL":lbl_place}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[LPL]" options:0 metrics:nil views:@{@"LPL":lbl_place}]];

    txt_place = [UITextField new];
    [txt_place setFont:[UIFont systemFontOfSize:15]];
    [txt_place setTextColor:[UIColor blackColor]];
    txt_place.delegate = self;
    [txt_place setBackgroundColor:[UIColor colorWithRed:0.93 green:1.00 blue:1.00 alpha:1.0]];
    txt_place.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:txt_place];
    
    [txt_place addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[TPL(30)]" options:0 metrics:nil views:@{@"TPL":txt_place}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-330-[TPL]" options:0 metrics:nil views:@{@"TPL":txt_place}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:txt_place
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-30.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:txt_place
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    lbl_mobno = [UILabel new];
    [lbl_mobno setText:@"Mobile Number(*)"];
    [lbl_mobno setFont:[UIFont systemFontOfSize:15]];
    [lbl_mobno setTextColor:[UIColor blackColor]];
    [lbl_mobno setTextAlignment:NSTextAlignmentLeft];
    lbl_mobno.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_mobno];
    
    [lbl_mobno addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LM(20)]" options:0 metrics:nil views:@{@"LM":lbl_mobno}]];
    [lbl_mobno addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LM(200)]" options:0 metrics:nil views:@{@"LM":lbl_mobno}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-370-[LM]" options:0 metrics:nil views:@{@"LM":lbl_mobno}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[LM]" options:0 metrics:nil views:@{@"LM":lbl_mobno}]];
    

    txt_mobno = [UITextField new];
    [txt_mobno setFont:[UIFont systemFontOfSize:15]];
    [txt_mobno setTextColor:[UIColor blackColor]];
    txt_mobno.delegate = self;
    [txt_mobno setBackgroundColor:[UIColor colorWithRed:0.93 green:1.00 blue:1.00 alpha:1.0]];
    txt_mobno.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:txt_mobno];
    
    [txt_mobno addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[TM(30)]" options:0 metrics:nil views:@{@"TM":txt_mobno}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-400-[TM]" options:0 metrics:nil views:@{@"TM":txt_mobno}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:txt_mobno
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-30.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:txt_mobno
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    lbl_agre = [UILabel new];
    [lbl_agre setText:@"I agree to the"];
    [lbl_agre setFont:[UIFont boldSystemFontOfSize:12]];
    [lbl_agre setTextAlignment:NSTextAlignmentLeft];
    [lbl_agre setTextColor:[UIColor colorWithRed:0.00 green:1.00 blue:0.00 alpha:1.0]];
    lbl_agre.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_agre];
    
    [lbl_agre addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LA(20)]" options:0 metrics:nil views:@{@"LA":lbl_agre}]];
    [lbl_agre addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LA(80)]" options:0 metrics:nil views:@{@"LA":lbl_agre}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-445-[LA]" options:0 metrics:nil views:@{@"LA":lbl_agre}]];
    //[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[LA]" options:0 metrics:nil views:@{@"LA":lbl_agre}]];
    
    lbl_cntpolicy = [UILabel new];
    [lbl_cntpolicy setFont:[UIFont boldSystemFontOfSize:15]];
    [lbl_cntpolicy setTextAlignment:NSTextAlignmentLeft];
    [lbl_cntpolicy setTextColor:[UIColor colorWithRed:0.00 green:1.00 blue:0.00 alpha:1.0]];
    NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    lbl_cntpolicy.attributedText = [[NSAttributedString alloc] initWithString:@"Content Policy"
                                                                   attributes:underlineAttribute];
    [lbl_cntpolicy setTextColor:[UIColor blackColor]];
    lbl_cntpolicy.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_cntpolicy];
    
    [lbl_cntpolicy addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[CP(20)]" options:0 metrics:nil views:@{@"CP":lbl_cntpolicy}]];
    [lbl_cntpolicy addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[CP(105)]" options:0 metrics:nil views:@{@"CP":lbl_cntpolicy}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-445-[CP]" options:0 metrics:nil views:@{@"CP":lbl_cntpolicy}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_agre attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:lbl_cntpolicy attribute:NSLayoutAttributeLeft multiplier:1.0 constant:(0)]];
    
    
    
    lbl_coma = [UILabel new];
    [lbl_coma setText:@","];
    [lbl_coma setFont:[UIFont boldSystemFontOfSize:15]];
    [lbl_coma setTextAlignment:NSTextAlignmentCenter];
    [lbl_coma setTextColor:[UIColor colorWithRed:0.00 green:1.00 blue:0.00 alpha:1.0]];
    lbl_coma.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_coma];
    
    [lbl_coma addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[CO(20)]" options:0 metrics:nil views:@{@"CO":lbl_coma}]];
    [lbl_coma addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[CO(5)]" options:0 metrics:nil views:@{@"CO":lbl_coma}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-445-[CO]" options:0 metrics:nil views:@{@"CO":lbl_coma}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_coma
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_cntpolicy attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:lbl_coma attribute:NSLayoutAttributeLeft multiplier:1.0 constant:(0)]];
    
    
    lbl_termCondi = [UILabel new];
    [lbl_termCondi setFont:[UIFont boldSystemFontOfSize:15]];
    [lbl_termCondi setTextAlignment:NSTextAlignmentCenter];
    [lbl_termCondi setTextColor:[UIColor blackColor]];
    
    NSDictionary *termsAndCondition = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    lbl_termCondi.attributedText = [[NSAttributedString alloc] initWithString:@"Terms & Conditions"
                                                                   attributes:termsAndCondition];
    lbl_termCondi.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_termCondi];
    
    [lbl_termCondi addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[TC(20)]" options:0 metrics:nil views:@{@"TC":lbl_termCondi}]];
    [lbl_termCondi addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[TC(142)]" options:0 metrics:nil views:@{@"TC":lbl_termCondi}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-445-[TC]" options:0 metrics:nil views:@{@"TC":lbl_termCondi}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_termCondi attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:lbl_coma attribute:NSLayoutAttributeRight multiplier:1.0 constant:(0)]];
    
    lbl_and = [UILabel new];
    [lbl_and setText:@"and"];
    [lbl_and setFont:[UIFont boldSystemFontOfSize:12]];
    [lbl_and setTextAlignment:NSTextAlignmentLeft];
    [lbl_and setTextColor:[UIColor colorWithRed:0.00 green:1.00 blue:0.00 alpha:1.0]];
    //[lbl_and setBackgroundColor:[UIColor whiteColor]];
    lbl_and.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_and];
    
    [lbl_and addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LAN(20)]" options:0 metrics:nil views:@{@"LAN":lbl_and}]];
    [lbl_and addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LAN(30)]" options:0 metrics:nil views:@{@"LAN":lbl_and}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-445-[LAN]" options:0 metrics:nil views:@{@"LAN":lbl_and}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_and attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:lbl_termCondi attribute:NSLayoutAttributeRight multiplier:1.0 constant:(5)]];
    
    lbl_privacy = [UILabel new];
    [lbl_privacy setFont:[UIFont boldSystemFontOfSize:15]];
    [lbl_privacy setTextAlignment:NSTextAlignmentLeft];
    [lbl_privacy setTextColor:[UIColor blackColor]];
    //[lbl_privacy setBackgroundColor:[UIColor whiteColor]];
    NSDictionary * privacyContent = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    lbl_privacy.attributedText = [[NSAttributedString alloc] initWithString:@"Privacy Policy"
                                                                 attributes:privacyContent];
    lbl_privacy.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_privacy];
    
    [lbl_privacy addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LPR(20)]" options:0 metrics:nil views:@{@"LPR":lbl_privacy}]];
    [lbl_privacy addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LPR(100)]" options:0 metrics:nil views:@{@"LPR":lbl_privacy}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-465-[LPR]" options:0 metrics:nil views:@{@"LPR":lbl_privacy}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_privacy
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    btn_sumit = [UIButton new];
    [btn_sumit setTitle:@"Submit" forState:UIControlStateNormal];
    [btn_sumit setBackgroundColor:[UIColor colorWithRed:0.38 green:0.38 blue:0.75 alpha:1.0]];
    [btn_sumit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn_sumit.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:btn_sumit];
    
    [btn_sumit addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BS(30)]" options:0 metrics:nil views:@{@"BS":btn_sumit}]];
    [btn_sumit addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[BS(100)]" options:0 metrics:nil views:@{@"BS":btn_sumit}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-495-[BS]" options:0 metrics:nil views:@{@"BS":btn_sumit}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:btn_sumit
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];

    [self layoutIfNeeded];
    
     [self setContentSize:CGSizeMake(rect.size.width, 535)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardBecomesVisible:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardBecomesHidden:) name:UIKeyboardDidHideNotification object:nil];
    _Underline = [[CAShapeLayer alloc] init];
    [_Underline setLineWidth:1.0f];
    [_Underline setFillColor:[UIColor colorWithRed:0.00 green:1.00 blue:1.00 alpha:1.0].CGColor];


   
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) setTVScrolledForDataEntry
{
    //NSLog(@"starting tv scroll for data entry");
    CGRect l_inputfieldbounds = [_activeTxtFldOrVw convertRect:_activeTxtFldOrVw.bounds toView:self];
    //NSLog(@"the input file bound is %@",NSStringFromCGRect(l_inputfieldbounds));
    CGRect l_superbounds = self.superview.bounds;
    if ((l_inputfieldbounds.origin.y+l_inputfieldbounds.size.height+10.0)>(l_superbounds.size.height- _keyBoardSize.height))
    {
        CGFloat l_offsetheight = (l_inputfieldbounds.origin.y+l_inputfieldbounds.size.height) - (l_superbounds.size.height-_keyBoardSize.height)+10.0;
        [UIView
         animateWithDuration:0.2
         animations:^{
             [self setContentOffset:CGPointMake(0, self.contentOffset.y+ l_offsetheight)];
             // NSLog(@"setting tv scroll for data entry %f", l_offsetheight);
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
        [txt_password becomeFirstResponder];
    }
    else if ([textField isEqual:txt_password])
    {
        [txt_cnfPassword becomeFirstResponder];
    }
    else if ([textField isEqual:txt_cnfPassword])
    {
        [txt_place becomeFirstResponder];
    }
    else if ([textField isEqual:txt_place])
    {
        [txt_mobno becomeFirstResponder];
    }
    else
        [textField resignFirstResponder];
    return YES;
}

@end
