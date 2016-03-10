//
//  smsTop25AuthoursImage.h
//  tamilsms
//
//  Created by arun benjamin on 29/01/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "smsDefaults.h"
#import "smsImageMessages.h"


@interface smsTop25AuthoursImage : UICollectionViewController <smsCustNaviDelegates>
{
    UIBarButtonItem * _baradd_btn;
}

@end

@interface TopAuthourImageCell : imageMessageForCell
{
    IBOutlet UIView * bottomdisplay;
    IBOutlet UILabel * lbl_share;
    IBOutlet UILabel * lbl_favLbl;
    IBOutlet UIImageView * img_Share;
    IBOutlet UIImageView * img_fav;
    UILabel * loadMore;
}

@end