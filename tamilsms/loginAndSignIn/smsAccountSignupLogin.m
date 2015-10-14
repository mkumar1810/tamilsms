//
//  smsAccountSignupLogin.m
//  tamilsms
//
//  Created by Mohan Kumar on 01/10/15.
//  Copyright © 2015 arun benjamin. All rights reserved.
//

#import "smsAccountSignupLogin.h"
#import "registrationNewUser.h"
#import "smsBaseNavigationSegue.h"


@interface smsAccountSignupLogin()<UITextFieldDelegate>
{
    UILabel * lbl_login, *lbl_username, *lbl_password, *lbl_wrongIndi, *lbl_agre, *lbl_cntpolicy, *lbl_coma, *lbl_termCondi, *lbl_and, *lbl_privacy;
    UITextField * txt_username, *txt_pasword;
    UIButton *but_login, *but_changPass, *but_newAcc;
    UIView * _activeTxtFldOrVw;
    CGSize _keyBoardSize;

    
}
@property (nonatomic,strong) registrationNewUser * registrationNewUserV;
@end

@implementation smsAccountSignupLogin

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
    lbl_login = [UILabel new];
    [lbl_login setText:@"Login / Signup to upload your own Message and Images"];
    [lbl_login setFont:[UIFont boldSystemFontOfSize:18]];
    [lbl_login setNumberOfLines:0];
    //[lbl_login setBackgroundColor:[UIColor grayColor]];
    [lbl_login setTextAlignment:NSTextAlignmentCenter];
    [lbl_login setTextColor:[UIColor colorWithRed:0.00 green:1.00 blue:0.00 alpha:1.0]];
    lbl_login.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_login];
    
    [lbl_login addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LB(50)]" options:0 metrics:nil views:@{@"LB":lbl_login}]];
    [lbl_login addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LB(300)]" options:0 metrics:nil views:@{@"LB":lbl_login}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[LB]" options:0 metrics:nil views:@{@"LB":lbl_login}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_login
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];

    
    lbl_username = [UILabel new];
    [lbl_username setText:@"User Name(*)"];
    [lbl_username setFont:[UIFont boldSystemFontOfSize:15]];
    [lbl_username setTextAlignment:NSTextAlignmentLeft];
    [lbl_username setTextColor:[UIColor whiteColor]];
    //[lbl_username setBackgroundColor:[UIColor grayColor]];
    lbl_username.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_username];
    
    [lbl_username addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LU(30)]" options:0 metrics:nil views:@{@"LU":lbl_username}]];
    [lbl_username addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LU(150)]" options:0 metrics:nil views:@{@"LU":lbl_username}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-60-[LU]" options:0 metrics:nil views:@{@"LU":lbl_username}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[LU]" options:0 metrics:nil views:@{@"LU":lbl_username}]];
    
    txt_username = [UITextField new];
    [txt_username setTextColor:[UIColor blackColor]];
    txt_username.delegate = self;
    [txt_username setBackgroundColor:[UIColor whiteColor]];
    txt_username.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:txt_username];
    
    [txt_username addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[TU(30)]" options:0 metrics:nil views:@{@"TU":txt_username}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-90-[TU]" options:0 metrics:nil views:@{@"TU":txt_username}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[TU]" options:0 metrics:nil views:@{@"TU":txt_username}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:txt_username
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                     toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                     multiplier:1.0
                                                     constant:-20.0]];
    
    lbl_password = [UILabel new];
    [lbl_password setText:@"Password(*)"];
    [lbl_password setFont:[UIFont boldSystemFontOfSize:15]];
    [lbl_password setTextAlignment:NSTextAlignmentLeft];
    [lbl_password setTextColor:[UIColor whiteColor]];
    lbl_password.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_password];
    
    [lbl_password addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LU(30)]" options:0 metrics:nil views:@{@"LU":lbl_password}]];
    [lbl_password addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LU(150)]" options:0 metrics:nil views:@{@"LU":lbl_password}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-120-[LU]" options:0 metrics:nil views:@{@"LU":lbl_password}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[LU]" options:0 metrics:nil views:@{@"LU":lbl_password}]];
    
    
    txt_pasword = [UITextField new];
    [txt_pasword setTextColor:[UIColor blackColor]];
    txt_pasword.delegate = self;
    [txt_pasword setBackgroundColor:[UIColor whiteColor]];
    txt_pasword.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:txt_pasword];
    
    [txt_pasword addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[TP(30)]" options:0 metrics:nil views:@{@"TP":txt_pasword}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-160-[TP]" options:0 metrics:nil views:@{@"TP":txt_pasword}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[TP]" options:0 metrics:nil views:@{@"TP":txt_pasword}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:txt_pasword
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-20.0]];
    
    lbl_wrongIndi = [UILabel new];
    [lbl_wrongIndi setText:@"null indication"];
    [lbl_wrongIndi setFont:[UIFont boldSystemFontOfSize:15]];
    [lbl_wrongIndi setTextAlignment:NSTextAlignmentLeft];
    [lbl_wrongIndi setTextColor:[UIColor colorWithRed:0.00 green:1.00 blue:0.00 alpha:1.0]];
    lbl_wrongIndi.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_wrongIndi];
    
    [lbl_wrongIndi addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LW(20)]" options:0 metrics:nil views:@{@"LW":lbl_wrongIndi}]];
    [lbl_wrongIndi addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LW(150)]" options:0 metrics:nil views:@{@"LW":lbl_wrongIndi}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-190-[LW]" options:0 metrics:nil views:@{@"LW":lbl_wrongIndi}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[LW]" options:0 metrics:nil views:@{@"LW":lbl_wrongIndi}]];
    
    but_login = [UIButton new];
    [but_login setBackgroundColor:[UIColor whiteColor]];
    [but_login setTitle:@"Login" forState:UIControlStateNormal];
    [but_login setTitleColor:[UIColor colorWithRed:0.29 green:0.53 blue:0.91 alpha:1.0] forState:UIControlStateNormal];
    but_login.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:but_login];
    
    [but_login addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BL(30)]" options:0 metrics:nil views:@{@"BL":but_login}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-210-[BL]" options:0 metrics:nil views:@{@"BL":but_login}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[BL]" options:0 metrics:nil views:@{@"BL":but_login}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:but_login
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-20.0]];


    but_changPass = [UIButton new];
    [but_changPass setBackgroundColor:[UIColor whiteColor]];
    [but_changPass setTitle:@"Forget / Change Password" forState:UIControlStateNormal];
    [but_changPass setTitleColor:[UIColor colorWithRed:0.29 green:0.53 blue:0.91 alpha:1.0] forState:UIControlStateNormal];
    but_changPass.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:but_changPass];
    
    [but_changPass addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BC(30)]" options:0 metrics:nil views:@{@"BC":but_changPass}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-250-[BC]" options:0 metrics:nil views:@{@"BC":but_changPass}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[BC]" options:0 metrics:nil views:@{@"BC":but_changPass}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:but_changPass
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-20.0]];
    
    but_newAcc = [UIButton new];
    [but_newAcc setBackgroundColor:[UIColor whiteColor]];
    [but_newAcc setTitle:@"Register New Account" forState:UIControlStateNormal];
    [but_newAcc setTitleColor:[UIColor colorWithRed:0.29 green:0.53 blue:0.91 alpha:1.0] forState:UIControlStateNormal];
    [but_newAcc addTarget:self action:@selector(registrationForm:)forControlEvents:UIControlEventTouchUpInside];
    but_newAcc.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:but_newAcc];
    
    [but_newAcc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BN(30)]" options:0 metrics:nil views:@{@"BN":but_newAcc}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-290-[BN]" options:0 metrics:nil views:@{@"BN":but_newAcc}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[BN]" options:0 metrics:nil views:@{@"BN":but_newAcc}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:but_newAcc
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-20.0]];
    
    lbl_agre = [UILabel new];
    [lbl_agre setText:@"I agree to the"];
    [lbl_agre setFont:[UIFont boldSystemFontOfSize:12]];
    [lbl_agre setTextAlignment:NSTextAlignmentLeft];
    [lbl_agre setTextColor:[UIColor colorWithRed:0.00 green:1.00 blue:0.00 alpha:1.0]];
    lbl_agre.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_agre];
    
    [lbl_agre addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LA(20)]" options:0 metrics:nil views:@{@"LA":lbl_agre}]];
    [lbl_agre addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LA(80)]" options:0 metrics:nil views:@{@"LA":lbl_agre}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-340-[LA]" options:0 metrics:nil views:@{@"LA":lbl_agre}]];
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
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-340-[CP]" options:0 metrics:nil views:@{@"CP":lbl_cntpolicy}]];
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
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-340-[CO]" options:0 metrics:nil views:@{@"CO":lbl_coma}]];
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
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-340-[TC]" options:0 metrics:nil views:@{@"TC":lbl_termCondi}]];
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
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-340-[LAN]" options:0 metrics:nil views:@{@"LAN":lbl_and}]];
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
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-360-[LPR]" options:0 metrics:nil views:@{@"LPR":lbl_privacy}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_privacy
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    [self layoutIfNeeded];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardBecomesVisible:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardBecomesHidden:) name:UIKeyboardDidHideNotification object:nil];
    [self setContentSize:CGSizeMake(rect.size.width, 445)];
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
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:txt_username])
    {
        [txt_pasword becomeFirstResponder];
    }
    else if ([textField isEqual:txt_pasword])
    {
        [textField resignFirstResponder];;
    }
    return YES;
}

-(void)registrationForm:(UIButton*)button
{
    //NSLog(@"button clicked");
    [self.signUpLoginDelegate invokeSignUpScreen];
   
}
@end
