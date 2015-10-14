//
//  smsMainScrollView.h
//  tamilsms
//
//  Created by arun benjamin on 21/09/15.
//  Copyright (c) 2015 arun benjamin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "smsCategoryListTv.h"


@interface smsMainScrollView : UIScrollView

@property (nonatomic,weak) id<smsCategoriesListDelegate> txtMsgCategoriesDelegate;
@property (nonatomic,weak) id<smsCategoriesListDelegate> imgMsgCategoriesDelegate;

- (void)reloadTextCategoriesList;
- (void) reloadImageCategoriesList;

@end
