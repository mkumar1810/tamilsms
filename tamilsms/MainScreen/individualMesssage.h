//
//  individualMesssage.h
//  tamilsms
//
//  Created by arun benjamin on 16/09/15.
//  Copyright (c) 2015 arun benjamin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol individualMessageDelegate <NSObject>

-(NSInteger) getNumberOfMessages;
-(NSDictionary*) getIndividualMessageOfDict:(NSInteger) p_posnNo;


@end

@protocol bottomNavigationViewDelegate <NSObject>

- (void) moveToNextMessage;
- (void) moveToPreviousMessage;

@end


@interface bottomViewForNextMessage : UIView
{
     UIButton * but_backbutn, * but_forwbutton, * but_favbutton, * but_cpybutton
    , * but_sharebutton;
    UILabel * lbl_fav, *lbl_copy, *lbl_share;
}

@property(nonatomic,weak)id<bottomNavigationViewDelegate> bottomViewDelegate;
//created to disappear the copy button in smsindividualmessage
- (id) initWithCopyButton:(BOOL)  p_copyBtnNeeded;

@end


@interface individualMesssage : UITableView
<UITableViewDataSource,UITableViewDelegate, bottomNavigationViewDelegate>

@property(nonatomic,weak)id<individualMessageDelegate>popUpMessageDelegate;
- (id) initWithStartPosn:(NSInteger) p_startPosn;

@end


@interface individualMesssageForCell : UITableViewCell

@property (nonatomic) NSInteger cellPosnNo;
//-(void)showData;
-(void) setDisplayValues:(NSDictionary*)p_messageDict atPosn:(NSInteger) p_posnNo;


@end

