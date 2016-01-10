//
//  smsCategoryListTv.h
//  tamilsms
//
//  Created by Mohan Kumar on 21/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol smsCategoriesListDelegate <NSObject>

-(NSInteger)getNumberOfCategories;
-(NSDictionary*) getCategoryDataFromArray:(NSInteger) p_posnNo;
-(void)categoryIdClickedForTheCell:(NSInteger)p_positno;

@end

@interface smsCategoryListTv : UITableView

@property (nonatomic,retain) id<smsCategoriesListDelegate> dataDelegate;

- (void) reloadCategoriesList;

@end

