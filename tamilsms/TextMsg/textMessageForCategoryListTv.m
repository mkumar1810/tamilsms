//
//  textMessageForCategoryListTv.m
//  tamilsms
//
//  Created by Mohan Kumar on 12/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import "textMessageForCategoryListTv.h"

@interface textMessageForCategoryListTv()
{
    NSMutableParagraphStyle * _txtmsgstyle;
}

@end


@implementation textMessageForCategoryListTv


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

-(void)drawRect:(CGRect)rect
{
    /*textmsgtable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height-30) style:UITableViewStylePlain];
    self.delegate=self;
    self.dataSource=self;
    [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //[mytable setHidden:YES];
    [self addSubview:textmsgtable];
    [textmsgtable layoutIfNeeded];*/
    
    
    _txtmsgstyle =[[NSMutableParagraphStyle alloc] init];
    _txtmsgstyle.lineBreakMode = NSLineBreakByWordWrapping;
    _txtmsgstyle.alignment = NSTextAlignmentLeft;
    
    
}

-(void)reloadCategoriesListMessages
{
    [self reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return[self.categoryMessageDelegate getMessageCount];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * mess = [self.categoryMessageDelegate getMessageFromArray:indexPath.row];
    //UILabel* messtext;
    /*
    NSLog(@"the text values in qoutes is %@",text);
    CGSize textSize = [text sizeWithAttributes:@{ NSFontAttributeName : [UIFont fontWithName:@"systemFontOfSize" size:15.0] }];
    NSLog(@"width = %f, height = %f", textSize.width, textSize.height);*/
    
    NSString * l_msgtext = [mess valueForKey:@"quotes"];
    CGRect l_reqdrect = [l_msgtext boundingRectWithSize:CGSizeMake(self.bounds.size.width-30.0, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin+NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0f],NSParagraphStyleAttributeName:_txtmsgstyle} context:nil];
    NSInteger l_reqdheight = l_reqdrect.size.height;
    //(l_reqdrect.size.height/10.0+0.5);
     //l_reqdheight = l_reqdheight*10;
    //NSLog(@"the received height %ld for row %ld", (long)l_reqdheight, (long)indexPath.row );
     if (l_reqdheight<65.0f)
         return 105.0f;
     else
         return l_reqdheight+40.0;
    //return textSize.height;
    //return 150;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.categoryMessageDelegate messageClickedForTheCell:indexPath.row];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * l_CellIdentifier = @"sampleCell";
    NSDictionary * l_dictvalur = [self.categoryMessageDelegate getMessageFromArray:indexPath.row];
    //NSLog(@"the messages for category is %@",l_dictvalur);
    //NSLog(@"the cell value is %@",l_dictvalur);
    
    messageForCell * l_cell = (messageForCell*) [tableView dequeueReusableCellWithIdentifier:l_CellIdentifier];
    if (l_cell == nil)
    {
        l_cell = [[messageForCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:l_CellIdentifier];
    }
    [l_cell setDisplayData:l_dictvalur];
    [l_cell setBackgroundColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.87 alpha:1.0]];
    return l_cell;
}


@end
@interface messageForCell()
{
    UILabel * l_users, * l_username;
    UITextView * l_msgtxtvw;
    UIImageView * l_usernamelogo,*l_msgline ;
    NSArray * _array;
    NSDictionary * _categorydata;
    
}

@end

@implementation messageForCell

-(void)drawRect:(CGRect)rect
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (l_users) {
        //[l_users setFrame:CGRectMake(0, 0, rect.size.width, 30)];
        [l_username setFrame:CGRectMake(rect.size.width/10.0, 0, rect.size.width, 30)];
        [l_usernamelogo setFrame:CGRectMake(5, 5, rect.size.width/18.0+5, 30-5)];
        [l_msgtxtvw setFrame:CGRectMake(10, 30, rect.size.width-20, rect.size.height-30)];
        return;
    }
    
    //l_users = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, 30)];
    l_users = [UILabel new];
    [l_users setBackgroundColor:[UIColor colorWithRed:0.09 green:0.21 blue:0.40 alpha:1.0]];
    [l_users setTextColor:[UIColor whiteColor]];
    l_users.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:l_users];
    
    l_usernamelogo = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, rect.size.width/18.0+5, 30-5)];
    [l_usernamelogo setImage:[UIImage imageNamed:@"title_qoute_icon.png"]];
    [self addSubview:l_usernamelogo];
    
    
        
    /*l_msgline = [[UIImageView alloc]initWithFrame:CGRectMake(rect.size.width/2.0, 1, rect.size.width/2.0, 7)];
    [l_msgline setImage:[UIImage imageNamed:@"bottom_shadow.png"]];
    [self addSubview:l_msgline];*/
    
    
    l_username = [[UILabel alloc]initWithFrame:CGRectMake(rect.size.width/10.0, 0, rect.size.width, 30)];
    [l_username setTextColor:[UIColor blueColor]];
    [l_username setNumberOfLines:0];
    [l_username setTextColor:[UIColor whiteColor]];
    [l_username setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:l_username];
    
    l_msgtxtvw = [[UITextView alloc]initWithFrame:CGRectMake(10, 30, rect.size.width-20, rect.size.height-30)];
    [l_msgtxtvw setTextColor:[UIColor blackColor]];
    //[l_messages setNumberOfLines:0];
    [l_msgtxtvw setBackgroundColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.87 alpha:1.0]];
    [l_msgtxtvw setFont:[UIFont systemFontOfSize:15]];
    [l_msgtxtvw setScrollEnabled:NO];
    [self addSubview:l_msgtxtvw];
    [l_msgtxtvw setUserInteractionEnabled:NO];
    
    [self displayValues];
    
    
    // Width constraint, half of parent view width
    [self addConstraint:[NSLayoutConstraint constraintWithItem:l_users
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0 constant:0]];
    
    
    // Height constraint, half of parent view height
    /*[self addConstraint:[NSLayoutConstraint constraintWithItem:l_users
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1.0
                                                      constant:0]];*/
    
    [l_users addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[name(30)]" options:0 metrics:nil views:@{@"name":l_users}]];
    
    // Center horizontally
    [self addConstraint:[NSLayoutConstraint constraintWithItem:l_users
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0 constant:0.0]];
    // Center vertically
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[name]" options:0 metrics:nil views:@{@"name":l_users}]];
    
    
    
    // Center vertically
    /*[self addConstraint:[NSLayoutConstraint constraintWithItem:l_users
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0.0]];*/
    
    [self layoutIfNeeded];

    
}


- (void) setDisplayData:(NSDictionary*) p_displayDict
{
    _categorydata = p_displayDict;
    //NSLog(@"the value obtained in table is %@",_categorydata);
    if (l_users) {
        [self displayValues];
    }
}

- (void) displayValues
{
    l_username.text = [[NSString alloc]initWithFormat:@"%@",[_categorydata valueForKey:@"author"]];
    l_msgtxtvw.text =[[NSString alloc]initWithFormat:@"%@",[_categorydata valueForKey:@"quotes"]];
    
}

@end
