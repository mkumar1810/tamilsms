//
//  smsIndividualImageMessageControler.m
//  tamilsms
//
//  Created by Mohan Kumar on 24/09/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import "smsIndividualImageMessageControler.h"

@interface smsIndividualImageMessageControler ()//<individualMessageDelegate>
{
    UIBarButtonItem * _baradd_btn, *_barPlay_btn, *_barflex, *_barsetng_btn;
    //smsIndividualMessageCol * _individualImagemessage
    //NSDictionary * _popupdict;
    NSArray * _allitems;
    NSInteger _startPosn;
  //  bottomViewForNextMessage * _bottomViewForNextMessage;
}

-(void)setUpReferenceForTable;
-(void)createPlusMinusButtonsForNavigatoncontroler;
-(void)positiveZooming;
-(void)slideShowForImages;

@property(nonatomic,retain) smsIndividualMessageCol * smsIndividualMessageColCV;
@end

@implementation smsIndividualImageMessageControler

- (void)awakeFromNib
{
    self.transitionType = popOutVerticalOpen;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navBar setHidden:NO];
    self.navItem.leftBarButtonItems = [NSArray arrayWithObjects: self.bar_back_btn, self.bar_logo_btn, self.bar_prev_title_btn,nil];
    [self createPlusMinusButtonsForNavigatoncontroler];
    self.navItem.rightBarButtonItems = [NSArray arrayWithObjects:_barsetng_btn, _barPlay_btn, _barflex,nil];
    [self setUpReferenceForTable];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeDataWithParams:(NSDictionary *)p_initParams

{
    //_popupdict = p_initParams;
    _allitems = [p_initParams valueForKey:@"allmessages"];
    _startPosn = [[p_initParams valueForKey:@"initialposn"] integerValue];
   /* if (_individualImagemessage) {
        [_individualImagemessage reloadData];
        [_individualImagemessage scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_startPosn inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }*/
    //NSLog(@"the received message is %@", _allitems);
}

-(void)createPlusMinusButtonsForNavigatoncontroler
{
    UIButton * l_settingbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25.0f, 30.0f)];
    [l_settingbtn setImage:[UIImage imageNamed:@"threepoint"] forState:UIControlStateNormal];
    [l_settingbtn addTarget:self action:@selector(positiveZooming) forControlEvents:UIControlEventTouchUpInside];
    _barsetng_btn = [[UIBarButtonItem alloc] initWithCustomView:l_settingbtn];
    
    /*UIButton * l_addbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25.0f, 25.0f)];
    [l_addbtn setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [l_addbtn addTarget:self action:@selector(positiveZooming) forControlEvents:UIControlEventTouchUpInside];
    _baradd_btn = [[UIBarButtonItem alloc] initWithCustomView:l_addbtn];*/
    
    UIButton * l_playbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25.0f, 25.0f)];
    [l_playbtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [l_playbtn addTarget:self action:@selector(slideShowForImages) forControlEvents:UIControlEventTouchUpInside];
    _barPlay_btn = [[UIBarButtonItem alloc] initWithCustomView:l_playbtn];
    
    _barflex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    _barflex.width = 15.0f;
}

-(void)positiveZooming
{
    
}

-(void)slideShowForImages
{
    //NSArray * preview = _allitems;
   // NSMutableArray * myimage = [_allitems valueForKey:@"msg_image"];
   /* UIImageView * showimage = [_allitems valueForKey:@"msg_image"];
    //NSLog(@"the array is %@",myimage);
    showimage.animationDuration = 1.00;
    showimage.animationRepeatCount = 0;
    
    [showimage startAnimating];*/
    
}

-(void)setUpReferenceForTable
{
    
    //self.smsIndividualMessageColCV = [[smsIndividualMessageCol alloc]initWithStartPosn:_startPosn];
    self.smsIndividualMessageColCV = [smsIndividualMessageCol new];
    self.smsIndividualMessageColCV.translatesAutoresizingMaskIntoConstraints = NO;
    
    // _individualmessage = [[individualMesssage alloc]initWithStartPosn:_startPosn];
    //WithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height-100)];
    //[_individualmessage setFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-100)];
    //self.smsIndividualMessageColCV.popUpMessageDelegate=self;
    //[_screentable setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:self.smsIndividualMessageColCV];
    //[_screentable setHidden:YES];
    
    
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.smsIndividualMessageColCV
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual toItem:self.view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.smsIndividualMessageColCV
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0 constant:0.0]];
    
    
    
    //[_individualmessage addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[iM(200)]" options:0 metrics:nil views:@{@"iM":_individualmessage}]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.smsIndividualMessageColCV
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0 constant:(-64-100)]];
    
    
    
    
    //_bottomViewForNextMessage = [[bottomViewForNextMessage alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-100, self.view.bounds.size.width, 100)];
    
  /*  _bottomViewForNextMessage = [[bottomViewForNextMessage alloc] initWithCopyButton:NO];
    [_bottomViewForNextMessage setBackgroundColor:[UIColor colorWithRed:0.09 green:0.21 blue:0.40 alpha:1.0]];
    _bottomViewForNextMessage.bottomViewDelegate = _individualImagemessage;
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
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[iM][bm]|" options:0 metrics:nil views:@{@"iM":_individualImagemessage,@"bm":_bottomViewForNextMessage}]];
    [self.view layoutIfNeeded];*/
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
