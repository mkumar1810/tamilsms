//
//  smsIndividualImageMessage.h
//  tamilsms
//
//  Created by Mohan Kumar on 24/09/15.
//  Copyright © 2015 arun benjamin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "individualMesssage.h"

/*@protocol individualMessageDelegate <NSObject>

-(NSInteger) getNumberOfMessages;
-(NSDictionary*) getIndividualMessageOfDict:(NSInteger) p_posnNo;

@end


@protocol bottomNavigationViewDelegate <NSObject>

- (void) moveToNextMessage;
- (void) moveToPreviousMessage;

@end


@interface bottomViewForImageMessage : UIView
{
    UIButton * but_backbutn, * but_forwbutton, * but_favbutton, * but_cpybutton
    , * but_sharebutton;
    UILabel * lbl_fav, *lbl_copy, *lbl_share;
}

@property(nonatomic,weak)id<bottomNavigationViewDelegate> bottomViewDelegate;

@end
*/

@interface smsIndividualImageMessage : UITableView
<UITableViewDataSource,UITableViewDelegate, bottomNavigationViewDelegate>

@property(nonatomic,weak)id<individualMessageDelegate>popUpMessageDelegate;
- (id) initWithStartPosn:(NSInteger) p_startPosn;

@end

@interface individualImgMesssageForCell : UITableViewCell

@property (nonatomic) NSInteger cellPosnNo;
//-(void)showData;
-(void) setDisplayValues:(NSDictionary*)p_messageDict atPosn:(NSInteger) p_posnNo;


@end