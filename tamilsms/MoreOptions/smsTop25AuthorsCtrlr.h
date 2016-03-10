//
//  smsTop25AuthorsCtrlr.h
//  tamilsms
//
//  Created by arun benjamin on 27/01/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "smsDefaults.h"


@interface smsTop25AuthorsCtrlr : UITableViewController <smsCustNaviDelegates>
{
    UIBarButtonItem * _baradd_btn;
}
@end


@interface smsTop25AuthorsCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel * userdisplaymsg;

- (void) setDisplayInformation:(NSDictionary*) p_dispDict;

@end