//
//  smsCategoryListTv.h
//  tamilsms
//
//  Created by Mohan Kumar on 21/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol smsCategoriesListDelegate <NSObject>

-(NSInteger)getNumberOfCategoriesOfMsgType:(NSString*) p_msgType;
-(NSDictionary*) getCategoryDataFromArray:(NSInteger) p_posnNo ofMsgType:(NSString*) p_msgType;
-(void)categoryIdClickedForTheCell:(NSInteger)p_positno ofMsgType:(NSString*) p_msgType;

@end

@interface smsCategoryListTv : UITableView
{
    
}
@property (nonatomic,weak) id<smsCategoriesListDelegate> dataDelegate;

- (id) initWithMessageType:(NSString*) p_msgType;

- (void) reloadCategoriesList;

@end

@interface smsCategoryTVCell : UITableViewCell
{
@private
    UILabel * lbl_name;
    UIImageView * myimage;
    NSInteger l_width, _margin;
    NSArray * _arrayvalue;
    NSDictionary * _categorydata;
}

- (void)drawRectfirst:(CGRect)rect;
- (void) setDisplayData:(NSDictionary*) p_displayDict;
- (void) displayValues;
- (void) animateSelectedCell;
- (void) removeAnimationFromCell;

@end