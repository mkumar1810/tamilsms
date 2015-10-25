//
//  SubCategoryList.m
//  tamilsms
//
//  Created by Mohan Kumar on 13/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import "SubCategoryList.h"

@implementation SubCategoryList
- (instancetype)init
{
    self = [super initWithFrame:CGRectZero style:UITableViewStylePlain];
    if (self) {
        //
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

-(void)reloadCategoriesList
{
    [self reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return[self.SubCategoryadelegate getMessageSubCategoryCount];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ValuesForSubCategoryCell * l_nwcell = (ValuesForSubCategoryCell*) [self cellForRowAtIndexPath:indexPath];
    [l_nwcell removeAnimationFromCell];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ValuesForSubCategoryCell * l_nwcell = (ValuesForSubCategoryCell*) [self cellForRowAtIndexPath:indexPath];
    [l_nwcell animateSelectedCell];
    [self.SubCategoryadelegate showTextMessagesForSubcategoryAtPosn:indexPath.row];
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * l_CellIdentifier = @"sampleCell";
    NSDictionary * l_dictvalur = [self.SubCategoryadelegate getSubCategoryListFromArray:indexPath.row];
    
    ValuesForSubCategoryCell * l_cell = (ValuesForSubCategoryCell*) [tableView dequeueReusableCellWithIdentifier:l_CellIdentifier];
    if (l_cell == nil)
    {
        l_cell = [[ValuesForSubCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:l_CellIdentifier];
    }
    [l_cell setDisplayData:l_dictvalur];
    [l_cell setBackgroundColor:[UIColor colorWithRed:0.25 green:0.53 blue:0.59 alpha:1.0]];
    return l_cell;
}


@end

@implementation ValuesForSubCategoryCell

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
        //[lbl_name setFrame:CGRectMake(_margin, rect.size.height - 35, l_width,30)];
        //[myimage setFrame:CGRectMake(_margin, 0, l_width, rect.size.height-_margin)];
        return;
    }
    
    //myimage =[[UIImageView alloc]initWithFrame:CGRectMake(_margin, 0, l_width, rect.size.height-_margin)];
    myimage = [UIImageView new];
    myimage.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:myimage];
    
    //lbl_name = [[UILabel alloc]initWithFrame:CGRectMake(_margin, rect.size.height-35 , l_width,30)];
    lbl_name = [UILabel new];
    [lbl_name setTextColor:[UIColor whiteColor]];
    [lbl_name setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
    [lbl_name setTextAlignment:NSTextAlignmentCenter];
    lbl_name.translatesAutoresizingMaskIntoConstraints = NO;
    [lbl_name setFont:[UIFont systemFontOfSize:17]];
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
    
    //Heighr constrain.
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
    lbl_name.text = [[NSString alloc]initWithFormat:@"%@ (%@)",[_categorydata valueForKey:@"category_name"],[_categorydata valueForKey:@"category_count"]];

    [myimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"cat%ld.jpg",(long)[[_categorydata valueForKey:@"cid"] integerValue]]]];
    [self removeAnimationFromCell];
}

- (void) animateSelectedCell
{
    [self.layer setBorderColor:[UIColor colorWithRed:0.71 green:0.65 blue:0.84 alpha:1.0].CGColor];
    [self.layer setBorderWidth:5.0f];
}

- (void) removeAnimationFromCell
{
    [self.layer setBorderColor:[UIColor clearColor].CGColor];
    [self.layer setBorderWidth:0.0f];
    
}

@end