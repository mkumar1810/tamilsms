//
//  smsMainScrollView.m
//  tamilsms
//
//  Created by arun benjamin on 21/09/15.
//  Copyright (c) 2015 arun benjamin. All rights reserved.
//

#import "smsMainScrollView.h"

@interface smsMainScrollView()
{
    
}

@property (nonatomic,strong) smsCategoryListTv * txtCategoriesListVw;
@property (nonatomic,strong) smsCategoryListTv * imgCategoriesListVw;


@end

@implementation smsMainScrollView

- (instancetype)init
{
    self = [super init];
    if (self) {
        //
        [self setScrollEnabled:YES];
        [self setPagingEnabled:YES];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.txtCategoriesListVw = [[smsCategoryListTv alloc] initWithMessageType:@"txt"];
     self.txtCategoriesListVw.translatesAutoresizingMaskIntoConstraints = NO;
    self.txtCategoriesListVw.dataDelegate = self.txtMsgCategoriesDelegate;
     [self addSubview:self.txtCategoriesListVw];
     //[self.categoriesListVw setHidden:YES];
     [self addConstraints:@[[NSLayoutConstraint constraintWithItem:self.txtCategoriesListVw attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.txtCategoriesListVw attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.txtCategoriesListVw attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.txtCategoriesListVw attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]]];

    self.imgCategoriesListVw = [[smsCategoryListTv alloc] initWithMessageType:@"img"];
    self.imgCategoriesListVw.translatesAutoresizingMaskIntoConstraints = NO;
    self.imgCategoriesListVw.dataDelegate = self.txtMsgCategoriesDelegate;
    [self addSubview:self.imgCategoriesListVw];
    //[self.categoriesListVw setHidden:YES];
    [self addConstraints:@[[NSLayoutConstraint constraintWithItem:self.imgCategoriesListVw attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.imgCategoriesListVw attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:3.0 constant:0],[NSLayoutConstraint constraintWithItem:self.imgCategoriesListVw attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0],[NSLayoutConstraint constraintWithItem:self.imgCategoriesListVw attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]]];
    
    
    [self layoutIfNeeded];
    [self setContentSize:CGSizeMake(rect.size.width*2.0, rect.size.height)];
}
-(void)reloadTextCategoriesList
{
    [self.txtCategoriesListVw reloadCategoriesList];
}

- (void) reloadImageCategoriesList
{
    [self.imgCategoriesListVw reloadCategoriesList];
}

@end
