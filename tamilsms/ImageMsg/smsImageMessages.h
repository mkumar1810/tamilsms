//
//  smsImageMessages.h
//  tamilsms
//
//  Created by Mohan Kumar on 23/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol imageMessageForCategoryDelegate <NSObject>

-(NSDictionary*) getImageMsgDictAtPosn:(NSInteger) p_posnNo;
-(NSInteger)getImageMessageCount;
-(void)imgMsgClickedForTheCell:(NSInteger)p_positno;

@end

@interface imageMessageForCell : UICollectionViewCell
{
    
}

@property (nonatomic,strong) UILabel * authorname;
@property (nonatomic,strong) UIImageView * dispimage ;
@property (nonatomic,strong) NSDictionary * categorydict;

- (void) setDisplayData:(NSDictionary*) p_displayDict;
- (void) displayValues;


@end

@interface smsImageMessages : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegate>
{
    
}
@property(nonatomic,retain) IBOutlet id<imageMessageForCategoryDelegate>categoryMessageDelegate;

- (void) reloadCategoriesListMessages;

@end


