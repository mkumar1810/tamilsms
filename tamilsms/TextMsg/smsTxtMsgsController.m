//
//  smsTxtMsgsController.m
//  tamilsms
//
//  Created by Mohan Kumar on 12/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import "smsTxtMsgsController.h"
#import "textMessageForCategoryListTv.h"
#import "smsDBAsyncQueueProcess.h"

@interface smsTxtMsgsController ()<textMessageForCategoryDelegate>
{
    NSArray * _categorymessages;
    NSInteger _categoryid;
    //UIButton * l_addbtn;
    UIBarButtonItem * _baradd_btn;
}

@property (nonatomic,strong) textMessageForCategoryListTv * txtMessagesTV;

@end

@implementation smsTxtMsgsController

- (void)awakeFromNib
{
    self.transitionType = horizontalFlipFromRight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects: self.bar_back_btn, self.bar_logo_btn,nil];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self setupMainCategoriesListTV];
    [self createButtonsForNavigatoncontroler];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:_baradd_btn,nil];
    [self.view bringSubviewToFront:self.actView];
    [self.actView startAnimating];
    //database connection
    // Do any additional setup after loading the view.
}



-(void)createButtonsForNavigatoncontroler
{
    UIButton * l_addbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25.0f, 25.0f)];
    [l_addbtn setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
//    [l_addbtn setBackgroundColor:[UIColor blueColor]];
//    [l_addbtn.layer setCornerRadius:12.5f];
    [l_addbtn addTarget:self action:@selector(addNewUserForPosting) forControlEvents:UIControlEventTouchUpInside];
    _baradd_btn = [[UIBarButtonItem alloc] initWithCustomView:l_addbtn];
}

-(void)addNewUserForPosting
{
    
}

- (void)initializeDataWithParams:(NSDictionary *)p_initParams
{
    _categoryid = [[p_initParams valueForKey:@"categoryid"] integerValue];
    [self.navigationItem setTitle:[p_initParams valueForKey:@"category_name"]];
    if ([[p_initParams valueForKey:@"type"] isEqualToString:@"subcategory"])
    {
        self.transitionType = horizontalWithBounce;
    }
    [smsDBAsyncQueueProcess getTextMsgForCategory:_categoryid andReturnCB:^(NSArray * p_categoreisListMessage){
        _categorymessages = p_categoreisListMessage;
        //NSLog(@"the category messages is %ld",(long)_categoryid);
        if (self.txtMessagesTV)
        {
            [self.txtMessagesTV reloadCategoriesListMessages];
        }
        [self.actView stopAnimating];
    }];
}

-(void)setupMainCategoriesListTV
{
    self.txtMessagesTV = [textMessageForCategoryListTv new];
    self.txtMessagesTV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.txtMessagesTV];
    self.txtMessagesTV.categoryMessageDelegate = self;
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:self.txtMessagesTV attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0],[NSLayoutConstraint constraintWithItem:self.txtMessagesTV attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0],[NSLayoutConstraint constraintWithItem:self.txtMessagesTV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:(-64.0-49.0)]]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[cl]" options:0 metrics:nil views:@{ @"cl":self.txtMessagesTV}]];
    [self.view layoutIfNeeded];
    
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
    return [_categorymessages count];
}

-(NSDictionary*) getMessageFromArray:(NSInteger) p_posnNo
{
    return [_categorymessages objectAtIndex:p_posnNo];
}

-(void)messageClickedForTheCell:(NSInteger)p_positno
{
    self.navigateParams = @{@"initialposn":@(p_positno),
                            @"allmessages":_categorymessages};
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"showIndividualTextMessage" sender:self];
    });
}

@end
