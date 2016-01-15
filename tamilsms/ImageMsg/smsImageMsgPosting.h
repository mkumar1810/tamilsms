//
//  smsImageMsgPosting.h
//  tamilsms
//
//  Created by Mohan Kumar on 10/01/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "categoryNameForMsgPosting.h"

@protocol imagePostingAlbumDelegate <NSObject>

-(void) imagePostingCompleted;
-(void)delgateForImagefetchingFromAlbum;

@end

@interface smsImageMsgPosting : UIScrollView<UIImagePickerControllerDelegate,UINavigationControllerDelegate,categoryNameDelegate,UITextFieldDelegate>
{
    UILabel *lbl_uplodImg,*lbl_warText;
    UIImageView * img_appImg;
    UIButton * but_catBut,*but_select, * but_submit;
    UITextField * txt_ImgCatgry;
}
- (void)selectImage;
- (void) setCapturedImage:(UIImage*) p_image;
@property (nonatomic,strong) categoryNameForMsgPosting * catNamePostVw;
@property(nonatomic,retain)id<imagePostingAlbumDelegate>imageAlbumDelegate;
@end
