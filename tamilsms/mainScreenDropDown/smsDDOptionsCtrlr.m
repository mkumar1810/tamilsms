//
//  smsDDOptionsCtrlr.m
//  tamilsms
//
//  Created by Mohan Kumar on 07/10/15.
//  Copyright © 2015 arun benjamin. All rights reserved.
//

#import "smsDDOptionsCtrlr.h"
#import "smsSettingsScreen.h"
#import "smsFeedbackScreen.h"
#import "smsInfoSettingsScreen.h"
#import "registrationNewUser.h"

@interface smsDDOptionsCtrlr ()
{
    NSString * _opselected;
}

@property (nonatomic,strong) smsSettingsScreen * fontSizeChangeVw;
@property (nonatomic,strong) smsFeedbackScreen * smsFeedbackScreenV;
@property (nonatomic,strong) smsInfoSettingsScreen * smsInfoSettingsScreenV;
@property (nonatomic,strong) registrationNewUser * registrationNewUserV;

@end

@implementation smsDDOptionsCtrlr

- (void)awakeFromNib
{
    self.transitionType = vertical;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navBar setHidden:NO];
    self.navItem.leftBarButtonItems = [NSArray arrayWithObjects:self.bar_back_btn, self.bar_logo_btn, self.bar_prev_title_btn,nil];
    //self.navItem.rightBarButtonItems = [NSArray arrayWithObjects:self.bar_list_btn,nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeDataWithParams:(NSDictionary *)p_initParams
{
    _opselected = [p_initParams valueForKey:@"opselected"];
     if ([_opselected isEqualToString:@"Settings"])
     {
         [self showSettingsScreen];
     }
     
     if ([_opselected isEqualToString:@"Feedback"])
     {
         [self showFeedbackScreen];
         
     }
     
     if ([_opselected isEqualToString:@"Info"])
     {
         [self showInfoScreen];
     }

    if ([_opselected isEqualToString:@"signup"])
    {
        [self showSignUpScreen];
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) showSignUpScreen
{
    self.registrationNewUserV = [registrationNewUser new];
     //[self.smsAccountSignupLoginSV setBackgroundColor:[UIColor whiteColor]];
     [self.view addSubview:self.registrationNewUserV];
     self.registrationNewUserV.translatesAutoresizingMaskIntoConstraints = NO;
     [self.view bringSubviewToFront:self.registrationNewUserV];
     
     [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:self.registrationNewUserV attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.registrationNewUserV attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.registrationNewUserV attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:32],[NSLayoutConstraint constraintWithItem:self.registrationNewUserV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:(-64)]]];
    
}

- (void)showSettingsScreen
{
    self.fontSizeChangeVw = [smsSettingsScreen new];
    
    [self.fontSizeChangeVw setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.fontSizeChangeVw];
    self.fontSizeChangeVw.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view bringSubviewToFront:self.fontSizeChangeVw];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:self.fontSizeChangeVw attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.fontSizeChangeVw attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.fontSizeChangeVw attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:32],[NSLayoutConstraint constraintWithItem:self.fontSizeChangeVw attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:(-64)]]];
    [self.view layoutIfNeeded];
    
}

- (void)showFeedbackScreen
{
    self.smsFeedbackScreenV = [smsFeedbackScreen new];
    
    [self.smsFeedbackScreenV setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.smsFeedbackScreenV];
    self.smsFeedbackScreenV.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view bringSubviewToFront:self.smsFeedbackScreenV];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:self.smsFeedbackScreenV attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.smsFeedbackScreenV attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.smsFeedbackScreenV attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:32],[NSLayoutConstraint constraintWithItem:self.smsFeedbackScreenV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:(-64)]]];
    
    // NSLog(@"the font seting frame is %@",NSStringFromCGRect(self.smsFontSizeChangeV.frame));
    self.smsFeedbackScreenV.transform = CGAffineTransformMakeScale(0.5, 0.5);
    self.smsFeedbackScreenV.alpha = 0.3;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.2
                     animations:^(){
                         self.smsFeedbackScreenV.alpha = 1;
                         self.smsFeedbackScreenV.transform = CGAffineTransformIdentity;
                     }];
    
    
}

- (void)showInfoScreen
{
    self.smsInfoSettingsScreenV = [smsInfoSettingsScreen new];
    
    [self.smsInfoSettingsScreenV setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.smsInfoSettingsScreenV];
    self.smsInfoSettingsScreenV.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view bringSubviewToFront:self.smsInfoSettingsScreenV];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:self.smsInfoSettingsScreenV attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.smsInfoSettingsScreenV attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.smsInfoSettingsScreenV attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:32],[NSLayoutConstraint constraintWithItem:self.smsInfoSettingsScreenV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:(-64)]]];
    
    // NSLog(@"the font seting frame is %@",NSStringFromCGRect(self.smsFontSizeChangeV.frame));
    self.smsInfoSettingsScreenV.transform = CGAffineTransformMakeScale(0.5, 0.5);
    self.smsInfoSettingsScreenV.alpha = 0.3;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.2
                     animations:^(){
                         self.smsInfoSettingsScreenV.alpha = 1;
                         self.smsInfoSettingsScreenV.transform = CGAffineTransformIdentity;
                     }];
    
    
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    if (self.fontSizeChangeVw)
    {
        [self.fontSizeChangeVw updateConstraints];
    }

}

@end
