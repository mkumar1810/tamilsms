//
//  smsBaseController.m
//  tamilsms
//
//  Created by arun benjamin on 10/09/15.
//  Copyright (c) 2015 arun benjamin. All rights reserved.
//

#import "smsBaseController.h"

@interface smsBaseController ()
{
    UIImageView * _tamilsmslogo;
    //UILabel * _appname;
}

@end


@implementation smsBaseController

@synthesize transitionType;
@synthesize navigateParams;
@synthesize hideStatusBar;

- (instancetype)init
{
    self = [super init];
    if (self) {
        //self.transitionType = noanimation;
        //
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigationBarItems];
    // Do any additional setup after loading the view from its nib.
}

- (void) setupNavigationBarItems
{
    self.navBar = [UINavigationBar new];
    self.navBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.navBar];
    
    self.navBar.translucent = YES;
    [self.navBar setShadowImage:[[UIImage alloc] init]];
    //[self.navBar setBarTintColor:[UIColor colorWithWhite:0.84 alpha:0.90]];
    //[self.navBar setBarTintColor:[UIColor colorWithRed:0.42 green:0.56 blue:0.78 alpha:0.90]];
    [self.navBar setTintColor:[UIColor whiteColor]];
    [self.navBar setBarTintColor:[UIColor blackColor]];
    [self.navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navBar.layer.masksToBounds = NO;
    self.navBar.layer.shadowOffset = CGSizeMake(0, -5);
    self.navBar.layer.shadowRadius = 6;
    self.navBar.layer.shadowOpacity = 0.4;
    
    self.navItem = [UINavigationItem new];
    self.navBar.items = @[self.navItem];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.navBar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    [self.navBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[navbar(44)]" options:0 metrics:nil views:@{@"navbar":self.navBar}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[navbar]" options:0 metrics:nil views:@{@"navbar":self.navBar}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[navbar]" options:0 metrics:nil views:@{@"navbar":self.navBar}]];
    [self.navBar setHidden:YES];
    
    UIButton * l_backbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20.0, 20.0)];
    //[l_backbtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [l_backbtn setTitle:@"BK" forState:UIControlStateNormal];
    l_backbtn.titleLabel.font =[UIFont systemFontOfSize:10.0f];
    [l_backbtn addTarget:self action:@selector(popBackScreen) forControlEvents:UIControlEventTouchUpInside];
    self.bar_back_btn = [[UIBarButtonItem alloc] initWithCustomView:l_backbtn];
    
    self.lbl_prevtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 45.0)];
    [self.lbl_prevtitle setText:@"Tamil SMS"];
    [self.lbl_prevtitle setTextColor:[UIColor whiteColor]];
    self.lbl_prevtitle.font = [UIFont systemFontOfSize:11.0f];
    self.bar_prev_title_btn = [[UIBarButtonItem alloc] initWithCustomView:self.lbl_prevtitle];
    
    UIButton * l_searchbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20.0, 20.0)];
    [l_searchbtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [l_searchbtn addTarget:self action:@selector(performSearchOperation) forControlEvents:UIControlEventTouchUpInside];
    self.bar_search_btn = [[UIBarButtonItem alloc] initWithCustomView:l_searchbtn];
    
    UIButton * l_logoutbtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 20.0, 20.0)];
    [l_logoutbtn setImage:[UIImage imageNamed:@"logout"] forState:UIControlStateNormal];
    [l_logoutbtn addTarget:self action:@selector(logOutOfTheApplication) forControlEvents:UIControlEventTouchUpInside];
    self.bar_logout_btn = [[UIBarButtonItem alloc] initWithCustomView:l_logoutbtn];
    
    UIButton * l_rptpreviewbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20.0, 20.0)];
    [l_rptpreviewbtn setImage:[UIImage imageNamed:@"printpreview"] forState:UIControlStateNormal];
    [l_rptpreviewbtn addTarget:self action:@selector(generateReportPreview) forControlEvents:UIControlEventTouchUpInside];
    self.bar_report_prev_btn = [[UIBarButtonItem alloc] initWithCustomView:l_rptpreviewbtn];
    
    UIButton * l_printbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,20.0, 20.0)];
    [l_printbtn setImage:[UIImage imageNamed:@"print"] forState:UIControlStateNormal];
    [l_printbtn addTarget:self action:@selector(makePrintOutOfReport) forControlEvents:UIControlEventTouchUpInside];
    self.bar_printout_btn = [[UIBarButtonItem alloc] initWithCustomView:l_printbtn];
    

    
    /*_appname = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 45.0)];
    [_appname setText:@"Tamil SMS"];
    [_appname setTextColor:[UIColor whiteColor]];
    [_appname setFont:[UIFont boldSystemFontOfSize:20]];*/

    _tamilsmslogo = [[UIImageView alloc]init];
    [_tamilsmslogo setFrame:CGRectMake(0, 5.0f, 35, 45.0-10)];
    _tamilsmslogo.image =[UIImage imageNamed:@"app_icon.png"];
    self.bar_logo_btn = [[UIBarButtonItem alloc] initWithCustomView:_tamilsmslogo];
    
    UIButton * l_refreshbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20.0, 20.0)];
    [l_refreshbtn setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [l_refreshbtn addTarget:self action:@selector(initializeData) forControlEvents:UIControlEventTouchUpInside];
    [l_refreshbtn setBackgroundColor:[UIColor clearColor]];
    self.bar_refresh_btn = [[UIBarButtonItem alloc] initWithCustomView:l_refreshbtn];
    
    UIButton * l_savebtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20.0, 20.0)];
    [l_savebtn setImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
    [l_savebtn addTarget:self action:@selector(storeTheDataToDB) forControlEvents:UIControlEventTouchUpInside];
    [l_savebtn setBackgroundColor:[UIColor clearColor]];
    self.bar_save_btn = [[UIBarButtonItem alloc] initWithCustomView:l_savebtn];
    
    UIButton * l_navlistbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25.0, 44.0)];
    [l_navlistbtn setImage:[UIImage imageNamed:@"threepoint.png"] forState:UIControlStateNormal];
    [l_navlistbtn addTarget:self action:@selector(executeListButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [l_navlistbtn setBackgroundColor:[UIColor clearColor]];
    self.bar_list_btn = [[UIBarButtonItem alloc] initWithCustomView:l_navlistbtn];
    
    self.actView = [UIActivityIndicatorView new];
    self.actView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.actView];
    self.actView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.actView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[actview(20)]" options:0 metrics:nil views:@{@"actview":self.actView}]];
    [self.actView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[actview(20)]" options:0 metrics:nil views:@{@"actview":self.actView}]];
    self.actView.transform = CGAffineTransformMakeScale(3.0, 3.0);
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.actView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.actView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void) initializeDataWithParams:(NSDictionary*) p_initParams
{
    
}

- (void)initializeData
{
    
}

- (void) popBackScreen
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) performSearchOperation
{
    
}

- (void) logOutOfTheApplication
{
    NSString * l_userid = [[NSUserDefaults standardUserDefaults] valueForKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] setValue:l_userid forKey:@"lastlogged"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sessionToken"];
    //setValue:[l_recdinfo valueForKey:@"sessionToken"] forKey:@"sessionToken"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
    //setValue:[l_recdinfo valueForKey:@"objectId"] forKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    //setValue:[l_recdinfo valueForKey:@"username"] forKey:@"username"];
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
}

- (void) generateReportPreview
{
    
}

- (void) makePrintOutOfReport
{
    
}

- (void) editOptionPressed
{
    
}

- (void) exitReportPreview
{
    
}

- (void) executeListButtonClicked
{
    
}

- (void) storeTheDataToDB
{
    
}

- (BOOL)prefersStatusBarHidden
{
    return self.hideStatusBar;
}

#pragma navigation delegates custom

- (void)pushAnimation:(TransitionType)p_pushAnimationType
{
    //[self resetIdleTimer];
}

- (void)popAnimation:(TransitionType)p_popAnimationType
{
    //[self resetIdleTimer];
}

- (CGRect) getPopOutFrame
{
    return CGRectZero;
}

- (UIImage*) getPopOutTopImage
{
    return nil;
}

- (UIImage*) getPopOutBottomImage
{
    return nil;
}

- (UIImage*) getPopOutImage
{
    return nil;
}

- (void) popAnimationCompleted
{
    
}

- (void)pushanimationCompleted
{
    
}

- (void) navigationAnimationCompleted
{
    
}

@end
