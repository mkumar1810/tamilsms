//
//  smsFavoriteMsgTxtCtrlr.m
//  tamilsms
//
//  Created by arun benjamin on 18/02/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import "smsFavoriteMsgTxtCtrlr.h"
#import "smsRESTProxy.h"
#import "smsDBAsyncQueueProcess.h"

@interface smsFavoriteMsgTxtCtrlr ()
{
    NSArray * _txtMessages;
    NSArray * _ImgMessages;
    NSMutableParagraphStyle * _txtmsgstyle;
    NSInteger _authorid, _auth_noofmsgs;
    NSString * _author_name;
    NSInteger _pageNo;
    BOOL _allmsgsarereceived;

}
@end

@implementation smsFavoriteMsgTxtCtrlr
@synthesize transitionType, hideStatusBar, navigateParams;
@synthesize segCtrol;
@synthesize msgTtablView;
@synthesize imgCollView;
static NSString * const reuseIdentifier = @"Fav_img_msg_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [imgCollView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    msgTtablView.hidden=NO;
    segCtrol.selectedSegmentIndex = 0;
    UIButton * l_bar_back_btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30.0f, 25.0f)];
    [l_bar_back_btn setImage:[UIImage imageNamed:@"bckbtn-1.png"] forState:UIControlStateNormal];
    [l_bar_back_btn addTarget:self action:@selector(backNavigation) forControlEvents:UIControlEventTouchUpInside];
    _baradd_btn = [[UIBarButtonItem alloc] initWithCustomView:l_bar_back_btn];
  
     self.navigationItem.leftBarButtonItem = _baradd_btn;
     [self.navigationItem setTitle:@"Favourite"];
    [self initalizeImgMainData];
    [self initializeMainData];
    // Do any additional setup after loading the view.
}


- (void) initializeMainData
{
    [self.navigationItem setTitle:@"Favourite Text"];
    [smsDBAsyncQueueProcess getFavouriteTextMessagesWithReturnCB:^(NSArray * p_categoreisListMessage){
        _txtMessages = p_categoreisListMessage;
        //NSLog(@"text messages %@", _categorymessages);
        //NSLog(@"the category messages is %ld",(long)_categoryid);
        NSLog(@"the frame is %@",NSStringFromCGRect(self.msgTtablView.frame));
        if (msgTtablView)
        {
            [msgTtablView reloadData];
        }
        //[self.actView stopAnimating];
    }];
}

-(void)initalizeImgMainData
{
    [self.navigationItem setTitle:@"Favourite Img"];
    [smsDBAsyncQueueProcess getFavouriteImageMessagesWithReturnCB:^(NSArray * p_FavImgMsg){
        _ImgMessages = p_FavImgMsg;
        //NSLog(@"the recived Img messages %@", _ImgMessages);
        //NSLog(@"the category messages is %ld",(long)_categoryid);
        NSLog(@"the frame is %@",NSStringFromCGRect(self.imgCollView.frame));
        if (imgCollView)
        {
            [imgCollView reloadData];
        }
        //[self.actView stopAnimating];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)awakeFromNib
{
    self.transitionType = vertical;
    //[self.imgCollView registerClass:[favImgCell class] forCellWithReuseIdentifier:@"favImgProCell"];
    
}

-(void)backNavigation
{
    [self.navigationController popViewControllerAnimated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)segCntolr:(id)sender
{
    if (segCtrol.selectedSegmentIndex==0)
    {
        msgTtablView.hidden=NO;
        imgCollView.hidden=YES;
    }else if (segCtrol.selectedSegmentIndex==1)
    {
        msgTtablView.hidden=YES;
        imgCollView.hidden=NO;
    }
}

#pragma mark - sms image messages list delegates handler

-(NSDictionary*) getImageMsgDictAtPosn:(NSInteger) p_posnNo
{
    return [_ImgMessages objectAtIndex:p_posnNo];
}

-(NSInteger)getImageMessageCount
{
    return [_ImgMessages count];
}

-(void)imgMsgClickedForTheCell:(NSInteger)p_positno
{
    self.navigateParams = [_ImgMessages objectAtIndex:p_positno];
    self.navigateParams = @{@"initialposn":@(p_positno),
                            @"allmessages":_ImgMessages};
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"FavouriteImgMsg" sender:self];
    });
}

#pragma mark - sms text messages list delegates handler

-(NSInteger)getMessageCount
{
    //NSInteger nocount = [_categorymessages count];
    //NSLog(@"the category msg count is %ld",(long)nocount);
    return [_txtMessages count];
    
}

-(NSDictionary*) getMessageFromArray:(NSInteger) p_posnNo
{
    return [_txtMessages objectAtIndex:p_posnNo];
}

-(void)messageClickedForTheCell:(NSInteger)p_positno
{
    self.navigateParams = [_txtMessages objectAtIndex:p_positno];
    self.navigateParams = @{@"initialposn":@(p_positno),
                            @"allmessages":_txtMessages};
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"favouriteindtxtmsg" sender:self];
    });
}

@end

