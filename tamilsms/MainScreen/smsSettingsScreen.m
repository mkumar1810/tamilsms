//
//  smsSettingsScreen.m
//  tamilsms
//
//  Created by arun benjamin on 30/09/15.
//  Copyright © 2015 arun benjamin. All rights reserved.
//

#import "smsSettingsScreen.h"


@interface smsSettingsScreen()
{
    UIPickerView * fontSizePicker;
    NSMutableArray *pickerData;
    UISwitch * alertSwitch;
    UILabel * lbl_notify, *lbl_font;
    UIButton * but_save;
}
- (void) switchIsChanged:(UISwitch *)paramSender;
-(void)aMethod:(UIButton*)p_it;

@end

@implementation smsSettingsScreen

-(void)drawRect:(CGRect)rect
{
    
    pickerData = [[NSMutableArray alloc] initWithObjects:@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30", nil];
    
    
    fontSizePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(180, 120, 60, 130)];
    fontSizePicker.showsSelectionIndicator = YES;
    fontSizePicker.hidden = NO;
    fontSizePicker.dataSource = self;
    fontSizePicker.delegate = self;
    //[fontSizePicker setBackgroundColor:[UIColor yellowColor]];
    [self addSubview:fontSizePicker];
    
    
    //lbl_font = [[UILabel alloc]initWithFrame:CGRectMake(160, 80, 100, 30)];
    lbl_font = [UILabel new];
    [lbl_font setText:@"Font Size"];
    [lbl_font setTextAlignment:NSTextAlignmentCenter];
    [lbl_font setFont:[UIFont boldSystemFontOfSize:22]];
    [lbl_font setBackgroundColor:[UIColor redColor]];
    lbl_font.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_font];
    
    [lbl_font addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LB(30)]" options:0 metrics:nil views:@{@"LB":lbl_font}]];
    [lbl_font addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LB(100)]" options:0 metrics:nil views:@{@"LB":lbl_font}]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_font
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_font
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:(0)]];
    //NSLog(@"the font label is %@",NSStringFromCGRect(lbl_font.frame));
    
    [self layoutIfNeeded];
    
    
    alertSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(270.0f, 300.0f, 150.0f, 105.0f)];
    [alertSwitch setOn:YES];
    //attach action method to the switch when the value changes
    [alertSwitch addTarget:self
                    action:@selector(switchIsChanged:)
          forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:alertSwitch];
    
    lbl_notify = [[UILabel alloc]initWithFrame:CGRectMake(70, 300, 200, 30)];
    [lbl_notify setText:@"Notification Alert:"];
    [lbl_notify setFont:[UIFont boldSystemFontOfSize:22]];
    //[lbl_notify setBackgroundColor:[UIColor redColor]];
    [self addSubview:lbl_notify];
    
    but_save = [[UIButton alloc]initWithFrame:CGRectMake(100, 400.0, 200.0, 30.0)];
    [but_save addTarget:self
                 action:@selector(aMethod:)
       forControlEvents:UIControlEventTouchUpInside];
    [but_save setBackgroundColor:[UIColor blueColor]];
    [but_save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but_save setTitle:@"Save" forState:UIControlStateNormal];
    [self addSubview:but_save];
    
    [self layoutIfNeeded];
    
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView; {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component; {
    return [pickerData count];
}

-(NSString*) pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [pickerData objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    
}

- (void) switchIsChanged:(UISwitch *)paramSender
{
    
}

-(void)aMethod:(UIButton*)p_it
{
    
}
@end
