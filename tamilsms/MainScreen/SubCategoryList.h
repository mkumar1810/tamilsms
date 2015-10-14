//
//  SubCategoryList.h
//  tamilsms
//
//  Created by Mohan Kumar on 13/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SubCategoryListDelegate <NSObject>

-(NSInteger)getMessageSubCategoryCount;
-(NSDictionary*) getSubCategoryListFromArray:(NSInteger) p_posnNo;
- (void) showTextMessagesForSubcategoryAtPosn:(NSInteger) p_posnNO;

@end

@interface ValuesForSubCategoryCell : UITableViewCell
{
    UILabel * lbl_name;
    UIImageView * myimage;
    NSInteger l_width, _margin;
    NSArray * _arrayvalue;
    NSDictionary * _categorydata;
}
- (void) setDisplayData:(NSDictionary*) p_displayDict;
- (void) displayValues;
- (void) animateSelectedCell;
- (void) removeAnimationFromCell;



@end


@interface SubCategoryList : UITableView <UITableViewDataSource,UITableViewDelegate>
{
    
}
@property(nonatomic,retain)id<SubCategoryListDelegate>SubCategoryadelegate;
-(void)reloadCategoriesList;

@end
