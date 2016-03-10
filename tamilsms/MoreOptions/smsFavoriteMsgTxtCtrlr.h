//
//  smsFavoriteMsgTxtCtrlr.h
//  tamilsms
//
//  Created by arun benjamin on 18/02/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "smsDefaults.h"
#import "textMessageForCategoryListTv.h"
#import "smsImageMessages.h"



@interface smsFavoriteMsgTxtCtrlr : UIViewController<smsCustNaviDelegates,textMessageForCategoryDelegate,UIBarPositioningDelegate, imageMessageForCategoryDelegate>
{
    UIBarButtonItem * _baradd_btn;
    //UIBarButtonItem * _segmntBtn;
   
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segCtrol;
//@property (weak, nonatomic) IBOutlet UIScrollView *_scrlView;
@property (weak, nonatomic) IBOutlet textMessageForCategoryListTv * msgTtablView;
@property (weak, nonatomic) IBOutlet smsImageMessages *imgCollView;

- (IBAction)segCntolr:(id)sender;

@end

@interface favImgCell : imageMessageForCell

@end