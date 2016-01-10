//
//  smsBaseHomeController.m
//  tamilsms
//
//  Created by Mohan Kumar on 23/12/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import "smsBaseHomeController.h"
#import "smsLocalStore.h"

@interface smsBaseHomeController ()

@end

@implementation smsBaseHomeController

- (void)awakeFromNib
{
    [smsLocalStore getDBOpened];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

@end
