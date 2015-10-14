//
//  textMessageForCategoryListTv.h
//  tamilsms
//
//  Created by Mohan Kumar on 12/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol textMessageForCategoryDelegate <NSObject>

-(NSDictionary*) getMessageFromArray:(NSInteger) p_posnNo;
-(NSInteger)getMessageCount;
-(void)messageClickedForTheCell:(NSInteger)p_positno;



@end

@interface messageForCell : UITableViewCell
{
    
}

- (void) setDisplayData:(NSDictionary*) p_displayDict;
- (void) displayValues;


@end

@interface textMessageForCategoryListTv : UITableView <UITableViewDataSource,UITableViewDelegate>
{
    //UITableView * textmsgtable;
}
@property(nonatomic,retain)id<textMessageForCategoryDelegate>categoryMessageDelegate;

- (void) reloadCategoriesListMessages;


@end
