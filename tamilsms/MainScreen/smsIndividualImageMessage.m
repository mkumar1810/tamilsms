//
//  smsIndividualImageMessage.m
//  tamilsms
//
//  Created by arun benjamin on 24/09/15.
//  Copyright © 2015 arun benjamin. All rights reserved.
//

#import "smsIndividualImageMessage.h"
#import "smsAsyncImageFetch.h"


@interface smsIndividualImageMessage()
{
    NSInteger _startPosn;
    NSInteger _currentPosn;
}
@end

@implementation smsIndividualImageMessage
- (id) initWithStartPosn:(NSInteger) p_startPosn
{
    self = [super initWithFrame:CGRectZero style:UITableViewStylePlain];
    if (self) {
        //
        _startPosn = p_startPosn;
        self.dataSource = self;
        self.delegate = self;
        [self setScrollEnabled:NO];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    _currentPosn = _startPosn;
    for (individualImgMesssageForCell * l_tmpcell in self.visibleCells)
    {
        if (l_tmpcell.cellPosnNo!=_currentPosn)
        {
            [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_currentPosn inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.popUpMessageDelegate getNumberOfMessages];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.bounds.size.height;
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
    //NSDictionary * Quotes = [self.popUpMessageDelegate getIndividualMessageFromDict:];
    //NSLog(@"the recived dict in cell is %@",Quotes);
    individualImgMesssageForCell * l_cell = (individualImgMesssageForCell*) [tableView dequeueReusableCellWithIdentifier:l_msgIdentifier];
    if (l_cell == nil)
    {
        l_cell = [[individualImgMesssageForCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:l_msgIdentifier];
    }
    //[l_cell setBackgroundColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.87 alpha:1.0]];
    [l_cell setDisplayValues:[self.popUpMessageDelegate getIndividualMessageOfDict:indexPath.row] atPosn:indexPath.row];
    return l_cell;
}

#pragma bottom view delegates implementation

- (void) moveToNextMessage
{
    _currentPosn++;
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_currentPosn inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void) moveToPreviousMessage
{
    _currentPosn--;
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_currentPosn inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end

@interface individualImgMesssageForCell()
{
    UILabel * lb_userdetails, * lb_popUpUsrName;
    UIImageView * img_popuimgage;
    NSDictionary * _dispDict;
    UIImageView * l_popupUserlogo;
}

@end

@implementation individualImgMesssageForCell


-(void)drawRect:(CGRect)rect
{
    lb_userdetails = [UILabel new];
    //lb_userdetails = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, 30)];
    [lb_userdetails setBackgroundColor:[UIColor colorWithRed:0.09 green:0.21 blue:0.40 alpha:1.0]];
    [lb_userdetails setTextAlignment:NSTextAlignmentCenter];
    [lb_userdetails setTextColor:[UIColor whiteColor]];
    lb_userdetails.translatesAutoresizingMaskIntoConstraints = NO;
    [lb_userdetails setFont:[UIFont systemFontOfSize:17]];
    [self addSubview:lb_userdetails];
    
    // Width constraint,
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lb_userdetails
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0 constant:0]];
    
    //Heighr constrain.
    [lb_userdetails addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[name(30)]" options:0 metrics:nil views:@{@"name":lb_userdetails}]];
    
    // Center horizontally
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lb_userdetails
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    [lb_userdetails addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[name(30)]" options:0 metrics:nil views:@{@"name":lb_userdetails}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[name]" options:0 metrics:nil views:@{@"name":lb_userdetails}]];
    
    // Center vertically
    /*[self addConstraint:[NSLayoutConstraint constraintWithItem:lb_userdetails
     attribute:NSLayoutAttributeCenterY
     relatedBy:NSLayoutRelationEqual
     toItem:self
     attribute:NSLayoutAttributeCenterY
     multiplier:1.0
     constant:(0.0)]];*/
    
    l_popupUserlogo = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, rect.size.width/18.0+5, 30-5)];
    [l_popupUserlogo setImage:[UIImage imageNamed:@"title_qoute_icon.png"]];
    [self addSubview:l_popupUserlogo];
    
    lb_popUpUsrName = [[UILabel alloc]initWithFrame:CGRectMake(rect.size.width/10.0, 0, rect.size.width, 30)];
    [lb_popUpUsrName setTextColor:[UIColor blueColor]];
    [lb_popUpUsrName setNumberOfLines:0];
    [lb_popUpUsrName setTextColor:[UIColor whiteColor]];
    [lb_popUpUsrName setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:lb_popUpUsrName];
    
    
    img_popuimgage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, rect.size.width, rect.size.height-30)];
    
    [self addSubview:img_popuimgage];
    
    [self displayValues];
}

-(void) setDisplayValues:(NSDictionary*)p_messageDict atPosn:(NSInteger) p_posnNo
{
    //NSDictionary * _quotesDict = p_dict;
    _dispDict = p_messageDict;
    //NSLog(@"the received message is %@", _dispDict);
    self.cellPosnNo = p_posnNo;
    if (img_popuimgage)
    {
        [self displayValues];
    }
}

- (void) displayValues
{
    lb_userdetails.text = [_dispDict valueForKey:@"author"];
    img_popuimgage.image = [UIImage imageNamed:[_dispDict valueForKey:@"msg_image"]];
    NSString * l_currlink = [_dispDict valueForKey:@"msg_image"];
    img_popuimgage.image = nil;
    [[smsAsyncImageFetch alloc]
     initDatawithFileName:l_currlink
     andReturnMethod:^(NSDictionary * p_returnInfo)
     {
         if ([[p_returnInfo valueForKey:@"linkname"]
              isEqualToString:l_currlink])
         {
             if ([p_returnInfo valueForKey:@"filename"])
             {
                 img_popuimgage.image = [UIImage
                                   imageWithContentsOfFile:[p_returnInfo valueForKey:@"filename"]];
             }
         }
     }];

}

@end

