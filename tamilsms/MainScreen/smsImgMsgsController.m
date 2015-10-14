//
//  smsImgMsgsController.m
//  tamilsms
//
//  Created by arun benjamin on 22/09/15.
//  Copyright (c) 2015 arun benjamin. All rights reserved.
//

#import "smsImgMsgsController.h"

@interface smsImgMsgsController ()<imageMessageForCategoryDelegate>
{
    NSArray * _categoryimgmessages;
    NSInteger _categoryid;
    //UIButton * l_addbtn;
    UIBarButtonItem * _baradd_btn;
}

@property (nonatomic,strong) smsImageMessages * imgMessagesTV;

@end

@implementation smsImgMsgsController

- (void)awakeFromNib
{
    self.transitionType = horizontalFlipFromRight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navBar setHidden:NO];
    self.navItem.leftBarButtonItems = [NSArray arrayWithObjects: self.bar_back_btn, self.bar_logo_btn, self.bar_prev_title_btn,nil];
    [self setUpMainNavigationSegmentCtrl];
    [self createButtonsForNavigatoncontroler];
    self.navItem.rightBarButtonItems = [NSArray arrayWithObjects:_baradd_btn,nil];
    //database connection
    // Do any additional setup after loading the view.
}
-(void)createButtonsForNavigatoncontroler
{
    UIButton * l_addbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25.0f, 25.0f)];
    [l_addbtn setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [l_addbtn addTarget:self action:@selector(addNewUserForPosting) forControlEvents:UIControlEventTouchUpInside];
    _baradd_btn = [[UIBarButtonItem alloc] initWithCustomView:l_addbtn];
}

-(void)addNewUserForPosting
{
    
}

- (void)initializeDataWithParams:(NSDictionary *)p_initParams
{
    _categoryid = [[p_initParams valueForKey:@"categoryid"] integerValue];
    /*if ([[p_initParams valueForKey:@"type"] isEqualToString:@"subcategory"])
    {*/
        self.transitionType = horizontalWithBounce;
    //}
    [smsDBAsyncQueueProcess getImagMsgForCategory:_categoryid
                                      andReturnCB:^(NSArray * p_imgMsgs){
        _categoryimgmessages = p_imgMsgs;
        //NSLog(@"the category image  messages is %ld",(long)_categoryimgmessages);
        if (self.imgMessagesTV)
        {
            [self.imgMessagesTV reloadCategoriesListMessages];
        }
    }];
    
}

-(void)setUpMainNavigationSegmentCtrl
{
    
    self.imgMessagesTV = [smsImageMessages new];
    self.imgMessagesTV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.imgMessagesTV];
    self.imgMessagesTV.categoryMessageDelegate = self;
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:self.imgMessagesTV attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0],[NSLayoutConstraint constraintWithItem:self.imgMessagesTV attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0],[NSLayoutConstraint constraintWithItem:self.imgMessagesTV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:(-64.0)]]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[cl]" options:0 metrics:nil views:@{ @"cl":self.imgMessagesTV}]];
    [self.view layoutIfNeeded];
    
    
    /*_textMessageForCategoryListTv = [[textMessageForCategoryListTv alloc]initWithFrame:CGRectMake(0, 105, self.view.bounds.size.width, self.view.bounds.size.height-105) style:UITableViewStylePlain];
     _textMessageForCategoryListTv.categoryMessageDelegate = self;
     _textMessageForCategoryListTv.dataSource = _textMessageForCategoryListTv;
     _textMessageForCategoryListTv.delegate = _textMessageForCategoryListTv;
     _textMessageForCategoryListTv.translatesAutoresizingMaskIntoConstraints = NO;
     [self.view addSubview:_textMessageForCategoryListTv];*/
    
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

#pragma sms categoreis list delegates handler


-(NSInteger)getMessageCount
{
    //NSInteger nocount = [_categorymessages count];
    //NSLog(@"the category msg count is %ld",(long)nocount);
    return [_categoryimgmessages count];
}

-(NSDictionary*) getMessageFromArray:(NSInteger) p_posnNo
{
    return [_categoryimgmessages objectAtIndex:p_posnNo];
}

-(void)messageClickedForTheCell:(NSInteger)p_positno
{
    //self.navigateParams = [_categorymessages objectAtIndex:p_positno];
    self.navigateParams = @{@"initialposn":@(p_positno),
                            @"allmessages":_categoryimgmessages};
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"ShowIndividualImagemessage" sender:self];
    });
    
}


- (void)updateViewConstraints
{
    [super updateViewConstraints];
    if (self.imgMessagesTV) {
        [self.imgMessagesTV reloadCategoriesListMessages];
    }
}

@end
