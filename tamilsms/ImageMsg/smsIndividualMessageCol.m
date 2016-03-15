//
//  smsIndividualMessageCol.m
//  tamilsms
//
//  Created by Mohan Kumar on 08/10/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import "smsIndividualMessageCol.h"
#import "smsAsyncImageFetch.h"
#import "smsCommonUtilities.h"
#import "smsRESTProxy.h"

@interface smsIndividualMessageCol()
{
    NSInteger _startPosn;
    NSInteger _currentPosn;
    NSInteger _noOfRecs;
    NSString * _authorKey, * _imageKey;
}

@end

@implementation smsIndividualMessageCol

- (id) initWithStartPosn:(NSInteger) p_startPosn authorKey:(NSString *)p_authorKey imageKey:(NSString *)p_imageKey
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
        _startPosn = p_startPosn;
        _authorKey = p_authorKey;
        _imageKey = p_imageKey;
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self registerClass:[individualImageMsgCell class] forCellWithReuseIdentifier:@"img_msg_cell"];
    }
    return self;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(self.bounds.size.width, self.bounds.size.height);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    _noOfRecs = [self.popUpMessageDelegate getNumberOfMessages];
    return _noOfRecs;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //[self.categoryMessageDelegate messageClickedForTheCell:indexPath.row];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * l_detailcellid = @"img_msg_cell";
    NSDictionary * l_imgmsgdict = [self.popUpMessageDelegate getIndividualMessageOfDict:indexPath.row];
    individualImageMsgCell * l_detailcell = [collectionView dequeueReusableCellWithReuseIdentifier:l_detailcellid forIndexPath:indexPath];
    [l_detailcell setDisplayValues:l_imgmsgdict atPosn:indexPath.row authorKey:_authorKey imageKey:_imageKey];
    _currentPosn = indexPath.row;
    return l_detailcell;
}

#pragma bottom view delegates implementation

- (void) moveToNextMessage
{
    if (_currentPosn==(_noOfRecs-1))
    {
        return;
    }
    _currentPosn++;
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentPosn inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

- (void) moveToPreviousMessage
{
    if (_currentPosn==0)
    {
        return;
    }
    _currentPosn--;
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentPosn inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

- (void)addCurrentToFavourite
{
    NSDictionary * l_imgmsgdict = [self.popUpMessageDelegate getIndividualMessageOfDict:_currentPosn];
//    NSLog(@"the image dict is %@", l_imgmsgdict);
    [smsCommonUtilities addSMSItemToFavourite:[l_imgmsgdict valueForKey:@"id"]];
}

- (void)removeCurrentFromFavourite
{
    NSDictionary * l_imgmsgdict = [self.popUpMessageDelegate getIndividualMessageOfDict:_currentPosn];
    //    NSLog(@"the image dict is %@", l_imgmsgdict);
    [smsCommonUtilities removeSMSItemToFavourite:[l_imgmsgdict valueForKey:@"id"]];
}

- (void)shareTheCurrentDisplayingItem
{
    
    NSDictionary * l_imgmsgdict = [self.popUpMessageDelegate getIndividualMessageOfDict:_currentPosn];
    NSString * l_currlink = [l_imgmsgdict valueForKey:@"msg_image"];
    [[smsAsyncImageFetch alloc]
     initDatawithFileName:l_currlink
     andReturnMethod:^(NSDictionary * p_returnInfo)
     {
         if ([p_returnInfo valueForKey:@"filename"])
         {
             NSURL * myimageurl = [NSURL fileURLWithPath:[p_returnInfo valueForKey:@"filename"]];
             
             NSArray *objectsToShare = @[myimageurl];
             
             UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
             
             NSArray *excludeActivities = @[];
             
             activityVC.excludedActivityTypes = excludeActivities;
             
             [[self.popUpMessageDelegate getParentNavController] presentViewController:activityVC animated:YES completion:^(){
                 [[smsRESTProxy alloc] initDatawithAPIType:@"SHARE_POST" andInputParams:@{@"item_id":[l_imgmsgdict valueForKey:@"id"]} andReturnMethod:NULL];
             }];
         }
     }];
}

@end

@interface individualImageMsgCell()
{
    UILabel * lb_userdetails, *lb_popUpUsrName;
    UIImageView * l_popupUserlogo, *img_popuimgage;
    NSDictionary * _msgDict;
    NSString * _authorKey, * _imageKey;
}

@end

@implementation individualImageMsgCell

-(void)drawRect:(CGRect)rect
{
    if (lb_userdetails)
    {
        [self displayValues];
        return;
    }
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
    
    img_popuimgage = [UIImageView new];
    img_popuimgage.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:img_popuimgage];
    [self addConstraints:@[[NSLayoutConstraint constraintWithItem:img_popuimgage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0],[NSLayoutConstraint constraintWithItem:img_popuimgage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0],[NSLayoutConstraint constraintWithItem:img_popuimgage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:(-30.0)],[NSLayoutConstraint constraintWithItem:img_popuimgage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:15.0f]]];
    [self layoutIfNeeded];
    [self displayValues];
}

-(void) setDisplayValues:(NSDictionary*)p_messageDict atPosn:(NSInteger) p_posnNo authorKey:(NSString*) p_authorKey imageKey:(NSString*) p_imageKey
{
    _msgDict = p_messageDict;
    _authorKey = p_authorKey;
    _imageKey = p_imageKey;
    //NSLog(@"the value obtained in table is %@",_categorydata);
    if (img_popuimgage) {
        [self displayValues];
    }
}

- (void) displayValues
{
    lb_userdetails.text = [[NSString alloc]initWithFormat:@"%@",[_msgDict valueForKey:_authorKey]];
    //[[NSString alloc]initWithFormat:@"%@",[_msgDict valueForKey:@"author"]];
    NSString * l_currlink = [_msgDict valueForKey:_imageKey];
    //[_msgDict valueForKey:@"msg_image"];
    img_popuimgage.image = nil;
    [[smsAsyncImageFetch alloc]
     initDatawithFileName:l_currlink
     andReturnMethod:^(NSDictionary * p_returnInfo)
     {
         if ([[p_returnInfo valueForKey:@"linkname"]
              isEqualToString:l_currlink])
         {
             if ([p_returnInfo valueForKey:@"filename"])
             {
                 img_popuimgage.image = [UIImage
                                   imageWithContentsOfFile:[p_returnInfo valueForKey:@"filename"]];
             }
         }
     }];
}

@end