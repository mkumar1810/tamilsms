//
//  smsDDOptionsCtrlr.m
//  tamilsms
//
//  Created by Mohan Kumar on 07/10/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import "smsDDOptionsCtrlr.h"
#import "smsSettingsScreen.h"
#import "smsFeedbackScreen.h"
#import "smsInfoSettingsScreen.h"
#import "registrationNewUser.h"
#import "smsImageMsgPosting.h"
#import "smsTextMsgPosting.h"

@interface smsDDOptionsCtrlr ()<registerNewUserDelegates, UIImagePickerControllerDelegate, UINavigationControllerDelegate, imagePostingAlbumDelegate, smsTextMsgPostDelegate, smsInfoSettingsDelegate>
{
    NSString * _opselected;
}

@property (nonatomic,strong) smsSettingsScreen * fontSizeChangeVw;
@property (nonatomic,strong) smsFeedbackScreen * smsFeedbackScreenV;
@property (nonatomic,strong) smsInfoSettingsScreen * smsInfoSettingsScreenV;
@property (nonatomic,strong) registrationNewUser * registrationNewUserV;
@property (nonatomic,strong) smsTextMsgPosting * smsTextMsgPostingSV;
@property (nonatomic,strong) smsImageMsgPosting * smsImageMsgPostingSV;

@end

@implementation smsDDOptionsCtrlr

- (void)awakeFromNib
{
    self.transitionType = vertical;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navBar setHidden:NO];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:self.bar_back_btn, self.bar_logo_btn, nil];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
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
        [self.navigationItem setTitle:@"Sign Up"];
        [self showSignUpScreen];
    }
    if ([_opselected isEqualToString:@"posttxtmsg"])
    {
        //
        [self showtxtmessagepostscreen];
        self.smsTextMsgPostingSV.txtMsgDelegate = self;
        [self.navigationItem setTitle:@"Text SMS"];
    }
    
    if ([_opselected isEqualToString:@"postimgtmsg"])
    {
        //
        [self showimgmessagepostscreen];
        [self.navigationItem setTitle:@"Image SMS"];
    }

}

-(void)showtxtmessagepostscreen
{
    
    self.smsTextMsgPostingSV = [smsTextMsgPosting new];
    //self.dropDwnOptions.optionsDelegate = self;
    [self.view addSubview:self.smsTextMsgPostingSV];
    [self.smsTextMsgPostingSV setBackgroundColor:[UIColor whiteColor]];
    self.smsTextMsgPostingSV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view bringSubviewToFront:self.smsTextMsgPostingSV];
    
    // Width constraint,
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.smsTextMsgPostingSV
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual toItem:self.view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0 constant:0]];
    
    
    // Height constraint,
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.smsTextMsgPostingSV
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:(-64-49)]];
    
    // Center horizontally
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.smsTextMsgPostingSV
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    // Center vertically
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.smsTextMsgPostingSV
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:(32-49.0/2.0)]];
}

-(void)showimgmessagepostscreen
{
    self.smsImageMsgPostingSV = [smsImageMsgPosting new];
    //self.dropDwnOptions.optionsDelegate = self;
    self.smsImageMsgPostingSV.imageAlbumDelegate = self;
    
    [self.view addSubview:self.smsImageMsgPostingSV];
    [self.smsImageMsgPostingSV setBackgroundColor:[UIColor whiteColor]];
    self.smsImageMsgPostingSV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view bringSubviewToFront:self.smsImageMsgPostingSV];
    
    // Width constraint,
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.smsImageMsgPostingSV
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual toItem:self.view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0 constant:0]];
    
    
    // Height constraint,
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.smsImageMsgPostingSV
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:-150]];
    
    // Center horizontally
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.smsImageMsgPostingSV
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    // Center vertically
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.smsImageMsgPostingSV
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0]];
    
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
    self.registrationNewUserV.userDelegate = self;
     self.registrationNewUserV.translatesAutoresizingMaskIntoConstraints = NO;
     [self.view bringSubviewToFront:self.registrationNewUserV];
     
     [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:self.registrationNewUserV attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.registrationNewUserV attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.registrationNewUserV attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:(32-49.0/2.0)],[NSLayoutConstraint constraintWithItem:self.registrationNewUserV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:(-64-49)]]];
    
}

- (void)showSettingsScreen
{
    self.fontSizeChangeVw = [smsSettingsScreen new];
    
    [self.fontSizeChangeVw setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.fontSizeChangeVw];
    self.fontSizeChangeVw.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view bringSubviewToFront:self.fontSizeChangeVw];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:self.fontSizeChangeVw attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.fontSizeChangeVw attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.fontSizeChangeVw attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:(32-49.0/2.0)],[NSLayoutConstraint constraintWithItem:self.fontSizeChangeVw attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:(-64-49)]]];
    [self.view layoutIfNeeded];
    [self.navigationItem setTitle:@"Settings"];
    
}

- (void)showFeedbackScreen
{
    self.smsFeedbackScreenV = [smsFeedbackScreen new];
    
    [self.smsFeedbackScreenV setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.smsFeedbackScreenV];
    self.smsFeedbackScreenV.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view bringSubviewToFront:self.smsFeedbackScreenV];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:self.smsFeedbackScreenV attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.smsFeedbackScreenV attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.smsFeedbackScreenV attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:(32-49.0/2.0)],[NSLayoutConstraint constraintWithItem:self.smsFeedbackScreenV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:(-64-49)]]];
    
    // NSLog(@"the font seting frame is %@",NSStringFromCGRect(self.smsFontSizeChangeV.frame));
    self.smsFeedbackScreenV.transform = CGAffineTransformMakeScale(0.5, 0.5);
    self.smsFeedbackScreenV.alpha = 0.3;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.2
                     animations:^(){
                         self.smsFeedbackScreenV.alpha = 1;
                         self.smsFeedbackScreenV.transform = CGAffineTransformIdentity;
                     }];
    [self.navigationItem setTitle:@"Feedback"];
    
    
}

- (void)showInfoScreen
{
    self.smsInfoSettingsScreenV = [smsInfoSettingsScreen new];
    self.smsInfoSettingsScreenV.infoSetDelegate = self;
    [self.smsInfoSettingsScreenV setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.smsInfoSettingsScreenV];
    self.smsInfoSettingsScreenV.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view bringSubviewToFront:self.smsInfoSettingsScreenV];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:self.smsInfoSettingsScreenV attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.smsInfoSettingsScreenV attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.smsInfoSettingsScreenV attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:(32-49.0/2.0)],[NSLayoutConstraint constraintWithItem:self.smsInfoSettingsScreenV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:(-64-49)]]];
    
    // NSLog(@"the font seting frame is %@",NSStringFromCGRect(self.smsFontSizeChangeV.frame));
    self.smsInfoSettingsScreenV.transform = CGAffineTransformMakeScale(0.5, 0.5);
    self.smsInfoSettingsScreenV.alpha = 0.3;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.2
                     animations:^(){
                         self.smsInfoSettingsScreenV.alpha = 1;
                         self.smsInfoSettingsScreenV.transform = CGAffineTransformIdentity;
                     }];
    [self.navigationItem setTitle:@"Info"];
    
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    if (self.fontSizeChangeVw)
    {
        [self.fontSizeChangeVw updateConstraints];
    }

}

#pragma mark - new user signed up delegates

- (void)newUserSignedUp
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)newUserSignUpCancelled
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - image posting delegates

-(void)delgateForImagefetchingFromAlbum
{
    NSLog(@"button is clicked");
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
}

-(void) imagePostingCompleted
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - image picker delegates

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //You can retrieve the actual UIImage
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    //Or you can get the image url from AssetsLibrary
    //    NSURL *path = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    [picker dismissViewControllerAnimated:YES
                               completion:^{
                                   [self.smsImageMsgPostingSV setCapturedImage:image];
                               }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - text message posting related delegates

- (void) textMsgPostedSuccessfully
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - app settings and feedback screen delegates

- (void)showAppSettingsScreen
{
    self.navigateParams = @{@"opselected":@"Settings"};
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"showinfofeedbackscreen" sender:self];
    });
}

- (void)showAppFeedBackScreen
{
    self.navigateParams = @{@"opselected":@"Feedback"};
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"showinfofeedbackscreen" sender:self];
    });
}

@end
