//
//  smsMoreOptionsCtrlr.h
//  tamilsms
//
//  Created by Mohan Kumar on 22/01/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "smsDefaults.h"

@interface smsMoreOptionsCtrlr : UICollectionViewController<smsCustNaviDelegates>

@end


@interface smsCellForMoreOption : UICollectionViewCell
{
    UIImageView * l_images;
    UILabel * l_catName;
    NSString * _arayOptionList;
    NSString * _arayOptionimg;
}

- (void) setDisplayData:(NSString*) p_cellTitle andImgName:(NSString*) p_optionImg;
- (void)displayValues;
@end
