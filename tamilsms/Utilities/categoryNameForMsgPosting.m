//
//  categoryNameForMsgPosting.m
//  tamilsms
//
//  Created by arun benjamin on 21/11/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import "categoryNameForMsgPosting.h"
#import "smsDBAsyncQueueProcess.h"

@implementation categoryNameForMsgPosting
@synthesize categoryDelegate;

-(void)drawRect:(CGRect)rect
{
    NSLog(@"the frame size is %@", NSStringFromCGRect(rect));
    if (catgTable)
        [catgTable setFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    else
    {
        catgTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height) style:UITableViewStylePlain];
        catgTable.delegate=self;
        catgTable.dataSource=self;
        [catgTable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [self addSubview:catgTable];
        [self initializeData];
    }
    [self layoutIfNeeded];
}

- (void) initializeData
{
    [smsDBAsyncQueueProcess getTextCategoryTitles:^(NSArray * p_categoreisList){
        _txtCategoryTitles = p_categoreisList;
        [catgTable reloadData];
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _txtCategoryTitles.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [self.categoryDelegate categoryNameClickedForTheCell:[_txtCategoryTitles objectAtIndex:indexPath.row]];
   // [self.categoryDelegate categoryNameForImagePostingClickedForTheCell:[_txtCategoryTitles objectAtIndex:indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    //NSArray * mynameDict = _txtCategoryTitles;
    
    static NSString * l_reqdcellid = @"sampleCell";
    
    cellForCategoryName * l_newcell = (cellForCategoryName*)  [tableView dequeueReusableCellWithIdentifier:l_reqdcellid];
    if (l_newcell == nil)
    {
        l_newcell = [[cellForCategoryName alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:l_reqdcellid];
    }
    [l_newcell setBackgroundColor:[UIColor cyanColor]];
    [l_newcell setCategoryNameDict:[_txtCategoryTitles objectAtIndex:indexPath.row]];
     //Name:mynameDict indexNo:indexPath.row];
    return l_newcell;
}

@end



@implementation cellForCategoryName

-(void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    CGContextMoveToPoint(context, 0, rect.size.width);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextStrokePath(context);

    
    lbl_catname = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, rect.size.width,rect.size.height-2)];
    [lbl_catname setBackgroundColor:[UIColor colorWithRed:0.85 green:0.99 blue:0.99 alpha:1.0]];
    [lbl_catname setTextAlignment:NSTextAlignmentCenter];
    [lbl_catname setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:lbl_catname];
    [self showData];
}

-(void)setCategoryNameDict:(NSDictionary*)p_catNameDict
{
    recivDict = p_catNameDict;
    //indexNum = p_indexNum;
    //NSLog(@"the recived indexno = %ld",(long)indexNum);
    //NSLog(@"the recived dict = %@",recivArray);
    if (lbl_catname) {
        [self showData];
    }
    
}
-(void)showData
{
    lbl_catname.text = [[NSString alloc]initWithFormat:@"%@",[recivDict valueForKey:@"category_name"]];
}
@end