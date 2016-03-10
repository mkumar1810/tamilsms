//
//  smsLatstImgMessag.h
//  tamilsms
//
//  Created by arun benjamin on 29/02/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "smsImageMessages.h"
#import "smsDefaults.h"
#import "smsTop25AuthoursImage.h"

@interface smsLatstImgMessag : UICollectionViewController <smsCustNaviDelegates>
{
    UIBarButtonItem * _baradd_btn;
}
@end

//@interface latestImageMsgCell : imageMessageForCell
//{
//    IBOutlet UIView * bottomdisplay;
//    IBOutlet UILabel * lbl_share;
//    IBOutlet UILabel * lbl_favLbl;
//    IBOutlet UIImageView * img_Share;
//    IBOutlet UIImageView * img_fav;
//    UILabel * loadMore;
//}
//
//
//@end