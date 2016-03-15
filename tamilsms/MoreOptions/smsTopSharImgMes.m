//
//  smsTopSharImgMes.m
//  tamilsms
//
//  Created by arun benjamin on 01/03/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import "smsTopSharImgMes.h"
#import "smsRESTProxy.h"
#import "smsAsyncImageFetch.h"


@interface smsTopSharImgMes ()
{
    NSMutableArray * _imgMessages;
    NSInteger _authorid, _auth_noofmsgs;
    NSString * _author_name;
    NSInteger _pageNo;
    BOOL _allmsgsarereceived;
}

@end

@implementation smsTopSharImgMes
@synthesize hideStatusBar, navigateParams, transitionType;

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * l_bar_back_btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30.0f, 25.0f)];
    [l_bar_back_btn setImage:[UIImage imageNamed:@"bckbtn-1.png"] forState:UIControlStateNormal];
    [l_bar_back_btn addTarget:self action:@selector(backNavigation) forControlEvents:UIControlEventTouchUpInside];
    _baradd_btn = [[UIBarButtonItem alloc] initWithCustomView:l_bar_back_btn];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    [self initializeData];
    self.navigationItem.leftBarButtonItem = _baradd_btn;
    [self.navigationItem setTitle:@"Top Shared Image"];
    
     // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)awakeFromNib
{
    self.transitionType = vertical;
    [self.collectionView registerClass:[TopAuthourImageCell class] forCellWithReuseIdentifier:@"loadmore_msg_cell"];
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"loadmore_msg_cell"];
    _imgMessages = [NSMutableArray new];
}

-(void)backNavigation
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initializeData
{
    _pageNo = 1;
    [[smsRESTProxy alloc] initDatawithAPIType:@"TOP_SHARED_IMAG_MSG" andInputParams:@{@"page":@(_pageNo)} andReturnMethod:^(NSData * p_txtmsgsData){
        NSDictionary * l_receiveddict = [NSJSONSerialization JSONObjectWithData:p_txtmsgsData options:NSJSONReadingMutableLeaves error:NULL];
        [_imgMessages addObjectsFromArray:[l_receiveddict valueForKey:@"Quotes"]];
        [self.collectionView reloadData];
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize l_reqdsize = CGSizeZero;
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {
        l_reqdsize = CGSizeMake(self.view.bounds.size.width/2.0-5, self.view.bounds.size.width/2.0-5);
    }
    else
    {
        l_reqdsize = CGSizeMake(self.view.bounds.size.width/3.0-5, self.view.bounds.size.width/3.0-5);
    }
    //NSLog(@"the size returned %@", NSStringFromCGSize(l_reqdsize));
    return l_reqdsize;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return [_imgMessages count];
    if (_allmsgsarereceived == NO)
    {
        return [_imgMessages count]+1;
    }
    else
    {
        return  [_imgMessages count];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * l_detailcellid = @"Topimg_msg_cell";
    static NSString * l_loadmorecellid = @"loadmore_msg_cell";
    if (_allmsgsarereceived == NO)
    {
        if (indexPath.row==[_imgMessages count])
        {
            UICollectionViewCell * l_loadmorecell = [collectionView dequeueReusableCellWithReuseIdentifier:l_loadmorecellid forIndexPath:indexPath];
            [l_loadmorecell setBackgroundColor:[UIColor colorWithRed:0.33 green:0.53 blue:0.25 alpha:1.0]];
            return l_loadmorecell;
        }
        
    }
    NSDictionary * l_imgmsgdict = [_imgMessages objectAtIndex:indexPath.row];
    //[_categoryMessageDelegate getMessageFromArray:indexPath.row];
    imageMessageForCell * l_detailcell = [collectionView dequeueReusableCellWithReuseIdentifier:l_detailcellid forIndexPath:indexPath];
    [l_detailcell setDisplayData:l_imgmsgdict];
    return l_detailcell;
    
}


#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //smstopsharedindimgmsg
    if (indexPath.row==[_imgMessages count])
    {
        _pageNo++;
        [[smsRESTProxy alloc] initDatawithAPIType:@"TOP_SHARED_IMAG_MSG" andInputParams:@{@"page":@(_pageNo)} andReturnMethod:^(NSData * p_txtmsgsData){
            NSDictionary * l_receiveddict = [NSJSONSerialization JSONObjectWithData:p_txtmsgsData options:NSJSONReadingMutableLeaves error:NULL];
            if ([[l_receiveddict valueForKey:@"Quotes"] count]==0)
            {
                _allmsgsarereceived = YES;
            }
            [_imgMessages addObjectsFromArray:[l_receiveddict valueForKey:@"Quotes"]];
            [self.collectionView reloadData];
        }];
    }
    else
    {
        self.navigateParams = @{@"initialposn":@(indexPath.row),
                                @"allmessages":_imgMessages,
                                @"isonline":@(YES)};
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"smstopsharedindimgmsg" sender:self];
        });
    }
}

@end

