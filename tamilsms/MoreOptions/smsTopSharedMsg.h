//
//  smsTopSharedMsg.h
//  tamilsms
//
//  Created by arun benjamin on 25/02/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "smsDefaults.h"
#import "textMessageForCategoryListTv.h"

@interface smsTopSharedMsg : UITableViewController <smsCustNaviDelegates>
{
    UIBarButtonItem * _baradd_btn;
}
@end

@interface smsTopSharedCell : messageForCell

@end