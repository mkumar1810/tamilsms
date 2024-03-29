//
//  smsTop25AuthoursImage.m
//  tamilsms
//
//  Created by arun benjamin on 29/01/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import "smsTop25AuthoursImage.h"
#import "smsRESTProxy.h"
#import "smsAsyncImageFetch.h"

@interface smsTop25AuthoursImage ()
{
    NSMutableArray * _imgMessages;
    NSInteger _authorid, _auth_noofmsgs;
    NSString * _author_name;
    NSInteger _pageNo;
    BOOL _allmsgsarereceived;
}

@end

@implementation smsTop25AuthoursImage

@synthesize hideStatusBar, navigateParams, transitionType;

static NSString * const reuseIdentifier = @"Cell";

- (void)awakeFromNib
{
    self.transitionType = vertical;
//    [self.collectionView registerClass:[TopAuthourImageCell class] forCellWithReuseIdentifier:@"Topimg_msg_cell"];
    [self.collectionView registerClass:[TopAuthourImageCell class] forCellWithReuseIdentifier:@"loadmore_msg_cell"];
    _imgMessages = [NSMutableArray new];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    UIButton * l_bar_back_btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30.0f, 25.0f)];
    [l_bar_back_btn setImage:[UIImage imageNamed:@"bckbtn-1.png"] forState:UIControlStateNormal];
    [l_bar_back_btn addTarget:self action:@selector(backNavigation) forControlEvents:UIControlEventTouchUpInside];
    _baradd_btn = [[UIBarButtonItem alloc] initWithCustomView:l_bar_back_btn];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    self.navigationItem.leftBarButtonItem = _baradd_btn;
    [self.navigationItem setTitle:@"Top 25 Authors Image"];
}

- (void)initializeDataWithParams:(NSDictionary *)p_initParams
{
    _authorid = [[p_initParams valueForKey:@"id"] integerValue];
    _author_name = [p_initParams valueForKey:@"username"];
    _auth_noofmsgs = [[p_initParams valueForKey:@"tot_sms_count"] integerValue];
    _pageNo = 1;
    [self.navigationItem setTitle:[NSString stringWithFormat:@"%@(%d)",_author_name, (int) _auth_noofmsgs]];
    [[smsRESTProxy alloc] initDatawithAPIType:@"TOP25_IMAGE_MSGS" andInputParams:@{@"user_id":@(_authorid),@"page":@(_pageNo)} andReturnMethod:^(NSData * p_txtmsgsData){
        NSDictionary * l_receiveddict = [NSJSONSerialization JSONObjectWithData:p_txtmsgsData options:NSJSONReadingMutableLeaves error:NULL];
        [_imgMessages addObjectsFromArray:[l_receiveddict valueForKey:@"Quotes"]];
        //NSLog(@"authors list data %@", _imgMessages);
        [self.collectionView reloadData];
    }];
}


-(void)backNavigation
{
    [self.navigationController popViewControllerAnimated:YES];
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
            TopAuthourImageCell * l_loadmorecell = [collectionView dequeueReusableCellWithReuseIdentifier:l_loadmorecellid forIndexPath:indexPath];
            [l_loadmorecell setBackgroundColor:[UIColor colorWithRed:0.33 green:0.53 blue:0.25 alpha:1.0]];
            return l_loadmorecell;
        }
    }
    NSDictionary * l_imgmsgdict = [_imgMessages objectAtIndex:indexPath.row];
    //[_categoryMessageDelegate getMessageFromArray:indexPath.row];
    TopAuthourImageCell * l_detailcell = [collectionView dequeueReusableCellWithReuseIdentifier:l_detailcellid forIndexPath:indexPath];
    [l_detailcell setDisplayData:l_imgmsgdict];
    return l_detailcell;
    
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==[_imgMessages count])
    {
        _pageNo++;
        [[smsRESTProxy alloc] initDatawithAPIType:@"TOP25_IMAGE_MSGS" andInputParams:@{@"user_id":@(_authorid),@"page":@(_pageNo)} andReturnMethod:^(NSData * p_txtmsgsData){
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
        //showlatestindimgmsg
        self.navigateParams = @{@"initialposn":@(indexPath.row),
                                @"allmessages":_imgMessages,
                                @"isonline":@(YES)};
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"showtop25indimgmsg" sender:self];
        });
    }
}


@end

@interface TopAuthourImageCell ()
{
    UILabel * l_authorname; //

}

@end

@implementation TopAuthourImageCell

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if ([self.reuseIdentifier isEqualToString:@"loadmore_msg_cell"])
    {
        [self drawRectLoadMore:rect];
        
    }
    if ([self.reuseIdentifier isEqualToString:@"Topimg_msg_cell"])
    {
        [self drawRectForFirstCell:rect];

    }
    
}

-(void)drawRectLoadMore:(CGRect)rect
{
    if (loadMore)
    {
        [loadMore setFrame:CGRectMake(5, rect.size.height/2.0-10, rect.size.width-10, 30)];
        return;
    }
    loadMore = [[UILabel alloc]initWithFrame:CGRectMake(5, rect.size.height/2.0-10, rect.size.width-10, 30)];
    loadMore.layer.cornerRadius = 15;
    loadMore.clipsToBounds = YES;
    loadMore.backgroundColor = [UIColor whiteColor];
    loadMore.textAlignment = NSTextAlignmentCenter;
    loadMore.text = @"Load\nMore";
    [self addSubview:loadMore];
}

-(void)drawRectForFirstCell:(CGRect)rect
{
    //[super drawRect:rect];
    //[self.dispimage setHidden:YES];
    [self.authorname setHidden:YES];
    NSLog(@"the draw rect size is %@", NSStringFromCGRect(rect));
    [img_fav setFrame:CGRectMake(90,7.5, 20, 20)];
    [img_Share setFrame:CGRectMake(35,7.5, 20, 20)];
    [lbl_share setFrame:CGRectMake(10,7.5, 50, 20)];
    [lbl_favLbl setFrame:CGRectMake(115,7.5, 30, 20)];
    if (l_authorname)
    {
        [l_authorname setFrame:CGRectMake(5, 0, rect.size.width-10, 30)];
        [self displayValues];
        return;
    }
    
    l_authorname = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, rect.size.width-10, 30)];
    [l_authorname setTextAlignment:NSTextAlignmentCenter];
    [l_authorname setBackgroundColor:[UIColor colorWithRed:0.87 green:1.00 blue:1.00 alpha:1.0]];
    [l_authorname setFont:[UIFont boldSystemFontOfSize:18]];
    [l_authorname setTintColor:[UIColor blackColor]];
    [self addSubview:l_authorname];
    
    img_Share.image = [UIImage imageNamed:@"share.png"];
    //[self addSubview:img_Share];
    
    
    [lbl_share setTextAlignment:NSTextAlignmentLeft];
    [lbl_share setFont:[UIFont boldSystemFontOfSize:10]];
    [lbl_share setTintColor:[UIColor blackColor]];
    
    img_fav.image = [UIImage imageNamed:@"fav.png"];
    

    
    [lbl_favLbl setTextAlignment:NSTextAlignmentLeft];
    //[l_favLbl setBackgroundColor:[UIColor redColor]];
    [lbl_favLbl setFont:[UIFont boldSystemFontOfSize:10]];
    [lbl_favLbl setTintColor:[UIColor blackColor]];
    
    [self layoutIfNeeded];
    [self displayValues];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self insertSubview:bottomdisplay aboveSubview:self.authorname];
    [bottomdisplay setFrame:CGRectMake(5, self.bounds.size.height-35, self.bounds.size.width-10, 30)];
    
}

- (void) displayValues
{
    l_authorname.text = [[NSString alloc]initWithFormat:@"%@",[self.categorydict valueForKey:@"username"]];
    lbl_share.text = [[NSString alloc]initWithFormat:@"%@",[self.categorydict valueForKey:@"sms_shares"]];
    lbl_favLbl.text = [[NSString alloc]initWithFormat:@"%@",[self.categorydict valueForKey:@"sms_likes"]];
    
    NSString * l_currlink = [self.categorydict valueForKey:@"news_image"];
    self.dispimage.image = nil;
    [[smsAsyncImageFetch alloc]
     initDatawithFileName:l_currlink
     andReturnMethod:^(NSDictionary * p_returnInfo)
     {
         if ([[p_returnInfo valueForKey:@"linkname"]
              isEqualToString:l_currlink])
         {
             if ([p_returnInfo valueForKey:@"filename"])
             {
                 self.dispimage.image = [UIImage
                                   imageWithContentsOfFile:[p_returnInfo valueForKey:@"filename"]];
             }
         }
     }];
}

@end
