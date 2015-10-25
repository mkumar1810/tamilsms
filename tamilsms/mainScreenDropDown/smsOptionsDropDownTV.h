//
//  smsOptionsDropDownTV.h
//  tamilsms
//
//  Created by Mohan Kumar on 30/09/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol smsOptionsDropDownTVDelegate <NSObject>

- (void) optionSelectedInDropDown:(NSString*) p_optionText;
- (void) cancelDropDownScreen;

@end

@interface smsOptionsDropDownTV : UITableView  <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) id<smsOptionsDropDownTVDelegate> optionsDelegate;
@end


@interface smsOptionsDropDownCell : UITableViewCell
{
    UILabel * lbl_settings;
}

- (void) setDisplayValue:(NSString*) p_displayText;

@end

