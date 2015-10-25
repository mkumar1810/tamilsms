//
//  smsIndividualMessageCol.m
//  tamilsms
//
//  Created by Mohan Kumar on 08/10/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import "smsIndividualMessageCol.h"
#import "smsAsyncImageFetch.h"

@interface smsIndividualMessageCol()
{
    NSInteger _startPosn;
    NSInteger _currentPosn;
}

@end

@implementation smsIndividualMessageCol

-(instancetype)init
{
    UICollectionViewFlowLayout *  l_reqdLayout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithFrame:CGRectZero collectionViewLayout:l_reqdLayout];
    l_reqdLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    l_reqdLayout.footerReferenceSize = CGSizeZero;
    l_reqdLayout.minimumInteritemSpacing = 0;
    l_reqdLayout.minimumLineSpacing = 0;
    l_reqdLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    //self = [super init];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;

    }
    return self;
}


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
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //[self.categoryMessageDelegate messageClickedForTheCell:indexPath.row];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * l_detailcellid = @"img_msg_cell";
    //NSDictionary * l_imgmsgdict = [_categoryMessageDelegate getMessageFromArray:indexPath.row];
    individualImageMsgCell * l_detailcell = [collectionView dequeueReusableCellWithReuseIdentifier:l_detailcellid forIndexPath:indexPath];
    //[l_detailcell setDisplayData:l_imgmsgdict];
    return l_detailcell;
}
@end

@interface individualImageMsgCell()
{
    UILabel * lb_userdetails, *lb_popUpUsrName;
    UIImageView * l_popupUserlogo, *img_popuimgage;
}

@end

@implementation individualImageMsgCell

-(void)drawRect:(CGRect)rect
{
    lb_userdetails = [UILabel new];
    //lb_userdetails = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, 30)];
    [lb_userdetails setBackgroundColor:[UIColor colorWithRed:0.09 green:0.21 blue:0.40 alpha:1.0]];
    [lb_userdetails setTextAlignment:NSTextAlignmentCenter];
    [lb_userdetails setTextColor:[UIColor whiteColor]];
    lb_userdetails.translatesAutoresizingMaskIntoConstraints = NO;
    [lb_userdetails setFont:[UIFont systemFontOfSize:17]];
    [self addSubview:lb_userdetails];
    
    // Width constraint,
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lb_userdetails
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0 constant:0]];
    
    //Heighr constrain.
    [lb_userdetails addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[name(30)]" options:0 metrics:nil views:@{@"name":lb_userdetails}]];
    
    // Center horizontally
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lb_userdetails
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    [lb_userdetails addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[name(30)]" options:0 metrics:nil views:@{@"name":lb_userdetails}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[name]" options:0 metrics:nil views:@{@"name":lb_userdetails}]];
    
    
    l_popupUserlogo = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, rect.size.width/18.0+5, 30-5)];
    [l_popupUserlogo setImage:[UIImage imageNamed:@"title_qoute_icon.png"]];
    [self addSubview:l_popupUserlogo];
    
    lb_popUpUsrName = [[UILabel alloc]initWithFrame:CGRectMake(rect.size.width/10.0, 0, rect.size.width, 30)];
    [lb_popUpUsrName setTextColor:[UIColor blueColor]];
    [lb_popUpUsrName setNumberOfLines:0];
    [lb_popUpUsrName setTextColor:[UIColor whiteColor]];
    [lb_popUpUsrName setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:lb_popUpUsrName];
    
    
    img_popuimgage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, rect.size.width, rect.size.height-30)];
    
    [self addSubview:img_popuimgage];
    
}

@end