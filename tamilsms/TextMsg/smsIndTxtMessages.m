//
//  smsIndTxtMessages.m
//  tamilsms
//
//  Created by Mohan Kumar on 05/01/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import "smsIndTxtMessages.h"
#import "smsCommonUtilities.h"

@interface smsIndTxtMessages()
{
    NSInteger _startPosn;
    NSInteger _currentPosn;
    NSInteger _noOfRecords;
}

@end


@implementation smsIndTxtMessages

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
    for (individualMesssageForCell * l_tmpcell in self.visibleCells)
    {
        if (l_tmpcell.cellPosnNo!=_currentPosn)
        {
            [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_currentPosn inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _noOfRecords = [self.popUpMessageDelegate getNumberOfMessages];
    return _noOfRecords;
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
    individualMesssageForCell * l_cell = (individualMesssageForCell*) [tableView dequeueReusableCellWithIdentifier:l_msgIdentifier];
    if (l_cell == nil)
    {
        l_cell = [[individualMesssageForCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:l_msgIdentifier];
    }
    [l_cell setBackgroundColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.87 alpha:1.0]];
    [l_cell setDisplayValues:[self.popUpMessageDelegate getIndividualMessageOfDict:indexPath.row] atPosn:indexPath.row];
    return l_cell;
}

#pragma bottom view delegates implementation

- (void) moveToNextMessage
{
    if (_currentPosn==(_noOfRecords-1))
    {
        return;
    }
    _currentPosn++;
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_currentPosn inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void) moveToPreviousMessage
{
    if (_currentPosn==0)
    {
        return;
    }
    _currentPosn--;
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_currentPosn inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)addCurrentToFavourite
{
    NSDictionary * l_msgdict = [self.popUpMessageDelegate getIndividualMessageOfDict:_currentPosn];
//    NSLog(@"the text msg dict is %@", l_msgdict);
    [smsCommonUtilities addSMSItemToFavourite:[l_msgdict valueForKey:@"id"]];
}

- (void)removeCurrentFromFavourite
{
    NSDictionary * l_msgdict = [self.popUpMessageDelegate getIndividualMessageOfDict:_currentPosn];
    //    NSLog(@"the text msg dict is %@", l_msgdict);
    [smsCommonUtilities removeSMSItemToFavourite:[l_msgdict valueForKey:@"id"]];
}

- (void)shareTheCurrentDisplayingItem
{
    NSDictionary * l_msgdict = [self.popUpMessageDelegate getIndividualMessageOfDict:_currentPosn];
    NSArray *objectsToShare = @[[l_msgdict valueForKey:@"quotes"]];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];

    NSArray *excludeActivities = @[];

    activityVC.excludedActivityTypes = excludeActivities;

    [[self.popUpMessageDelegate getParentNavController] presentViewController:activityVC animated:YES completion:nil];
}

@end

@interface individualMesssageForCell()
{
    UILabel * lb_userdetails, * lb_popUpUsrName;
    UITextView * tx_popupmess;
    NSDictionary * _dispDict;
    UIImageView * l_popupUserlogo;
}

@end

@implementation individualMesssageForCell


-(void)drawRect:(CGRect)rect
{
    lb_userdetails = [UILabel new];
    //lb_userdetails = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, 30)];
    [lb_userdetails setBackgroundColor:[UIColor colorWithRed:0.09 green:0.21 blue:0.40 alpha:1.0]];
    [lb_userdetails setTextAlignment:NSTextAlignmentCenter];
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
    
    
    tx_popupmess = [[UITextView alloc]initWithFrame:CGRectMake(0, 30, rect.size.width, rect.size.height-30)];
    [tx_popupmess setTextAlignment:NSTextAlignmentCenter];
    [tx_popupmess setBackgroundColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.87 alpha:1.0]];
    [tx_popupmess setTextColor:[UIColor colorWithRed:0.27 green:0.46 blue:0.18 alpha:1.0]];
    [tx_popupmess setFont:[UIFont boldSystemFontOfSize:18]];
    [tx_popupmess setScrollEnabled:YES];
    
    [self addSubview:tx_popupmess];
    
    [self displayValues];
}

-(void) setDisplayValues:(NSDictionary*)p_messageDict atPosn:(NSInteger) p_posnNo
{
    //NSDictionary * _quotesDict = p_dict;
    _dispDict = p_messageDict;
    self.cellPosnNo = p_posnNo;
    if (tx_popupmess)
    {
        [self displayValues];
    }
}

- (void) displayValues
{
    tx_popupmess.text = [_dispDict valueForKey:@"quotes"];
    lb_popUpUsrName.text = [_dispDict valueForKey:@"author"];
    /*CGPoint l_oldcenter = tx_popupmess.center;
     CGPoint l_tocenter = CGPointMake(l_oldcenter.x, self.bounds.size.height/2.0);
     tx_popupmess.transform = CGAffineTransformMakeScale(1, 10);
     [tx_popupmess setCenter:l_tocenter];
     [UIView animateWithDuration:0.4 animations:^(){
     
     } completion:^(BOOL p_finished){
     [UIView animateWithDuration:0.5 animations:^(){
     tx_popupmess.transform = CGAffineTransformIdentity;
     [tx_popupmess setCenter:l_oldcenter];
     }];
     }
     ];*/
}

@end

//created to disappear the copy button in smsindividualmessage
@interface bottomViewForNextMessage()
{
    BOOL _includeCopyButton;
}

@end

@implementation bottomViewForNextMessage

- (id) initWithCopyButton:(BOOL)  p_copyBtnNeeded
{
    self = [super init];
    if (self)
    {
        //
        _includeCopyButton = p_copyBtnNeeded;
    }
    return self;
}
//created to disappear the copy button in smsindividualmessage ended here

-(void)drawRect:(CGRect)rect
{
    but_backbutn = [UIButton new];
    //but_backbutn = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, rect.size.width/6.0, 30)];
    [but_backbutn setBackgroundImage:[UIImage imageNamed:@"prev_btn"] forState:UIControlStateNormal];
    //[but_backbutn setBackgroundColor:[UIColor yellowColor]];
    [but_backbutn addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    but_backbutn.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:but_backbutn];
    [but_backbutn addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bk_but(30)]" options:0 metrics:nil views:@{@"bk_but":but_backbutn}]];
    [but_backbutn addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[bk_but(60)]" options:0 metrics:nil views:@{@"bk_but":but_backbutn}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[bb]" options:0 metrics:nil views:@{@"bb":but_backbutn}]];
    
    but_favbutton = [UIButton new];
    [but_favbutton setImage:[UIImage imageNamed:@"favourite"] forState:UIControlStateNormal];
    [but_favbutton setImage:[UIImage imageNamed:@"favselected"] forState:UIControlStateSelected];
    [but_favbutton setBackgroundColor:[UIColor clearColor]];
    but_favbutton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:but_favbutton];
    
    [but_favbutton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[fv(30)]" options:0 metrics:nil views:@{@"fv":but_favbutton}]];
    [but_favbutton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[fv(30)]" options:0 metrics:nil views:@{@"fv":but_favbutton}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[fv]" options:0 metrics:nil views:@{@"fv":but_favbutton}]];
    [but_favbutton addTarget:self action:@selector(favouriteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bb]-20-[fv]" options:0 metrics:nil views:@{@"bb":but_backbutn,@"fv":but_favbutton}]];
    
    but_forwbutton = [UIButton new];
    //initWithFrame:CGRectMake(13*rect.size.width/16.0+8, 5, rect.size.width/6.0, 30)];
    but_forwbutton.translatesAutoresizingMaskIntoConstraints = NO;
    [but_forwbutton setBackgroundImage:[UIImage imageNamed:@"next_btn"] forState:UIControlStateNormal];
    [self addSubview:but_forwbutton];
    [but_forwbutton addTarget:self action:@selector(nextButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [but_forwbutton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[fw(30)]" options:0 metrics:nil views:@{@"fw":but_forwbutton}]];
    [but_forwbutton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[fw(60)]" options:0 metrics:nil views:@{@"fw":but_forwbutton}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[fw]" options:0 metrics:nil views:@{@"fw":but_forwbutton}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:but_forwbutton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    
    but_sharebutton = [UIButton new];
    but_sharebutton.translatesAutoresizingMaskIntoConstraints = NO;
    //initWithFrame:CGRectMake(9*rect.size.width/16.0+50, 7, rect.size.width/16.0, 25)];
    [but_sharebutton setBackgroundColor:[UIColor clearColor]];
    [but_sharebutton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [self addSubview:but_sharebutton];
    [but_sharebutton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[sb(30)]" options:0 metrics:nil views:@{@"sb":but_sharebutton}]];
    [but_sharebutton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[sb(30)]" options:0 metrics:nil views:@{@"sb":but_sharebutton}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[sb]" options:0 metrics:nil views:@{@"sb":but_sharebutton}]];
    [but_sharebutton addTarget:self.bottomViewDelegate action:@selector(shareTheCurrentDisplayingItem) forControlEvents:UIControlEventTouchUpInside];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:but_sharebutton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:but_forwbutton attribute:NSLayoutAttributeLeft multiplier:1.0 constant:(-20)]];
    
    //but_favbutton = [[UIButton alloc]initWithFrame:CGRectMake(rect.size.width/4.0, 7, rect.size.width/16.0+2, 25)];
    but_cpybutton = [UIButton new];
    but_cpybutton.translatesAutoresizingMaskIntoConstraints = NO;
    //alloc]initWithFrame:CGRectMake(rect.size.width/2.0+40, 7, rect.size.width/16.0, 25)];
    [but_cpybutton setImage:[UIImage imageNamed:@"copy"] forState:UIControlStateNormal];
    [but_cpybutton setBackgroundColor:[UIColor clearColor]];
    [self addSubview:but_cpybutton];
    [but_cpybutton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[cp(30)]" options:0 metrics:nil views:@{@"cp":but_cpybutton}]];
    [but_cpybutton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[cp(30)]" options:0 metrics:nil views:@{@"cp":but_cpybutton}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[cp]" options:0 metrics:nil views:@{@"cp":but_cpybutton}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:but_cpybutton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:but_sharebutton attribute:NSLayoutAttributeLeft multiplier:1.0 constant:(-20)]];
    
    
    //[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[iM]-20-[bm]-50-[fb]|" options:0 metrics:nil views:@{@"iM":but_backbutn,@"bm":but_favbutton,@"fb":but_cpybutton}]];
    
    lbl_fav = [UILabel new];
    [lbl_fav setText:@"Favorite"];
    [lbl_fav setTextColor:[UIColor whiteColor]];
    [lbl_fav setFont:[UIFont systemFontOfSize:14]];
    lbl_fav.translatesAutoresizingMaskIntoConstraints = NO;
    //[lbl_fav setBackgroundColor:[UIColor redColor]];
    [self addSubview:lbl_fav];
    
    [lbl_fav addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lblfv(15)]" options:0 metrics:nil views:@{@"lblfv":lbl_fav}]];
    [lbl_fav addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[lblfv(60)]" options:0 metrics:nil views:@{@"lblfv":lbl_fav}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-35-[lblfv]" options:0 metrics:nil views:@{@"lblfv":lbl_fav}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-80-[lblfv]" options:0 metrics:nil views:@{@"lblfv":lbl_fav}]];
    
    lbl_copy = [UILabel new];
    [lbl_copy setText:@"Copy"];
    [lbl_copy setTextColor:[UIColor whiteColor]];
    [lbl_copy setFont:[UIFont systemFontOfSize:14]];
    lbl_copy.translatesAutoresizingMaskIntoConstraints = NO;
    //[lbl_copy setBackgroundColor:[UIColor redColor]];
    [self addSubview:lbl_copy];
    
    [lbl_copy addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lc(15)]" options:0 metrics:nil views:@{@"lc":lbl_copy}]];
    [lbl_copy addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[lc(40)]" options:0 metrics:nil views:@{@"lc":lbl_copy}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-35-[lc]" options:0 metrics:nil views:@{@"lc":lbl_copy}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_copy attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:(-120)]];
    
    
    
    lbl_share = [UILabel new];
    [lbl_share setText:@"Share"];
    [lbl_share setTextColor:[UIColor whiteColor]];
    [lbl_share setFont:[UIFont systemFontOfSize:14]];
    lbl_share.translatesAutoresizingMaskIntoConstraints = NO;
    //[lbl_share setBackgroundColor:[UIColor redColor]];
    [self addSubview:lbl_share];
    
    [lbl_share addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[ls(15)]" options:0 metrics:nil views:@{@"ls":lbl_share}]];
    [lbl_share addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[ls(40)]" options:0 metrics:nil views:@{@"ls":lbl_share}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-35-[ls]" options:0 metrics:nil views:@{@"ls":lbl_share}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_share attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:(-70)]];
    
    //created to disappear the copy button in smsindividualmessage
    if (_includeCopyButton)
    {
        [lbl_copy setHidden:NO];
        [but_cpybutton setHidden:NO];
    }
    else
    {
        [lbl_copy setHidden:YES];
        [but_cpybutton setHidden:YES];
    }
    //created to disappear the copy button in smsindividualmessage ended here
    [self layoutIfNeeded];
}

- (void) setFavouriteStatusOnMsgId:(NSNumber*) p_MsgId
{
    if ([smsCommonUtilities isTheSMSIsInFavourite:p_MsgId])
        [but_favbutton setSelected:YES];
    else
        [but_favbutton setSelected:NO];
}

- (void) backButtonPressed
{
    [self.bottomViewDelegate moveToPreviousMessage];
}

- (void) nextButtonPressed
{
    [self.bottomViewDelegate moveToNextMessage];
}

- (void) favouriteButtonClicked
{
    if (!but_favbutton.selected)
    {
        [self.bottomViewDelegate addCurrentToFavourite];
    }
    else
    {
        [self.bottomViewDelegate removeCurrentFromFavourite];
    }
    dispatch_async(dispatch_get_main_queue(), ^(){
        but_favbutton.selected = !but_favbutton.selected;
    });
}

@end

