//
//  smsImageMessages.m
//  tamilsms
//
//  Created by Mohan Kumar on 23/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import "smsImageMessages.h"
#import "smsAsyncImageFetch.h"

@interface smsImageMessages()
{
    NSMutableParagraphStyle * _txtmsgstyle;
}

@end
@implementation smsImageMessages

- (void)awakeFromNib
{
    UICollectionViewFlowLayout *  l_reqdLayout = [[UICollectionViewFlowLayout alloc] init];
    [self setCollectionViewLayout:l_reqdLayout];
    l_reqdLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    l_reqdLayout.footerReferenceSize = CGSizeZero;
    l_reqdLayout.minimumInteritemSpacing = 0;
    l_reqdLayout.minimumLineSpacing = 0;
    l_reqdLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.dataSource = self;
    self.delegate = self;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    [self registerClass:[imageMessageForCell class] forCellWithReuseIdentifier:@"img_msg_cell"];
}

- (instancetype)init
{
    UICollectionViewFlowLayout *  l_reqdLayout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithFrame:CGRectZero collectionViewLayout:l_reqdLayout];
    l_reqdLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    l_reqdLayout.footerReferenceSize = CGSizeZero;
    l_reqdLayout.minimumInteritemSpacing = 0;
    l_reqdLayout.minimumLineSpacing = 0;
    l_reqdLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    if (self) {
        //
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self registerClass:[imageMessageForCell class] forCellWithReuseIdentifier:@"img_msg_cell"];
    }
    return self;
}
-(void)reloadCategoriesListMessages
{
    [self reloadData];
}

/*
 - (void)updateConstraints
 {
 [self reloadData];
 //[super updateConstraints];
 }
 */

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize l_reqdsize = CGSizeZero;
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {
        l_reqdsize = CGSizeMake(self.bounds.size.width/2.0, self.bounds.size.width/2.0);
    }
    else
    {
        l_reqdsize = CGSizeMake(self.bounds.size.width/3.0, self.bounds.size.width/3.0);
    }
    //NSLog(@"the size returned %@", NSStringFromCGSize(l_reqdsize));
    return l_reqdsize;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_categoryMessageDelegate getImageMessageCount];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.categoryMessageDelegate imgMsgClickedForTheCell:indexPath.row];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * l_detailcellid = @"img_msg_cell";
    NSDictionary * l_imgmsgdict = [_categoryMessageDelegate getImageMsgDictAtPosn:indexPath.row];
    imageMessageForCell * l_detailcell = [collectionView dequeueReusableCellWithReuseIdentifier:l_detailcellid forIndexPath:indexPath];
    [l_detailcell setDisplayData:l_imgmsgdict];
    return l_detailcell;
}

@end
@interface imageMessageForCell()
{
    UILabel * l_username;
    UIImageView * l_images ;
    NSArray * _array;
    NSDictionary * _categorydata;
}

@end

@implementation imageMessageForCell

@synthesize authorname = l_username, dispimage = l_images, categorydict = _categorydata;

-(void)drawRect:(CGRect)rect
{
    
    if (l_images)
    {
        //[l_images setFrame:CGRectMake(5, 5, rect.size.width-10, rect.size.height-10)];
        // [l_username setFrame:CGRectMake(5, rect.size.height-35, rect.size.width-10, 30)];
        [self displayValues];
        return;
    }
    
    /* UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
     [indicator startAnimating];
     [indicator setCenter:self.center];
     [self.contentView addSubview:indicator];*/
    
    //l_images = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, rect.size.width-10, rect.size.height-10)];
    l_images = [UIImageView new];
    [l_images setBackgroundColor:[UIColor lightGrayColor]];
    l_images.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:l_images];
    [self addConstraints:@[[NSLayoutConstraint constraintWithItem:l_images attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-10],[NSLayoutConstraint constraintWithItem:l_images attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:l_images attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:-10],[NSLayoutConstraint constraintWithItem:l_images attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]]];
    
    
    
    
    //l_username = [[UILabel alloc]initWithFrame:CGRectMake(5, rect.size.height-35, rect.size.width-10, 30)];
    l_username = [UILabel new];
    l_username.translatesAutoresizingMaskIntoConstraints = NO;
    [l_username setTextAlignment:NSTextAlignmentCenter];
    [l_username setBackgroundColor:[UIColor colorWithRed:0.87 green:1.00 blue:1.00 alpha:1.0]];
    [l_username setFont:[UIFont boldSystemFontOfSize:18]];
    [l_username setTintColor:[UIColor blackColor]];
    //l_username.alpha = .90;
    [self addSubview:l_username];
    [self displayValues];
    
    [self addConstraints:@[[NSLayoutConstraint constraintWithItem:l_username attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-10],[NSLayoutConstraint constraintWithItem:l_username attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:(-5)]]];
    
    [l_username addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[UN(30)]" options:0 metrics:nil views:@{@"UN":l_username}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[UN]" options:0 metrics:nil views:@{@"UN":l_username}]];
    
    [self layoutIfNeeded];
    
    //NSLog(@"frame value for label is:%@", NSStringFromCGRect(l_username.frame));
}

- (void) setDisplayData:(NSDictionary*) p_displayDict
{
    _categorydata = p_displayDict;
    //NSLog(@"the value obtained in table is %@",_categorydata);
    if (l_images) {
        [self displayValues];
    }
}
- (void) displayValues
{
    l_username.text = [[NSString alloc]initWithFormat:@"%@",[_categorydata valueForKey:@"author"]];
    NSString * l_currlink = [_categorydata valueForKey:@"msg_image"];
    l_images.image = nil;
    [[smsAsyncImageFetch alloc]
     initDatawithFileName:l_currlink
     andReturnMethod:^(NSDictionary * p_returnInfo)
     {
         if ([[p_returnInfo valueForKey:@"linkname"]
              isEqualToString:l_currlink])
         {
             if ([p_returnInfo valueForKey:@"filename"])
             {
                 l_images.image = [UIImage
                                   imageWithContentsOfFile:[p_returnInfo valueForKey:@"filename"]];
             }
         }
     }];
}

@end
