//
//  smsSynchronizationDatas.m
//  tamilsms
//
//  Created by Mohan Kumar on 03/10/15.
//  Copyright © 2015 arun benjamin. All rights reserved.
//

#import "smsSynchronizationDatas.h"
#import "smsSyncDBFromCloud.h"

@interface smsSynchronizationDatas()<smsSyncDBFromCloudDelegates>
{
    UILabel * lbl_update, *lbl_totalMsg, *lbl_msgcount, *lbl_updmsg, *lbl_prec;
    UIProgressView * indicator;
    NSMutableDictionary * _syncData;
    
}

@property (nonatomic,strong) smsSyncDBFromCloud * syncfromCloud;


@end

@implementation smsSynchronizationDatas

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:0.19 green:0.47 blue:0.72 alpha:1.0]];
        _syncData = [[NSMutableDictionary alloc] init];
        self.syncfromCloud = [[smsSyncDBFromCloud alloc] init];
        self.syncfromCloud.syncDelegate = self;
        [self.syncfromCloud startSyncingTamilSMSTable];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    lbl_update = [UILabel new];
    [lbl_update setText:@"Updating New Messages"];
    [lbl_update setFont:[UIFont boldSystemFontOfSize:25]];
    [lbl_update setTextAlignment:NSTextAlignmentCenter];
    [lbl_update setNumberOfLines:1];
    lbl_update.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_update];
    
    [lbl_update addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LU(50)]" options:0 metrics:nil views:@{@"LU":lbl_update}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[LU]" options:0 metrics:nil views:@{@"LU":lbl_update}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_update
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_update
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    indicator = [UIProgressView new];
    [indicator setBackgroundColor:[UIColor redColor]];
    [indicator setProgressTintColor:[UIColor colorWithRed:0.00 green:0.93 blue:0.93 alpha:1.0]];
    indicator.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:indicator];
    
    [indicator addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[IN(2)]" options:0 metrics:nil views:@{@"IN":indicator}]];
    [indicator addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[IN(270)]" options:0 metrics:nil views:@{@"IN":indicator}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-110-[IN]" options:0 metrics:nil views:@{@"IN":indicator}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:indicator
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
   
    lbl_updmsg = [UILabel new];
    [lbl_updmsg setText:@"Updating Message"];
    [lbl_updmsg setFont:[UIFont systemFontOfSize:20]];
    [lbl_updmsg setTextAlignment:NSTextAlignmentCenter];
    lbl_updmsg.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_updmsg];
    
    [lbl_updmsg addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LUM(30)]" options:0 metrics:nil views:@{@"LUM":lbl_updmsg}]];
    [lbl_updmsg addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LUM(200)]" options:0 metrics:nil views:@{@"LUM":lbl_updmsg}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-150-[LUM]" options:0 metrics:nil views:@{@"LUM":lbl_updmsg}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_updmsg
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    lbl_prec = [UILabel new];
    //[lbl_prec setText:@"%"];
    [lbl_prec setFont:[UIFont systemFontOfSize:25]];
    [lbl_prec setTextAlignment:NSTextAlignmentCenter];
    [lbl_prec setTextColor:[UIColor whiteColor]];
    //[lbl_prec setBackgroundColor:[UIColor redColor]];
    lbl_prec.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_prec];
    
    [lbl_prec addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LP(30)]" options:0 metrics:nil views:@{@"LP":lbl_prec}]];
    [lbl_prec addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LP(100)]" options:0 metrics:nil views:@{@"LP":lbl_prec}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-190-[LP]" options:0 metrics:nil views:@{@"LP":lbl_prec}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_prec
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    
    lbl_totalMsg = [UILabel new];
    [lbl_totalMsg setText:@"Total Number Of Messages"];
    [lbl_totalMsg setFont:[UIFont systemFontOfSize:20]];
    lbl_totalMsg.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_totalMsg];
    
    [lbl_totalMsg addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LUP(30)]" options:0 metrics:nil views:@{@"LUP":lbl_totalMsg}]];
    [lbl_totalMsg addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LUP(250)]" options:0 metrics:nil views:@{@"LUP":lbl_totalMsg}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-230-[LUP]" options:0 metrics:nil views:@{@"LUP":lbl_totalMsg}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_totalMsg
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    lbl_msgcount = [UILabel new];
    //[lbl_msgcount setText:@"count"];
    [lbl_msgcount setFont:[UIFont boldSystemFontOfSize:30]];
    [lbl_msgcount setTextAlignment:NSTextAlignmentCenter];
    //[lbl_msgcount setBackgroundColor:[UIColor redColor]];
    [lbl_msgcount setTextColor:[UIColor redColor]];
    lbl_msgcount.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lbl_msgcount];
    
    [lbl_msgcount addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LMC(50)]" options:0 metrics:nil views:@{@"LMC":lbl_msgcount}]];
    [lbl_msgcount addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LMC(100)]" options:0 metrics:nil views:@{@"LMC":lbl_msgcount}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-270-[LMC]" options:0 metrics:nil views:@{@"LMC":lbl_msgcount}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lbl_msgcount
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];


                  
}

#pragma syncing table class during operation to update data delegates

- (void) syncStartedForPosn:(NSInteger) p_posnNo
{
    [_syncData setValue:@(0) forKey:@"pull"];
    [_syncData setValue:@(0) forKey:@"pullperc"];
    [self setDisplayInformation];
}

- (void) syncCompletedForPosn:(NSInteger) p_posnNo noOfPulls:(NSInteger) p_pulls noOfPushes:(NSInteger) p_pushes withPullPerc:(NSInteger)p_pullPerc
{
    [_syncData setValue:@(p_pulls) forKey:@"pull"];
    [_syncData setValue:@(p_pullPerc) forKey:@"pullperc"];
    [self setDisplayInformation];
}


- (void) setDisplayInformation
{
    indicator.progress = [[_syncData valueForKey:@"pullperc"] floatValue]/100.0;
    lbl_prec.text = [NSString stringWithFormat:@"%@:%ld%%",@"\u2193", (long)[[_syncData valueForKey:@"pullperc"] integerValue]];
    lbl_msgcount.text = [NSString stringWithFormat:@"%@:%ld",@"\u2193", (long)[[_syncData valueForKey:@"pull"] integerValue]];
}

@end
