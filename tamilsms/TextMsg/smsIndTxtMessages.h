//
//  smsIndTxtMessages.h
//  tamilsms
//
//  Created by Mohan Kumar on 05/01/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol indTxtMsgDelegate <NSObject>

-(NSInteger) getNumberOfMessages;
-(NSDictionary*) getIndividualMessageOfDict:(NSInteger) p_posnNo;
- (UINavigationController*) getParentNavController;

@end

@protocol bottomNavigationViewDelegate <NSObject>

- (void) moveToNextMessage;
- (void) moveToPreviousMessage;
- (void) addCurrentToFavourite;
- (void) removeCurrentFromFavourite;
- (void) shareTheCurrentDisplayingItem;

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
- (void) setFavouriteStatusOnMsgId:(NSNumber*) p_MsgId;

@end


@interface smsIndTxtMessages : UITableView

<UITableViewDataSource,UITableViewDelegate, bottomNavigationViewDelegate>

@property(nonatomic,weak)id<indTxtMsgDelegate>popUpMessageDelegate;
- (id) initWithStartPosn:(NSInteger) p_startPosn;

@end

@interface individualMesssageForCell : UITableViewCell

@property (nonatomic) NSInteger cellPosnNo;
//-(void)showData;
-(void) setDisplayValues:(NSDictionary*)p_messageDict atPosn:(NSInteger) p_posnNo;


@end


