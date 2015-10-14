//
//  smsImageMessages.h
//  tamilsms
//
//  Created by arun benjamin on 23/09/15.
//  Copyright (c) 2015 arun benjamin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol imageMessageForCategoryDelegate <NSObject>

-(NSDictionary*) getMessageFromArray:(NSInteger) p_posnNo;
-(NSInteger)getMessageCount;
-(void)messageClickedForTheCell:(NSInteger)p_positno;

@end

@interface imageMessageForCell : UICollectionViewCell
{
    
}

- (void) setDisplayData:(NSDictionary*) p_displayDict;
- (void) displayValues;


@end

@interface smsImageMessages : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegate>
{
    
}
@property(nonatomic,retain)id<imageMessageForCategoryDelegate>categoryMessageDelegate;

- (void) reloadCategoriesListMessages;

@end


