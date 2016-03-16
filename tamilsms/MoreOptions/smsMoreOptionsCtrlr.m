//
//  smsMoreOptionsCtrlr.m
//  tamilsms
//
//  Created by Mohan Kumar on 22/01/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import "smsMoreOptionsCtrlr.h"

@interface smsMoreOptionsCtrlr ()
{
    NSArray * catgryName;
    NSArray * _optionsList;
    NSArray * _optionListImages;
}

@end

@implementation smsMoreOptionsCtrlr
@synthesize hideStatusBar,navigateParams, transitionType;

static NSString * const reuseIdentifier = @"Cell";

- (void)awakeFromNib
{
    self.transitionType = noanimation;
    _optionsList = [NSArray arrayWithObjects:@"FAVOURITE",@"TOP 25 AUTHORS",@"LATEST MSG",@"LATEST IMAGE",@"TOP SHARED MSG",@"TOP SHARED IMAGES",@"TOP FAV MSG",@"TOP FAV IMAGES",@"DOWNLOAD TAMIL NEWS",@"INFO", nil];
    
    _optionListImages = [NSArray arrayWithObjects:@"top_shared1",@"top_shared1",@"top_shared1",@"top_shared1",@"top_liked2",@"top_liked2",@"top_liked2",@"top_shared",@"top_shared",@"top_shared", nil];
    [self.collectionView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.collectionView registerClass:[smsCellForMoreOption class] forCellWithReuseIdentifier:@"img_msg_cell"];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
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
        l_reqdsize = CGSizeMake(self.view.bounds.size.width/2.0-4, self.view.bounds.size.width/2.0-4);
    }
    else
    {
        l_reqdsize = CGSizeMake(self.view.bounds.size.height/2.0-4, self.view.bounds.size.height/2.0-4);
    }
    //NSLog(@"the size returned %@", NSStringFromCGSize(l_reqdsize));
    return l_reqdsize;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
    // return [_categoryMessageDelegate getMessageCount];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //[self.categoryMessageDelegate messageClickedForTheCell:indexPath.row];
    if (indexPath.row==0)
    {
        [self performSegueWithIdentifier:@"smsFavourite" sender:self];
    }
    else if (indexPath.row==1)
    {
        [self performSegueWithIdentifier:@"showtop25authors" sender:self];
    }
    else if (indexPath.row==2)
    {
        [self performSegueWithIdentifier:@"latestMsgSegue" sender:self];
    }
    else if (indexPath.row==3)
    {
        [self performSegueWithIdentifier:@"smsLatstImgSeg" sender:self];
    }
    else if (indexPath.row==4)
    {
        [self performSegueWithIdentifier:@"topSharedMsgSeg" sender:self];
    }
    else if (indexPath.row==5)
    {
        [self performSegueWithIdentifier:@"TopSharImgSeg" sender:self];
    }
    else if (indexPath.row==6)
    {
        [self performSegueWithIdentifier:@"topFavSeg" sender:self];
    }
    else if (indexPath.row==7)
    {
        [self performSegueWithIdentifier:@"topFavImgSeg" sender:self];
    }
    else if (indexPath.row==9)
    {
        //showinfoscreen
        self.navigateParams = @{@"opselected":@"Info"};
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"showinfoscreen" sender:self];
        });
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * l_detailcellid = @"img_msg_cell";
    // NSDictionary * l_imgmsgdict = [_categoryMessageDelegate getMessageFromArray:indexPath.row];
    NSString * optionName = [_optionsList objectAtIndex:indexPath.row];
    NSString * optionImage = [_optionListImages objectAtIndex:indexPath.row];
    smsCellForMoreOption * l_detailcell = [collectionView dequeueReusableCellWithReuseIdentifier:l_detailcellid forIndexPath:indexPath];
    //[l_detailcell setDisplayData:l_imgmsgdict];
    [l_detailcell setDisplayData:optionName andImgName:optionImage];
    return l_detailcell;
}

@end

@implementation smsCellForMoreOption
-(void)drawRect:(CGRect)rect
{
    
    if (l_catName)
    {
        [self displayValues];
        return;
    }
    l_images = [UIImageView new];
    [l_images setBackgroundColor:[UIColor clearColor]];
    // l_images.image = [UIImage imageNamed:@"top_shared1"];
    l_images.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:l_images];
    [self addConstraints:@[[NSLayoutConstraint constraintWithItem:l_images attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-10],[NSLayoutConstraint constraintWithItem:l_images attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:l_images attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:-10],[NSLayoutConstraint constraintWithItem:l_images attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]]];
    
    l_catName = [UILabel new];
    l_catName.translatesAutoresizingMaskIntoConstraints = NO;
    [l_catName setTextAlignment:NSTextAlignmentCenter];
    //[l_catName setBackgroundColor:[UIColor colorWithRed:0.87 green:1.00 blue:1.00 alpha:1.0]];
    [l_catName setBackgroundColor:[UIColor clearColor]];
    //l_catName.text = @"topShared";
    [l_catName setFont:[UIFont boldSystemFontOfSize:13]];
    [l_catName setTintColor:[UIColor blackColor]];
    [self addSubview:l_catName];
    
    
    [self addConstraints:@[[NSLayoutConstraint constraintWithItem:l_catName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-10],[NSLayoutConstraint constraintWithItem:l_catName attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:(-5)]]];
    
    [l_catName addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[UN(30)]" options:0 metrics:nil views:@{@"UN":l_catName}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[UN]" options:0 metrics:nil views:@{@"UN":l_catName}]];
    
    [self layoutIfNeeded];
    [self displayValues];
}

- (void) setDisplayData:(NSString*) p_cellTitle andImgName:(NSString*) p_optionImg
{
    _arayOptionList = p_cellTitle;
    _arayOptionimg = p_optionImg;
    //NSLog(@"the value obtained in table is %@",_arayOptionList);
    if (l_catName) {
        [self displayValues];
    }
}
-(void)displayValues
{
    l_catName.text = [[NSString alloc]initWithFormat:@"%@",_arayOptionList];
    NSString * l_filename = [[NSBundle mainBundle] pathForResource:_arayOptionimg ofType:@"png"];
//    NSLog(@"the recived file naame is %@",l_filename);
    l_images.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:l_filename]];
//    NSLog(@"the recived text value is %@",l_images.image);
}
@end
