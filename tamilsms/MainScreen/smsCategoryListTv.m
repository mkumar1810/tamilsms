//
//  smsCategoryListTv.m
//  tamilsms
//
//  Created by arun benjamin on 21/09/15.
//  Copyright (c) 2015 arun benjamin. All rights reserved.
//

#import "smsCategoryListTv.h"

@interface smsCategoryListTv() <UITableViewDataSource,UITableViewDelegate>
{
    NSString * _msgType;
}

//@property (nonatomic,strong) UITableView  * categoryTable;

@end


@implementation smsCategoryListTv

- (id) initWithMessageType:(NSString*) p_msgType
{
    self = [super initWithFrame:CGRectZero style:UITableViewStylePlain];
    if (self)
    {
        //
        _msgType = p_msgType;
        self.dataSource = self;
        self.delegate = self;
        [self setScrollEnabled:YES];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [self setSeparatorColor:[UIColor clearColor]];
    }
    return self;
}


- (void) reloadCategoriesList
{
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataDelegate getNumberOfCategoriesOfMsgType:_msgType];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    smsCategoryTVCell * l_selcell = (smsCategoryTVCell*) [self cellForRowAtIndexPath:indexPath];
    [l_selcell removeAnimationFromCell];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    smsCategoryTVCell * l_selcell = (smsCategoryTVCell*) [self cellForRowAtIndexPath:indexPath];
    [l_selcell animateSelectedCell];
    [self.dataDelegate categoryIdClickedForTheCell:indexPath.row ofMsgType:_msgType];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString * l_CellIdentifier = @"categorytitle_cellid";
    
    NSString * l_reqdcellid = l_CellIdentifier;
    
    smsCategoryTVCell * l_newcell = (smsCategoryTVCell*)  [tableView dequeueReusableCellWithIdentifier:l_reqdcellid];
    if (l_newcell == nil)
    {
        l_newcell = [[smsCategoryTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:l_reqdcellid];
    }
    [l_newcell setDisplayData:[self.dataDelegate getCategoryDataFromArray:indexPath.row ofMsgType:_msgType]];
    l_newcell.contentView.backgroundColor = [UIColor colorWithRed:0.25 green:0.53 blue:0.59 alpha:1.0];
    return l_newcell;
}

@end



@implementation smsCategoryTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [self drawRectfirst:rect];
    UIView * l_selectedview = [UIView new];
    [l_selectedview setBackgroundColor:[UIColor clearColor]];
    //[self setSelectedBackgroundView:l_selectedview];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

-(void)drawRectfirst:(CGRect)rect
{
    CGFloat  _width = rect.size.width;
    _margin = 5;
    l_width = _width - 2*_margin;
    
    if (lbl_name) {
        //[lbl_name setFrame:CGRectMake(_margin, rect.size.height - 35, l_width,rect.size.height-120)];
        //[myimage setFrame:CGRectMake(_margin, 0, l_width, rect.size.height-_margin)];
        return;
    }
    
    myimage =[UIImageView new];
    myimage.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:myimage];
    
    lbl_name = [UILabel new];
    [lbl_name setTextColor:[UIColor whiteColor]];
    [lbl_name setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
    [lbl_name setTextAlignment:NSTextAlignmentCenter];
    [lbl_name setFont:[UIFont systemFontOfSize:17]];
    lbl_name.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_name];
    [self displayValues];
    
    // Width constraint,
    [self addConstraint:[NSLayoutConstraint constraintWithItem:myimage
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0 constant:(-2*_margin)]];
    
    
    // Height constraint,
    [self addConstraint:[NSLayoutConstraint constraintWithItem:myimage
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1.0
                                                      constant:(-_margin)]];
    
    // Center horizontally
    [self addConstraint:[NSLayoutConstraint constraintWithItem:myimage
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    // Center vertically
    [self addConstraint:[NSLayoutConstraint constraintWithItem:myimage
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:(-_margin/2.0)]];
    
    
    
    // Width constraint,
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_name
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0 constant:(-2*_margin)]];
    
    
    
    // Height constraint,
    /*[self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_name
     attribute:NSLayoutAttributeHeight
     relatedBy:NSLayoutRelationEqual
     toItem:self
     attribute:NSLayoutAttributeHeight
     multiplier:1.0
     constant:0]];*/
    [lbl_name addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[name(30)]" options:0 metrics:nil views:@{@"name":lbl_name}]];
    
    // Center horizontally
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_name
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    // Center vertically
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_name
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:2.0
                                                      constant:(-_margin-30/2.0)]];
    
}

- (void) setDisplayData:(NSDictionary*) p_displayDict
{
    _categorydata = [p_displayDict copy];
    if (lbl_name) {
        [self displayValues];
    }
    
}
//displaying (text mesage) category name and image
- (void) displayValues
{
    if ([[_categorydata valueForKey:@"cid"]integerValue] > 100)
    {
        lbl_name.text = [[NSString alloc]initWithFormat:@"%@ -->",[_categorydata valueForKey:@"category_name"]];
    }
    else
    {
        lbl_name.text = [[NSString alloc]initWithFormat:@"%@ (%@)",[_categorydata valueForKey:@"category_name"],[_categorydata valueForKey:@"category_count"]];
    }
    //NSLog(@"frame value for imageview is:%@", NSStringFromCGRect(myimage.frame));
    //NSLog(@"frame value for label is:%@", NSStringFromCGRect(lbl_name.frame));
    
    
    [myimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"cat%ld.jpg",(long)[[_categorydata valueForKey:@"cid"] integerValue]]]];
    [self removeAnimationFromCell];
}

- (void) animateSelectedCell
{
    [self.layer setBorderColor:[UIColor colorWithRed:0.85 green:1.00 blue:1.00 alpha:1.0].CGColor];
    [self.layer setBorderWidth:5.0f];
    
}

- (void) removeAnimationFromCell
{
    [self.layer setBorderColor:[UIColor clearColor].CGColor];
    [self.layer setBorderWidth:0.0f];
    
}

@end


