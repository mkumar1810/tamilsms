//
//  smsImageCategoriesCtrlr.m
//  tamilsms
//
//  Created by Mohan Kumar on 27/12/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import "smsImageCategoriesCtrlr.h"
#import "smsDBAsyncQueueProcess.h"

@interface smsImageCategoriesCtrlr ()
{
    NSArray * _mainCategories;
    UIBarButtonItem * _bar_back_btn;
}

@end

@implementation smsImageCategoriesCtrlr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeData];
    [self.navigationItem setTitle:@"Image Categories"];
    UIButton * l_backbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30.0, 20.0)];
    [l_backbtn setImage:[UIImage imageNamed:@"bckbtn-1"] forState:UIControlStateNormal];
    [l_backbtn addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    _bar_back_btn = [[UIBarButtonItem alloc] initWithCustomView:l_backbtn];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initializeData
{
    [smsDBAsyncQueueProcess getImageCategoryTitles:^(NSArray * p_categoreisList){
        _categoriesList = p_categoreisList;
        //NSLog(@"the cataegory titles%@",_categoryTitles);
        [self.tableView reloadData];
    }];
}

- (void) backButtonPressed
{
    _categoriesList = [_mainCategories copy];
    [self.tableView reloadData];
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationItem setTitle:@"Image categories"];
    _mainCategories = nil;
}

#pragma mark - sms categoreis list delegates handler

-(void)categoryIdClickedForTheCell:(NSInteger)p_positno
{
    NSInteger l_catidi = [[[_categoriesList objectAtIndex:p_positno] valueForKey:@"cid"] integerValue];
    //NSLog(@"the category id is %ld",(long)l_catid);
    
    if (l_catidi <=100)
    {
        NSInteger l_catid = [[[_categoriesList objectAtIndex:p_positno] valueForKey:@"cid"] integerValue];
        self.navigateParams = @{@"categoryid":@(l_catid), @"msgtype":@"image"};
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"showimagemessagesforcategory" sender:self];
        });
    }
    else
    {
//        NSInteger l_catgid = [[[_categoriesList objectAtIndex:p_positno] valueForKey:@"cid"] integerValue];
//        self.navigateParams = @{@"categoryid":@(l_catgid), @"msgtype":@"image"};
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self performSegueWithIdentifier:@"showtextsubcategories" sender:self];
//        });
        _mainCategories = [_categoriesList copy];
        [smsDBAsyncQueueProcess getImageSubCategoryTitles:l_catidi
                                             andrReturnCb:^(NSArray * p_subcategorieslist){
            _categoriesList = p_subcategorieslist;
            [self.tableView reloadData];
        }];
        self.navigationItem.leftBarButtonItem = _bar_back_btn;
        [self.navigationItem setTitle:@"Image Sub categories"];
        
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

@end
