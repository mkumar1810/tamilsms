//
//  smsLocalStore.h
//  tamilsms
//
//  Created by Mohan Kumar on 10/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface smsLocalStore : NSObject

+ (void) getDBOpened;

-(NSArray*)getMainCategoryTitlesForTxtMsgs;
-(NSArray*)getMainCategoryTitlesForImgMsgs;
-(NSArray*)getTextMsgForCategory:(NSInteger) p_categoryId;
-(NSArray*)getImageMsgForCategory:(NSInteger) p_categoryId;
-(NSArray*)getTextSubCategoryForMainCaregory:(NSInteger) p_maincategoryId;
-(NSArray*)getImageSubCategoryForMainCaregory:(NSInteger) p_maincategoryId;
- (NSDictionary*) getSyncParamsFromDB;
- (void) updateParsedDatasIntoDatabase:(NSDictionary*) p_payData;

@end
