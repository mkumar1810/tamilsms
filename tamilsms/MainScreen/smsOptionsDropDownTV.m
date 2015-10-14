//
//  smsOptionsDropDownTV.m
//  tamilsms
//
//  Created by arun benjamin on 30/09/15.
//  Copyright © 2015 arun benjamin. All rights reserved.
//

#import "smsOptionsDropDownTV.h"


@interface smsOptionsDropDownTV()
{
    NSArray * _dispValues;
}

@end

@implementation smsOptionsDropDownTV

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    //self = [super initWithFrame:CGRectZero style:UITableViewStylePlain];
    if (self) {
        //
        _dispValues = @[@"Settings",@"Feedback", @"Info"];
        self.dataSource = self;
        self.delegate =self;
        
    }
    return self;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dispValues count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * l_msgIdentifier = @"sampleCell";
    smsOptionsDropDownCell * l_cell = (smsOptionsDropDownCell*) [tableView dequeueReusableCellWithIdentifier:l_msgIdentifier];
    if (l_cell == nil)
    {
        l_cell = [[smsOptionsDropDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:l_msgIdentifier];
    }
    [l_cell setDisplayValue:[_dispValues objectAtIndex:indexPath.row]];
    return l_cell;
}

@end


@interface smsOptionsDropDownCell()
{
    NSString * _displayText;
}

@end

@implementation smsOptionsDropDownCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        [self setBackgroundColor:[UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1.0]];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (lbl_settings)
    {
        [lbl_settings setFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        return;
        
        //
    }
    
    lbl_settings= [[UILabel alloc]initWithFrame:CGRectMake(10, 0, rect.size.width-20, rect.size.height)];
    //[lbl_mobileno setBackgroundColor:[UIColor blueColor]];
    [lbl_settings setTextAlignment:NSTextAlignmentCenter];
    //[lbl_settings setText:@"Settings"];
    [lbl_settings setTextColor:[UIColor whiteColor]];
    [lbl_settings setTextAlignment:NSTextAlignmentLeft];
    [lbl_settings setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0]];
    [self addSubview:lbl_settings];
    [self layoutIfNeeded];
    [self displayValues];
    
}

- (void) setDisplayValue:(NSString*) p_displayText
{
    _displayText = p_displayText;
    //NSLog(@"the values are %@",_displayText);
    if (lbl_settings) {
        [self displayValues];
    }
}

- (void) displayValues
{
    lbl_settings.text = _displayText;
}


@end
