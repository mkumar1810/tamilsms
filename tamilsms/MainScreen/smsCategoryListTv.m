//
//  smsCategoryListTv.m
//  tamilsms
//
//  Created by Mohan Kumar on 21/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import "smsCategoryListTv.h"

@interface smsCategoryListTv() <UITableViewDataSource,UITableViewDelegate>

@end


@implementation smsCategoryListTv

- (void)awakeFromNib
{
    self.dataSource = self;
    self.delegate = self;
    [self setScrollEnabled:YES];
    [self setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self setSeparatorColor:[UIColor clearColor]];
}

- (void) reloadCategoriesList
{
    [self reloadData];
}


@end





