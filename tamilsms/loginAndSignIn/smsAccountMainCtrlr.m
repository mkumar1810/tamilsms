//
//  smsAccountMainCtrlr.m
//  tamilsms
//
//  Created by Mohan Kumar on 06/01/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import "smsAccountMainCtrlr.h"
#import "loginWelcomeScreeen.h"

@interface smsAccountMainCtrlr ()

@property (nonatomic,strong) loginWelcomeScreeen * loginWelcomeScreeenSV;

@end

@implementation smsAccountMainCtrlr

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.navBar setHidden:NO];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:self.bar_logo_btn, nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -  signup and login screen related delegates

-(void)invokeSignUpScreen
{
    self.navigateParams = @{@"opselected":@"signup"};
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"showregisternewuser" sender:self];
    });
}

- (void) postNewTextSMSMessage
{
    
}

- (void) postNewImageSMSMessage
{
    
}

@end
