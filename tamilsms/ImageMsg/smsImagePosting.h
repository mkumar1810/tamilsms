//
//  smsImagePosting.h
//  tamilsms
//
//  Created by arun benjamin on 26/11/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "categoryNameForMsgPosting.h"

@protocol imagePostingAlbumDelegate <NSObject>

-(void)delgateForImagefetchingFromAlbum;

@end

@interface smsImagePosting : UIScrollView<UIImagePickerControllerDelegate,UINavigationControllerDelegate,categoryNameDelegate,UITextFieldDelegate>
{
    UILabel *lbl_uplodImg,*lbl_warText;
    UIImageView * img_appImg;
    UIButton * but_catBut,*but_select;
    UITextField * txt_ImgCatgry;

}
-(void)selectImage;
- (void) setCapturedImage:(UIImage*) p_image;
@property (nonatomic,strong) categoryNameForMsgPosting * catNamePostVw;
@property(nonatomic,retain)id<imagePostingAlbumDelegate>imageAlbumDelegate;
@end
