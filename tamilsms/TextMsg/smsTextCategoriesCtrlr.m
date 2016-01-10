//
//  smsTextCategoriesCtrlr.m
//  tamilsms
//
//  Created by Mohan Kumar on 23/12/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import "smsTextCategoriesCtrlr.h"
#import "smsDBAsyncQueueProcess.h"

@interface smsTextCategoriesCtrlr ()
{
    NSArray * _mainCategories;
    UIBarButtonItem * _bar_back_btn;
}

@end

@implementation smsTextCategoriesCtrlr


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeData];
    [self.navigationItem setTitle:@"Text Categories"];
    
    UIButton * l_backbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30.0, 20.0)];
    [l_backbtn setImage:[UIImage imageNamed:@"bckbtn-1"] forState:UIControlStateNormal];
    [l_backbtn addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    _bar_back_btn = [[UIBarButtonItem alloc] initWithCustomView:l_backbtn];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
}

- (void) initializeData
{
    [smsDBAsyncQueueProcess getTextCategoryTitles:^(NSArray * p_categoreisList){
        _categoriesList = p_categoreisList;
        //NSLog(@"the cataegory titles%@",_categoryTitles);
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) backButtonPressed
{
    _categoriesList = [_mainCategories copy];
    [self.tableView reloadData];
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationItem setTitle:@"Text categories"];
    _mainCategories = nil;
}

#pragma mark - sms categoreis list delegates handler

-(void)categoryIdClickedForTheCell:(NSInteger)p_positno
{
    NSDictionary * l_catdict = [_categoriesList objectAtIndex:p_positno];
    NSInteger l_catidi = [[l_catdict valueForKey:@"cid"] integerValue];
    //NSLog(@"the category id is %ld",(long)l_catid);
    
    if (l_catidi <=100)
    {
        self.navigateParams = @{@"categoryid":@(l_catidi), @"msgtype":@"text",@"category_name":[l_catdict valueForKey:@"category_name"]};
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"showtextmessagesforcategory" sender:self];
        });
    }
    else
    {
//        NSInteger l_catgid = [[[_categoriesList objectAtIndex:p_positno] valueForKey:@"cid"] integerValue];
//        self.navigateParams = @{@"categoryid":@(l_catgid), @"msgtype":@"text"};
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self performSegueWithIdentifier:@"showtextsubcategories" sender:self];
//        });
        _mainCategories = [_categoriesList copy];
        [smsDBAsyncQueueProcess getTextSubCategoryTitles:l_catidi andrReturnCb:^(NSArray * p_subcategorieslist){
            _categoriesList = p_subcategorieslist;
            [self.tableView reloadData];
        }];
        self.navigationItem.leftBarButtonItem = _bar_back_btn;
        [self.navigationItem setTitle:@"Text Sub categories"];
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

