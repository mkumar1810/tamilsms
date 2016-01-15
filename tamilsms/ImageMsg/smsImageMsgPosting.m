//
//  smsImageMsgPosting.m
//  tamilsms
//
//  Created by Mohan Kumar on 10/01/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import "smsImageMsgPosting.h"
#import "categoryNameForMsgPosting.h"
#import "smsRESTProxy.h"

@interface smsImageMsgPosting()

@property (nonatomic) NSInteger msgCategoryId;

@end

@implementation smsImageMsgPosting
@synthesize imageAlbumDelegate;

-(void)drawRect:(CGRect)rect
{
    lbl_uplodImg = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 3*rect.size.width/4.0, 20)];
    [lbl_uplodImg setText:@"Upload Image"];
    [lbl_uplodImg setFont:[UIFont systemFontOfSize:16]];
    [lbl_uplodImg setTextAlignment:NSTextAlignmentLeft];
    //[lbl_uplodImg setBackgroundColor:[UIColor blueColor]];
    [self addSubview:lbl_uplodImg];
    
    lbl_warText = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, 7*rect.size.width/8.0, 20)];
    [lbl_warText setText:@"Upload Images with Tamil Text only"];
    [lbl_warText setFont:[UIFont systemFontOfSize:16]];
    [lbl_warText setTextColor:[UIColor redColor]];
    [lbl_warText setTextAlignment:NSTextAlignmentLeft];
    //[lbl_warText setBackgroundColor:[UIColor blueColor]];
    [self addSubview:lbl_warText];
    
    img_appImg = [[UIImageView alloc]initWithFrame:CGRectMake(3*rect.size.width/8.0, 75, rect.size.width/4.0, rect.size.width/4.0)];
    img_appImg.image = [UIImage imageNamed:@"app_icon.png"];
    [self addSubview:img_appImg];
    
    
    txt_ImgCatgry = [[UITextField alloc]initWithFrame:CGRectMake(rect.size.width/4.0, 180, rect.size.width/2.0, 30)];
    [txt_ImgCatgry setBackgroundColor:[UIColor lightGrayColor]];
    [txt_ImgCatgry setTextAlignment:NSTextAlignmentCenter];
    [txt_ImgCatgry setDelegate:self];
    [txt_ImgCatgry setPlaceholder:@"select category"];
    [self addSubview:txt_ImgCatgry];
    
    but_select = [[UIButton alloc]initWithFrame:CGRectMake(rect.size.width/4.0+20, 230, rect.size.width/2.0-40, 30)];
    
    but_select.titleLabel.font = [UIFont systemFontOfSize:15];
    [but_select setBackgroundColor:[UIColor orangeColor]];
    but_select.layer.cornerRadius = 8;
    but_select.layer.borderWidth = 1;
    but_select.layer.borderColor = [UIColor purpleColor].CGColor;
    [but_select addTarget:self action:@selector(selectImage) forControlEvents:UIControlEventTouchUpInside];
    [but_select setTitle:@"Select Image" forState:UIControlStateNormal];
    
    but_submit = [[UIButton alloc]initWithFrame:CGRectMake(rect.size.width/4.0+20,280, rect.size.width/2.0-40, 30)];
    [but_submit setBackgroundColor:[UIColor orangeColor]];
    [but_submit addTarget:self action:@selector(submitTheMessage) forControlEvents:UIControlEventTouchDown];
    but_submit.layer.cornerRadius = 8;
    but_submit.layer.borderWidth = 1;
    but_submit.layer.borderColor = [UIColor purpleColor].CGColor;
    [but_submit setTitle:@"Submit" forState:UIControlStateNormal];
    [self addSubview:but_submit];

    [self addSubview:but_select];
}

-(void)selectImage
{
    
    [self.imageAlbumDelegate delgateForImagefetchingFromAlbum];
    
}

-(void)InstanceForMsgPosting
{
    self.catNamePostVw = [categoryNameForMsgPosting new];
    self.catNamePostVw.translatesAutoresizingMaskIntoConstraints = NO;
    //self.dropDwnOptions.optionsDelegate = self;
    [self addSubview:self.catNamePostVw];
    self.catNamePostVw.categoryDelegate=self;
    [self.catNamePostVw setBackgroundColor:[UIColor whiteColor]];
    //[self bringSubviewToFront:self.smsMsgAndImgPostingSV];
    
    // Width constraint,
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.catNamePostVw
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:0.5 constant:0]];
    
    
    // Height constraint,
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.catNamePostVw
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0.5
                                                      constant:0]];
    
    // Center horizontally
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.catNamePostVw
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    // Center vertically
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.catNamePostVw
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0]];
}

- (void) setCapturedImage:(UIImage*) p_image
{
    img_appImg.image = p_image;
}

- (void) submitTheMessage
{
    NSInteger l_userid = [[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] integerValue];
    NSData * l_imagedata = UIImageJPEGRepresentation(img_appImg.image, 0.7);
    
    NSDictionary * l_inputParams = @{@"image_data":l_imagedata,
                                     @"cat_id":@(self.msgCategoryId),
                                     @"user_id":@(l_userid)};
    [[smsRESTProxy alloc]
     initDatawithAPIType:@"POSTIMAGEMSG"
     andInputParams:l_inputParams
     andReturnMethod:^(NSData * p_returnData){
         NSLog(@"the received is %@", [[NSString alloc] initWithData:p_returnData encoding:NSUTF8StringEncoding]);
         [self.imageAlbumDelegate imagePostingCompleted];
     }];
}

#pragma mark
#pragma text field delegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self InstanceForMsgPosting];
    return NO;
}

-(void)categoryNameClickedForTheCell:(NSDictionary*)p_catInfo
{
    txt_ImgCatgry.text = [p_catInfo valueForKey:@"category_name"];
    self.msgCategoryId = [[p_catInfo valueForKey:@"cid"] integerValue];
    [self.catNamePostVw removeFromSuperview];
}

@end
