//
//  smsBaseController.h
//  tamilsms
//
//  Created by Mohan Kumar on 10/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "smsDefaults.h"


@interface smsBaseController : UIViewController <smsCustNaviDelegates>

//@property (nonatomic,strong) UINavigationBar * navBar;
//@property (nonatomic,strong) UINavigationItem * navItem;
@property (nonatomic) CGRect lastCellFrameForPopOut;
@property (nonatomic,strong) UILabel * lbl_prevtitle;
@property (nonatomic,strong) UIBarButtonItem * bar_back_btn;
@property (nonatomic,strong) UIBarButtonItem * bar_prev_title_btn;
@property (nonatomic,strong) UIBarButtonItem * bar_refresh_btn;
@property (nonatomic,strong) UIBarButtonItem * bar_search_btn;
@property (nonatomic,strong) UIActivityIndicatorView * actView;
@property (nonatomic,strong) UIBarButtonItem * bar_logout_btn;
@property (nonatomic,strong) UIBarButtonItem * bar_report_prev_btn;
@property (nonatomic,strong) UIBarButtonItem * bar_printout_btn;
@property (nonatomic,strong) UIBarButtonItem * bar_list_btn;
@property (nonatomic,strong) UIBarButtonItem * bar_logo_btn;
@property (nonatomic,strong) UIBarButtonItem * bar_save_btn;

- (void) initializeData;
- (void) generateReportPreview;
- (void) makePrintOutOfReport;
- (void) editOptionPressed;
- (void) exitReportPreview;
- (void) performSearchOperation;
- (void) executeListButtonClicked;
- (void) storeTheDataToDB;

@end
