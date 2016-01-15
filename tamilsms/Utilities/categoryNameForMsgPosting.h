//
//  categoryNameForMsgPosting.h
//  tamilsms
//
//  Created by arun benjamin on 21/11/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol categoryNameDelegate <NSObject>

-(void)categoryNameClickedForTheCell:(NSDictionary*)p_catInfo;
//-(void)categoryNameForImagePostingClickedForTheCell:(NSArray *)p_array;

@end

@interface cellForCategoryName : UITableViewCell
{
    UILabel *lbl_catname;
    NSDictionary * recivDict;
    NSInteger indexNum;
    
}
-(void)setCategoryNameDict:(NSDictionary*)p_catNameDict;
               //indexNo:(NSInteger)p_indexNum;
-(void)showData;

@end


@interface categoryNameForMsgPosting : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * catgTable;
    NSArray * _txtCategoryTitles;
}

@property(nonatomic,retain)id<categoryNameDelegate>categoryDelegate;
@end

