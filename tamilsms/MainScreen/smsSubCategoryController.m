//
//  smsSubCategoryController.m
//  tamilsms
//
//  Created by Mohan Kumar on 13/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import "smsSubCategoryController.h"
#import "smsDBAsyncQueueProcess.h"
#import "SubCategoryList.h"

@interface smsSubCategoryController ()<SubCategoryListDelegate>
{
    NSInteger _categoryid;
    NSString * _msgType;
    NSArray * _txtSubCategoryList;
    NSArray * _imgSubCategoryList;
}

@property(nonatomic,retain) SubCategoryList * subCategoryListTV;

@end

@implementation smsSubCategoryController

- (void)awakeFromNib
{
    self.transitionType = horizontalWithBounce;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navBar setHidden:NO];
    self.navItem.leftBarButtonItems = [NSArray arrayWithObjects: self.bar_back_btn, self.bar_logo_btn, self.bar_prev_title_btn,nil];
    self.navItem.rightBarButtonItems = [NSArray arrayWithObjects:self.bar_list_btn,nil];
    [self setUpMainNavigationSegmentCtrl];

    // Do any additional setup after loading the view.
}

- (void)initializeDataWithParams:(NSDictionary *)p_initParams
{
    _categoryid = [[p_initParams valueForKey:@"categoryid"] integerValue];
    _msgType = [p_initParams valueForKey:@"msgtype"];
    if ([_msgType isEqualToString:@"txt"])
    {
        [smsDBAsyncQueueProcess getTextSubCategoryTitles:_categoryid andrReturnCb:^(NSArray * p_categoreisListMessage){
            _txtSubCategoryList = p_categoreisListMessage;
            //NSLog(@"the category messages is %@",_subCategoryList);
            if (self.subCategoryListTV)
            {
                [self.subCategoryListTV reloadCategoriesList];
            }
        }];
    }
    else
    {
        [smsDBAsyncQueueProcess getImageSubCategoryTitles:_categoryid andrReturnCb:^(NSArray * p_categoreisListMessage){
            _imgSubCategoryList = p_categoreisListMessage;
            //NSLog(@"the category messages is %@",_subCategoryList);
            if (self.subCategoryListTV)
            {
                [self.subCategoryListTV reloadCategoriesList];
            }
        }];
    }
}

-(void)setUpMainNavigationSegmentCtrl
{
    
    self.subCategoryListTV = [SubCategoryList new];
    self.subCategoryListTV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.subCategoryListTV];
    //[self.subCategoryListTV setHidden:YES];
    self.subCategoryListTV.SubCategoryadelegate = self;
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:self.subCategoryListTV attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0],[NSLayoutConstraint constraintWithItem:self.subCategoryListTV attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0],[NSLayoutConstraint constraintWithItem:self.subCategoryListTV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:(-64.0)]]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[cl]" options:0 metrics:nil views:@{ @"cl":self.subCategoryListTV}]];
    [self.view layoutIfNeeded];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)getMessageSubCategoryCount;
{
    //NSInteger nocount = [_categorymessages count];
    //NSLog(@"the category msg count is %ld",(long)nocount);
    if ([_msgType isEqualToString:@"txt"])
        return [_txtSubCategoryList count];
    else
        return [_imgSubCategoryList count];
}

-(NSDictionary*) getSubCategoryListFromArray:(NSInteger) p_posnNo;
{
    if ([_msgType isEqualToString:@"txt"])
        return [_txtSubCategoryList objectAtIndex:p_posnNo];
    else
        return [_imgSubCategoryList objectAtIndex:p_posnNo];
}

- (void)showTextMessagesForSubcategoryAtPosn:(NSInteger)p_posnNO
{
    //showtextmsgsforsubcategory
    if ([_msgType isEqualToString:@"txt"])
    {
        NSInteger l_catid = [[[_txtSubCategoryList objectAtIndex:p_posnNO] valueForKey:@"cid"] integerValue];
        self.navigateParams = @{@"categoryid":@(l_catid),@"type":@"subcategory"};
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"showtextmsgsforsubcategory" sender:self];
        });
    }
    else
    {
        /*NSInteger l_catid = [[[_imgSubCategoryList objectAtIndex:p_posnNO] valueForKey:@"cid"] integerValue];
        self.navigateParams = @{@"categoryid":@(l_catid),@"type":@"subcategory"};
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"showSubcategoryMessageForImages" sender:self];
        });*/
        NSInteger l_catid = [[[_imgSubCategoryList objectAtIndex:p_posnNO] valueForKey:@"cid"] integerValue];
        //NSLog(@"the category id is %ld",(long)l_catid);
        
        self.navigateParams = @{@"categoryid":@(l_catid), @"msgtype":@"img"};
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"showimgmsgsforsubcategory" sender:self];
        });
        
    
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
