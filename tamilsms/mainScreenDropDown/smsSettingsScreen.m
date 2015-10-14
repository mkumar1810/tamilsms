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
    NSArray * _topdownconstraints;
    NSLayoutConstraint * _notifybtnyconst;
}
- (void) switchIsChanged:(UISwitch *)paramSender;
-(void)aMethod:(UIButton*)p_it;

@end

@implementation smsSettingsScreen

-(void)drawRect:(CGRect)rect
{
    
    pickerData = [[NSMutableArray alloc] initWithObjects:@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30", nil];
    
    
    //fontSizePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(180, 120, 60, 130)];
    fontSizePicker = [UIPickerView new];
    fontSizePicker.showsSelectionIndicator = YES;
    fontSizePicker.hidden = NO;
    fontSizePicker.dataSource = self;
    fontSizePicker.delegate = self;
    //[fontSizePicker setBackgroundColor:[UIColor yellowColor]];
    fontSizePicker.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:fontSizePicker];
    
    [fontSizePicker addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[FP(130)]" options:0 metrics:nil views:@{@"FP":fontSizePicker}]];
    [fontSizePicker addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[FP(60)]" options:0 metrics:nil views:@{@"FP":fontSizePicker}]];
    //[self addConstraint:[NSLayoutConstraint constraintWithItem:fontSizePicker attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:120]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:fontSizePicker
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    //lbl_font = [[UILabel alloc]initWithFrame:CGRectMake(160, 80, 100, 30)];
    lbl_font = [UILabel new];
    [lbl_font setText:@"Font Size"];
    [lbl_font setTextAlignment:NSTextAlignmentCenter];
    [lbl_font setFont:[UIFont boldSystemFontOfSize:22]];
    //[lbl_font setBackgroundColor:[UIColor redColor]];
    lbl_font.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_font];
    
    [lbl_font addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LB(30)]" options:0 metrics:nil views:@{@"LB":lbl_font}]];
    [lbl_font addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LB(100)]" options:0 metrics:nil views:@{@"LB":lbl_font}]];
    
    //[self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_font attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:80]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_font
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    
    //NSLog(@"the font label is %@",NSStringFromCGRect(lbl_font.frame));
    
    [self layoutIfNeeded];
    
    alertSwitch = [UISwitch new];
    //alertSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(270.0f, 300.0f, 150.0f, 105.0f)];
    [alertSwitch setOn:YES];
    //attach action method to the switch when the value changes
    [alertSwitch addTarget:self
                    action:@selector(switchIsChanged:)
          forControlEvents:UIControlEventValueChanged];
    alertSwitch.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:alertSwitch];
    [alertSwitch addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[AL(30)]" options:0 metrics:nil views:@{@"AL":alertSwitch}]];
    [alertSwitch addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[AL(200)]" options:0 metrics:nil views:@{@"AL":alertSwitch}]];
    
    //[self addConstraint:[NSLayoutConstraint constraintWithItem:alertSwitch attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:300]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:alertSwitch
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:170]];
    
    lbl_notify = [UILabel new];
    //lbl_notify = [[UILabel alloc]initWithFrame:CGRectMake(70, 300, 200, 30)];
    [lbl_notify setText:@"Notification Alert:"];
    [lbl_notify setFont:[UIFont boldSystemFontOfSize:22]];
    lbl_notify.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:lbl_notify];
    
    [lbl_notify addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LN(30)]" options:0 metrics:nil views:@{@"LN":lbl_notify}]];
    [lbl_notify addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LN(200)]" options:0 metrics:nil views:@{@"LN":lbl_notify}]];
    
    //[self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_notify attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:300]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_notify
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:-20.0]];
    
    but_save = [UIButton new];
    //but_save = [[UIButton alloc]initWithFrame:CGRectMake(100, 400.0, 200.0, 30.0)];
    [but_save addTarget:self
                 action:@selector(aMethod:)
       forControlEvents:UIControlEventTouchUpInside];
    [but_save setBackgroundColor:[UIColor colorWithRed:0.38 green:0.38 blue:0.75 alpha:1.0]];
    [but_save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but_save setTitle:@"Save" forState:UIControlStateNormal];
    but_save.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:but_save];
    
    [but_save addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[BS(30)]" options:0 metrics:nil views:@{@"BS":but_save}]];
    [but_save addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[BS(200)]" options:0 metrics:nil views:@{@"BS":but_save}]];
    
    //[self addConstraint:[NSLayoutConstraint constraintWithItem:but_save attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:400]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:but_save
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0]];
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {
        _topdownconstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[LB]-20-[FP]-20-[NA]-40-[BS]" options:0 metrics:nil views:@{@"LB":lbl_font,@"FP":fontSizePicker,@"NA":lbl_notify,@"BS":but_save}];
        
    }
    else
    {
        _topdownconstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[LB]-10-[FP]-10-[NA]-30-[BS]" options:0 metrics:nil views:@{@"LB":lbl_font,@"FP":fontSizePicker,@"NA":lbl_notify,@"BS":but_save}];
    }
    _notifybtnyconst = [NSLayoutConstraint constraintWithItem:alertSwitch attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:lbl_notify attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];

    [self addConstraints:_topdownconstraints];
    [self addConstraint:_notifybtnyconst];
    
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

- (void)updateConstraints
{
    [super updateConstraints];
    if (!but_save) {
        return;
    }
    if (_topdownconstraints)
    {
        [self removeConstraints:_topdownconstraints];
        [self removeConstraint:_notifybtnyconst];
    }
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {
        _topdownconstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[LB]-20-[FP]-20-[NA]-40-[BS]" options:0 metrics:nil views:@{@"LB":lbl_font,@"FP":fontSizePicker,@"NA":lbl_notify,@"BS":but_save}];

    }
    else
    {
        _topdownconstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[LB]-10-[FP]-10-[NA]-30-[BS]" options:0 metrics:nil views:@{@"LB":lbl_font,@"FP":fontSizePicker,@"NA":lbl_notify,@"BS":but_save}];
    }
    [self addConstraints:_topdownconstraints];
    [self addConstraint:_notifybtnyconst];
    [self layoutIfNeeded];
}


@end
