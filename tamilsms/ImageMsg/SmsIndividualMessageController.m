//
//  SmsIndividualMessageController.m
//  tamilsms
//
//  Created by Mohan Kumar on 16/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import "SmsIndividualMessageController.h"

@interface SmsIndividualMessageController ()<indTxtMsgDelegate>
{
    UIBarButtonItem * _baradd_btn, *_barMinus_btn, *_barflex;
    NSArray * _allitems;
    NSInteger _startPosn;
    bottomViewForNextMessage * _bottomViewForNextMessage;
    BOOL _isOnline;
    NSString * _authorKey, * _imageKey;
}

-(void)setUpReferenceForTable;
-(void)createPlusMinusButtonsForNavigatoncontroler;
-(void)positiveZooming;


@property(nonatomic,strong) smsIndividualMessageCol * individualImgMsgCV;

@end

@implementation SmsIndividualMessageController

- (void)awakeFromNib
{
    self.transitionType = horizontalFlipFromRight;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.navBar setHidden:NO];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects: self.bar_back_btn, self.bar_logo_btn, self.bar_prev_title_btn,nil];
    [self createPlusMinusButtonsForNavigatoncontroler];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:_barMinus_btn, _barflex, _baradd_btn,nil];
    [self setUpReferenceForTable];


    // Do any additional setup after loading the view.
} 

- (void)initializeDataWithParams:(NSDictionary *)p_initParams
{
    //_popupdict = p_initParams;
    _allitems = [p_initParams valueForKey:@"allmessages"];
    _startPosn = [[p_initParams valueForKey:@"initialposn"] integerValue];
    _isOnline = [[p_initParams valueForKey:@"isonline"] boolValue];
    if (_isOnline)
    {
        _authorKey = @"username";
        _imageKey = @"news_image";
    }
    else
    {
        _authorKey = @"author";
        _imageKey = @"msg_image";
    }
}


-(void)createPlusMinusButtonsForNavigatoncontroler
{
    UIButton * l_addbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25.0f, 25.0f)];
    [l_addbtn setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [l_addbtn addTarget:self action:@selector(positiveZooming) forControlEvents:UIControlEventTouchUpInside];
    _baradd_btn = [[UIBarButtonItem alloc] initWithCustomView:l_addbtn];

    UIButton * l_minusbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25.0f, 25.0f)];
    [l_minusbtn setImage:[UIImage imageNamed:@"minus_icon"] forState:UIControlStateNormal];
    [l_minusbtn addTarget:self action:@selector(positiveZooming) forControlEvents:UIControlEventTouchUpInside];
    _barMinus_btn = [[UIBarButtonItem alloc] initWithCustomView:l_minusbtn];
    _barflex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    _barflex.width = 15.0f;
}

-(void)positiveZooming
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setUpReferenceForTable
{
    
    self.individualImgMsgCV = [[smsIndividualMessageCol alloc] initWithStartPosn:_startPosn authorKey:_authorKey imageKey:_imageKey];
                               
    self.individualImgMsgCV.translatesAutoresizingMaskIntoConstraints = NO;
     
    self.individualImgMsgCV.popUpMessageDelegate=self;
    [self.view addSubview:self.individualImgMsgCV];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.individualImgMsgCV
                                                    attribute:NSLayoutAttributeWidth
                                                    relatedBy:NSLayoutRelationEqual toItem:self.view
                                                    attribute:NSLayoutAttributeWidth
                                                   multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.individualImgMsgCV
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.view
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0 constant:0.0]];

    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.individualImgMsgCV
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0 constant:(-64-100)]];
    
    _bottomViewForNextMessage = [[bottomViewForNextMessage alloc] initWithCopyButton:NO];
    [_bottomViewForNextMessage setBackgroundColor:[UIColor colorWithRed:0.09 green:0.21 blue:0.40 alpha:1.0]];
    _bottomViewForNextMessage.bottomViewDelegate = self.individualImgMsgCV;
    _bottomViewForNextMessage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_bottomViewForNextMessage];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_bottomViewForNextMessage
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual toItem:self.view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_bottomViewForNextMessage
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0 constant:0.0]];
    [_bottomViewForNextMessage addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bm(100)]" options:0 metrics:nil views:@{@"bm":_bottomViewForNextMessage}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[iM][bm]|" options:0 metrics:nil views:@{@"iM":self.individualImgMsgCV,@"bm":_bottomViewForNextMessage}]];
    [self.view layoutIfNeeded];
    if (_allitems)
    {
        [self.individualImgMsgCV scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_startPosn inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    }
}

-(NSDictionary*) getIndividualMessageOfDict:(NSInteger) p_posnNo
{
    NSDictionary * l_dispdict = [_allitems objectAtIndex:p_posnNo];
    [_bottomViewForNextMessage setFavouriteStatusOnMsgId:[l_dispdict valueForKey:@"id"]];
    return l_dispdict;

//    return [_allitems objectAtIndex:p_posnNo];
}

- (NSInteger) getNumberOfMessages
{
    return [_allitems count];
}


- (UINavigationController *)getParentNavController
{
    return self.navigationController;
}

@end
