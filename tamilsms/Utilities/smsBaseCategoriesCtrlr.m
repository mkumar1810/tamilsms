//
//  smsBaseCategoriesCtrlr.m
//  tamilsms
//
//  Created by Mohan Kumar on 27/12/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import "smsBaseCategoriesCtrlr.h"

@interface smsBaseCategoriesCtrlr ()

@end

@implementation smsBaseCategoriesCtrlr
@synthesize transitionType, navigateParams, hideStatusBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_categoriesList count];
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
    smsCategoryTVCell * l_selcell = (smsCategoryTVCell*) [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    [l_selcell removeAnimationFromCell];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    smsCategoryTVCell * l_selcell = (smsCategoryTVCell*) [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    [l_selcell animateSelectedCell];
    [self categoryIdClickedForTheCell:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString * l_CellIdentifier = @"categorytitle_cellid";
    
    NSString * l_reqdcellid = l_CellIdentifier;
    
    NSDictionary * l_reqdDict = [_categoriesList objectAtIndex:indexPath.row];
    smsCategoryTVCell * l_newcell = (smsCategoryTVCell*)  [tableView dequeueReusableCellWithIdentifier:l_reqdcellid];
    if (l_newcell == nil)
    {
        l_newcell = [[smsCategoryTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:l_reqdcellid];
    }
    [l_newcell setDisplayData:l_reqdDict];
    l_newcell.contentView.backgroundColor = [UIColor colorWithRed:0.25 green:0.53 blue:0.59 alpha:1.0];
    return l_newcell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)categoryIdClickedForTheCell:(NSInteger)p_positno
{
    
}


#pragma mark - navigation transition animations

- (void)pushAnimation:(TransitionType)p_pushAnimationType
{
    //[self resetIdleTimer];
}

- (void)popAnimation:(TransitionType)p_popAnimationType
{
    //[self resetIdleTimer];
}

- (CGRect) getPopOutFrame
{
    return CGRectZero;
}

- (UIImage*) getPopOutTopImage
{
    return nil;
}

- (UIImage*) getPopOutBottomImage
{
    return nil;
}

- (UIImage*) getPopOutImage
{
    return nil;
}

- (void) popAnimationCompleted
{
    
}

- (void)pushanimationCompleted
{
    
}

- (void) navigationAnimationCompleted
{
    
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
