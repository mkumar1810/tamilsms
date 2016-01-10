//
//  smsImagePosting.m
//  tamilsms
//
//  Created by arun benjamin on 26/11/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import "smsImagePosting.h"
#import "categoryNameForMsgPosting.h"

@implementation smsImagePosting
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
    
   /* but_catBut = [[UIButton alloc]initWithFrame:CGRectMake(rect.size.width/4.0, 180, rect.size.width/2.0, 30)];
    but_catBut.titleLabel.font = [UIFont systemFontOfSize:15];
    [but_catBut setBackgroundColor:[UIColor lightGrayColor]];
    [but_catBut addTarget:self action:@selector(InstanceForMsgPosting) forControlEvents:UIControlEventTouchUpInside];
    [but_catBut setTitle:@"Select Category" forState:UIControlStateNormal];
    [self addSubview:but_catBut];*/
    
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
#pragma mark
#pragma text field delegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self InstanceForMsgPosting];
    return NO;
}

-(void)categoryNameClickedForTheCell:(NSArray *)p_array
{
    txt_ImgCatgry.text = [p_array valueForKey:@"category_name"];
    [self.catNamePostVw removeFromSuperview];
    NSLog(@"the log value is %@",p_array);
}

@end
