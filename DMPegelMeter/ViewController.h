//
//  ViewController.h
//  DMPegelMeter
//
//  Created by Michael Johann on 22.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <RKObjectLoaderDelegate> {
    BOOL _isRunning;
}

@property (weak, nonatomic) IBOutlet UILabel *hostIPLabel;
@property (weak, nonatomic) IBOutlet UILabel *signal;
@property (weak, nonatomic) IBOutlet UIProgressView *signalPercent;
@property (weak, nonatomic) IBOutlet UILabel *ber;
@property (weak, nonatomic) IBOutlet UIProgressView *acg;
@property (weak, nonatomic) IBOutlet UISlider *reloadRate;
@property (weak, nonatomic) IBOutlet UILabel *reloadLabel;
@property (weak, nonatomic) IBOutlet UIButton *pauseContinueButton;
@property (nonatomic) IBOutlet BOOL isRunning;
@property (weak, nonatomic) IBOutlet UILabel *signalPercentLabel;
@property (weak, nonatomic) IBOutlet UILabel *acgLabel;

- (IBAction)pauseContinuePressed:(id)sender;
- (IBAction)rateChanged:(id)sender;
@end
