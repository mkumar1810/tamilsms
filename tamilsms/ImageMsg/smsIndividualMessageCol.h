//
//  smsIndividualMessageCol.h
//  tamilsms
//
//  Created by Mohan Kumar on 08/10/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "smsIndTxtMessages.h"

@interface individualImageMsgCell : UICollectionViewCell

@property (nonatomic) NSInteger cellPosnNo;
//-(void)showData;
-(void) setDisplayValues:(NSDictionary*)p_messageDict atPosn:(NSInteger) p_posnNo authorKey:(NSString*) p_authorKey imageKey:(NSString*) p_imageKey;

@end

@interface smsIndividualMessageCol : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegate, bottomNavigationViewDelegate>

@property(nonatomic,weak)id<indTxtMsgDelegate>popUpMessageDelegate;
- (id) initWithStartPosn:(NSInteger) p_startPosn authorKey:(NSString *)p_authorKey imageKey:(NSString *)p_imageKey;

@end
