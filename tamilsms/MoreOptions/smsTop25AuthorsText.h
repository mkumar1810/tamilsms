//
//  smsTop25AuthorsText.h
//  tamilsms
//
//  Created by arun benjamin on 29/01/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "smsDefaults.h"
#import "textMessageForCategoryListTv.h"

@interface smsTop25AuthorsText : UITableViewController <smsCustNaviDelegates>

{
    UIBarButtonItem * _baradd_btn;
}

@end


@interface smsTop25AuthorsTextCell : messageForCell

@end