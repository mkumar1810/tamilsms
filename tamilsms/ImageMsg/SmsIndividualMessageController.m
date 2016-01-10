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
    smsIndTxtMessages * _individualmessage;
    //NSDictionary * _popupdict;
    NSArray * _allitems;
    NSInteger _startPosn;
    bottomViewForNextMessage * _bottomViewForNextMessage;
}

-(void)setUpReferenceForTable;
-(void)createPlusMinusButtonsForNavigatoncontroler;
-(void)positiveZooming;


//@property(nonatomic,retain) individualMesssage * individualMesssageTV;

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
    if (_individualmessage) {
        [_individualmessage reloadData];
        [_individualmessage scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_startPosn inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    //NSLog(@"the received message is %@", _allitems);
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
    
    _individualmessage = [[smsIndTxtMessages alloc] initWithStartPosn:_startPosn];
    _individualmessage.translatesAutoresizingMaskIntoConstraints = NO;
     
   // _individualmessage = [[individualMesssage alloc]initWithStartPosn:_startPosn];
    //WithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height-100)];
    //[_individualmessage setFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-100)];
    _individualmessage.popUpMessageDelegate=self;
    //[_screentable setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:_individualmessage];
    //[_screentable setHidden:YES];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_individualmessage
                                                    attribute:NSLayoutAttributeWidth
                                                    relatedBy:NSLayoutRelationEqual toItem:self.view
                                                    attribute:NSLayoutAttributeWidth
                                                   multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_individualmessage
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.view
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0 constant:0.0]];

    
    
    //[_individualmessage addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[iM(200)]" options:0 metrics:nil views:@{@"iM":_individualmessage}]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_individualmessage
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0 constant:(-64-100)]];

    
    
    
    //_bottomViewForNextMessage = [[bottomViewForNextMessage alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-100, self.view.bounds.size.width, 100)];
    
    _bottomViewForNextMessage = [[bottomViewForNextMessage alloc] initWithCopyButton:YES];
    [_bottomViewForNextMessage setBackgroundColor:[UIColor colorWithRed:0.09 green:0.21 blue:0.40 alpha:1.0]];
    _bottomViewForNextMessage.bottomViewDelegate = _individualmessage;
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
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[iM][bm]|" options:0 metrics:nil views:@{@"iM":_individualmessage,@"bm":_bottomViewForNextMessage}]];
    [self.view layoutIfNeeded];
}

-(NSDictionary*) getIndividualMessageOfDict:(NSInteger) p_posnNo
{
    //NSDictionary * popUpMsg = _allitems;
    //NSLog(@"all items in dic is %@",_allitems);
    //[_individualmessage ]
    //return _popupdict;
    return [_allitems objectAtIndex:p_posnNo];
}

- (NSInteger) getNumberOfMessages
{
    return [_allitems count];
}

@end
