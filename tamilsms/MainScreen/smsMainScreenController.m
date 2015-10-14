//
//  smsMainScreenController.m
//  tamilsms
//
//  Created by Mohan Kumar on 10/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import "smsMainScreenController.h"
#import "smsCategoryListTv.h"
#import "smsDBAsyncQueueProcess.h"
#import "textMessageForCategoryListTv.h"
#import "smsMainScrollView.h"
#import "smsOptionsDropDownTV.h"
#import "smsSettingsScreen.h"
#import "smsFeedbackScreen.h"
#import "smsInfoSettingsScreen.h"
#import "smsAccountSignupLogin.h"
#import "smsSynchronizationDatas.h"
#import "registrationNewUser.h"

@interface smsMainScreenController () <smsCategoriesListDelegate, smsOptionsDropDownTVDelegate, smsAccountSignUpDelegates, UIScrollViewDelegate, UIGestureRecognizerDelegate>
{
    //NSArray * categorylist, *categorymessage;
    UISegmentedControl * _topsegmentctrl;
    UILabel * _bottomlinelabel, * lbl_seperator;
    NSArray * _sgCtrlTitles;
    NSArray * _txtCategoryTitles;
    NSArray * _imgCategoryTitles;
    UIGestureRecognizer * _justgesture;
}

@property (nonatomic,strong) smsMainScrollView * mainScrollVw;
@property (nonatomic,strong) smsOptionsDropDownTV * dropDwnOptions;
//@property (nonatomic,strong) smsAccountSignupLogin * smsAccountSignupLoginSV;
@property (nonatomic,strong) smsSynchronizationDatas * smsSynchronizationDatasV;

//-(void)navigationTabForTamilSms;


@end

@implementation smsMainScreenController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navBar setHidden:NO];
    self.navItem.leftBarButtonItems = [NSArray arrayWithObjects:self.bar_logo_btn, self.bar_prev_title_btn,nil];
    self.navItem.rightBarButtonItems = [NSArray arrayWithObjects:self.bar_list_btn,nil];
    [self setUpMainNavigationSegmentCtrl];
    _justgesture = [[UIGestureRecognizer alloc] init];
    _justgesture.delegate = self;
    [self.view addGestureRecognizer:_justgesture];
    
    
    [smsDBAsyncQueueProcess getTextCategoryTitles:^(NSArray * p_categoreisList){
        _txtCategoryTitles = p_categoreisList;
        //NSLog(@"the cataegory titles%@",_categoryTitles);
        if (self.mainScrollVw)
        {
            [self.mainScrollVw reloadTextCategoriesList];
            //[self.mainScrollVw reloadImageCategoriesList];
        }

    }];

    [smsDBAsyncQueueProcess getImageCategoryTitles:^(NSArray * p_categoreisList){
        _imgCategoryTitles = p_categoreisList;
        //NSLog(@"the cataegory titles%@",_categoryTitles);
        if (self.mainScrollVw)
        {
            [self.mainScrollVw reloadImageCategoriesList];
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setScreenInteractionStatus:(BOOL) p_interactstatus
{
    [self.mainScrollVw setUserInteractionEnabled:p_interactstatus];
    [_topsegmentctrl setUserInteractionEnabled:p_interactstatus];
    [self.navBar setUserInteractionEnabled:p_interactstatus];
}

-(void)setUpMainNavigationSegmentCtrl
{
    
    _sgCtrlTitles = @[@"TEXT MSG", @"IMAGES", @"ACCOUNT",@"MORE"];
    NSDictionary * l_normalattributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0], NSFontAttributeName,
                                         [UIColor whiteColor], NSForegroundColorAttributeName,
                                         nil];
    NSDictionary * l_selectattributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0], NSFontAttributeName,
                                         [UIColor whiteColor], NSForegroundColorAttributeName,
                                         nil];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:l_normalattributes forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:l_selectattributes forState:UIControlStateSelected];
    
    _topsegmentctrl = [[UISegmentedControl alloc] initWithItems:_sgCtrlTitles];
    _topsegmentctrl.layer.cornerRadius = 0.0;
    _topsegmentctrl.translatesAutoresizingMaskIntoConstraints = NO;
    //[_topsegmentctrl setFrame:CGRectMake(0, 65, self.view.bounds.size.width,40)];
    _topsegmentctrl.selectedSegmentIndex = 0;
    [self.view addSubview:_topsegmentctrl];
    [_topsegmentctrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[sc(40)]" options:0 metrics:nil views:@{@"sc":_topsegmentctrl}]];
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:_topsegmentctrl attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0],[NSLayoutConstraint constraintWithItem:_topsegmentctrl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]]];
    
    _topsegmentctrl.tintColor = [UIColor blackColor];
    _topsegmentctrl.backgroundColor = [UIColor colorWithRed:0.26 green:0.26 blue:0.26 alpha:1.0];
    [_topsegmentctrl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    _bottomlinelabel = [UILabel new];
    //[[UILabel alloc]initWithFrame:CGRectMake(0,100, self.view.bounds.size.width/4.0f, 5)];
    [_bottomlinelabel setBackgroundColor:[UIColor colorWithRed:0.00 green:1.00 blue:1.00 alpha:1.0]];
    _bottomlinelabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_bottomlinelabel];
    [_bottomlinelabel addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bl(5)]" options:0 metrics:nil views:@{@"bl":_bottomlinelabel}]];
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:_bottomlinelabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.25 constant:0.0],[NSLayoutConstraint constraintWithItem:_bottomlinelabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:0.25 constant:0.0]]];
    
    
   self.mainScrollVw = [smsMainScrollView new];
    //myScroll.frame = self.view.bounds;
    //myScroll.contentSize = CGSizeMake(400, 800);
    self.mainScrollVw.backgroundColor = [UIColor grayColor];
    self.mainScrollVw.showsVerticalScrollIndicator = YES;
    self.mainScrollVw.translatesAutoresizingMaskIntoConstraints = NO;
    //myScroll.showsHorizontalScrollIndicator = YES;
    self.mainScrollVw.delegate = self;
    self.mainScrollVw.scrollEnabled = YES;
    self.mainScrollVw.txtMsgCategoriesDelegate = self;
    self.mainScrollVw.signUpLoginDelegate = self;
    [self.view addSubview:self.mainScrollVw];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:self.mainScrollVw attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.mainScrollVw attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.mainScrollVw attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:(-64.0-40)]]];
    

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[sc][ms]" options:0 metrics:nil views:@{@"sc":_topsegmentctrl, @"ms":self.mainScrollVw}]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_bottomlinelabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_topsegmentctrl attribute:NSLayoutAttributeTop multiplier:1.0 constant:35.0]];
    [self.view layoutIfNeeded];

}
//three bar button when pressed executes the smsMainScreenSeting class
- (void)executeListButtonClicked
{
    //self.mainscrSetngsTV = [[smsMainScreenSettingsTV alloc] initWithFrame:CGRectMake(265, 65, 150, 90) style:UITableViewStylePlain];
    self.dropDwnOptions = [smsOptionsDropDownTV new];
    self.dropDwnOptions.optionsDelegate = self;
    [self.view addSubview:self.dropDwnOptions];
    self.dropDwnOptions.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view bringSubviewToFront:self.dropDwnOptions];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[MS(120)]" options:0 metrics:nil views:@{@"MS":self.dropDwnOptions}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[MS(150)]" options:0 metrics:nil views:@{@"MS":self.dropDwnOptions}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-65-[MS]" options:0 metrics:nil views:@{@"MS":self.dropDwnOptions}]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.dropDwnOptions attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    
    [self.view layoutIfNeeded];
    [self setScreenInteractionStatus:NO];
}


-(void)valueChanged:(id) segmentctrl
{
    UISegmentedControl * l_sgctrl = (UISegmentedControl*) segmentctrl;
    NSInteger l_selecteditem = l_sgctrl.selectedSegmentIndex;
    
    UILabel * l_bglabel = [[UILabel alloc] init];
    [l_bglabel setBackgroundColor:[UIColor colorWithRed:0.77 green:0.95 blue:0.95 alpha:1.0]];
    [l_bglabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0]];
    [l_bglabel setText:[_sgCtrlTitles objectAtIndex:l_selecteditem]];
    [l_bglabel setTextColor:[UIColor whiteColor]];
    [l_bglabel setTextAlignment:NSTextAlignmentCenter];
    
    CGFloat l_segmentwidth = _topsegmentctrl.bounds.size.width/4.0;
    /*CGRect l_bottomlinerect = _bottomlinelabel.frame;
    l_bottomlinerect.origin.x = l_selecteditem*l_sgctrl.bounds.size.width/4.0;
    CGRect l_newrect = CGRectMake(l_bottomlinerect.origin.x, l_sgctrl.frame.origin.y, l_bottomlinerect.size.width, l_sgctrl.frame.size.height);
    [l_bglabel setFrame:l_newrect];*/
    [self.view addSubview:l_bglabel];
    //Here THE main scrollview is added and the bootom blue line get animated
    [UIView animateWithDuration:0.3
                     animations:^(){
                         //[_bottomlinelabel setFrame:l_bottomlinerect];
                         _bottomlinelabel.transform = CGAffineTransformMakeTranslation(l_segmentwidth*l_selecteditem, 0);
                         [self.mainScrollVw setContentOffset:CGPointMake(self.mainScrollVw.bounds.size.width*l_selecteditem, 0)];
                     } completion:^(BOOL p_finished){
                         l_sgctrl.tintColor = [UIColor blackColor];
                         [l_bglabel removeFromSuperview];
                     }];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    if (self.mainScrollVw) {
        [self.mainScrollVw updateConstraints];
        [self.mainScrollVw reloadTextCategoriesList];
        [self.mainScrollVw reloadImageCategoriesList];
        [self valueChanged:_topsegmentctrl];
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

#pragma gesture recognizer related delegates

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (self.dropDwnOptions)
    {
        CGPoint l_touchpoint = [touch locationInView:self.view];
        if (CGRectContainsPoint(self.dropDwnOptions.frame, l_touchpoint)==NO)
        {
            [self cancelDropDownScreen];
        }
    }
    return NO;
}

#pragma option drop down delegates
// this is the delegate from smsOptionalDropDown when the particular row is clicked follwing get executed
- (void)optionSelectedInDropDown:(NSString *)p_optionText
{
    self.navigateParams = @{@"opselected":p_optionText};
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"showdropdownoptionscreen" sender:self];
    });
    [self cancelDropDownScreen];
}

- (void) cancelDropDownScreen
{
    [self.dropDwnOptions removeFromSuperview];
    self.dropDwnOptions = nil;
    [self setScreenInteractionStatus:YES];
}


#pragma sms categoreis list delegates handler


-(NSInteger)getNumberOfCategoriesOfMsgType:(NSString *)p_msgType
{
    if ([p_msgType isEqualToString:@"txt"])
        return [_txtCategoryTitles count];
    else
        return [_imgCategoryTitles count];
}

-(NSDictionary*) getCategoryDataFromArray:(NSInteger) p_posnNo ofMsgType:(NSString *)p_msgType
{
    if ([p_msgType isEqualToString:@"txt"])
        return [_txtCategoryTitles objectAtIndex:p_posnNo];
    else
        return [_imgCategoryTitles objectAtIndex:p_posnNo];
}

-(void)categoryIdClickedForTheCell:(NSInteger)p_positno ofMsgType:(NSString *)p_msgType
{
    
    if ([p_msgType isEqualToString:@"txt"])
    {
        //NSLog(@"the position number is %ld",(long)p_positno);
        NSInteger l_catidi = [[[_txtCategoryTitles objectAtIndex:p_positno] valueForKey:@"cid"] integerValue];
        //NSLog(@"the category id is %ld",(long)l_catid);
        
        if (l_catidi <=100)
        {
            NSInteger l_catid = [[[_txtCategoryTitles objectAtIndex:p_positno] valueForKey:@"cid"] integerValue];
            self.navigateParams = @{@"categoryid":@(l_catid), @"msgtype":p_msgType};
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:@"showtextmessagesforcategory" sender:self];
            });
        }
        else
        {
            NSInteger l_catgid = [[[_txtCategoryTitles objectAtIndex:p_positno] valueForKey:@"cid"] integerValue];
            self.navigateParams = @{@"categoryid":@(l_catgid), @"msgtype":p_msgType};
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:@"showSubCategoryList" sender:self];
            });
        }
    }
    else
    {
        NSInteger l_catidi = [[[_imgCategoryTitles objectAtIndex:p_positno] valueForKey:@"cid"] integerValue];
        //NSLog(@"the category id is %ld",(long)l_catid);
        
        if (l_catidi <=100)
        {
            NSInteger l_catid = [[[_imgCategoryTitles objectAtIndex:p_positno] valueForKey:@"cid"] integerValue];
            self.navigateParams = @{@"categoryid":@(l_catid), @"msgtype":p_msgType};
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:@"showimagemessagesforcategory" sender:self];
            });
        }
        else
        {
            NSInteger l_catgid = [[[_imgCategoryTitles objectAtIndex:p_positno] valueForKey:@"cid"] integerValue];
            self.navigateParams = @{@"categoryid":@(l_catgid), @"msgtype":p_msgType};
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:@"showSubCategoryList" sender:self];
            });
        }
    }
}

#pragma  signup and login screen related delegates

-(void)invokeSignUpScreen
{
    self.navigateParams = @{@"opselected":@"signup"};
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"showdropdownoptionscreen" sender:self];
    });
    
}

#pragma main scrollview related delegates

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat l_topointxval = targetContentOffset->x;
    NSInteger l_selecteditemno = l_topointxval/self.mainScrollVw.bounds.size.width;
    _topsegmentctrl.selectedSegmentIndex = l_selecteditemno;
    CGFloat l_segmentwidth = self.mainScrollVw.bounds.size.width/4.0;
    UILabel * l_bglabel = [[UILabel alloc] init];
    [l_bglabel setBackgroundColor:[UIColor colorWithRed:0.77 green:0.95 blue:0.95 alpha:1.0]];
    [l_bglabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0]];
    [l_bglabel setText:[_sgCtrlTitles objectAtIndex:l_selecteditemno]];
    [l_bglabel setTextColor:[UIColor whiteColor]];
    [l_bglabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:l_bglabel];
    //Here THE main scrollview is added and the bootom blue line get animated
    [UIView animateWithDuration:0.3
                     animations:^(){
                         //[_bottomlinelabel setFrame:l_bottomlinerect];
                         _bottomlinelabel.transform = CGAffineTransformMakeTranslation(l_segmentwidth*l_selecteditemno, 0);
                     } completion:^(BOOL p_finished){
                         _topsegmentctrl.tintColor = [UIColor blackColor];
                         [l_bglabel removeFromSuperview];
                     }];
}

@end
