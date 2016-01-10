//
//  smsBaseCategoriesCtrlr.h
//  tamilsms
//
//  Created by Mohan Kumar on 27/12/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import "smsBaseController.h"

@interface smsBaseCategoriesCtrlr : UITableViewController <smsCustNaviDelegates>
{
    NSArray * _categoriesList;
}

-(void)categoryIdClickedForTheCell:(NSInteger)p_positno;

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

- (void) drawRectfirst:(CGRect)rect;
- (void) setDisplayData:(NSDictionary*) p_displayDict;
- (void) displayValues;
- (void) animateSelectedCell;
- (void) removeAnimationFromCell;

@end