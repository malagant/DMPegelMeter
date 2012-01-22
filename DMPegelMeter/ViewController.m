//
//  ViewController.m
//  DMPegelMeter
//
//  Created by Michael Johann on 22.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <RestKit/RKObjectManager.h>
#import "ViewController.h"
#import "PegelMessung.h"

@implementation ViewController {
    NSString *hostIPValue;
}
@synthesize hostIPLabel;
@synthesize signal;
@synthesize signalPercent;
@synthesize ber;
@synthesize acg;
@synthesize reloadRate;
@synthesize reloadLabel;
@synthesize pauseContinueButton;
@synthesize isRunning = _isRunning;
@synthesize signalPercentLabel;
@synthesize acgLabel;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    signalPercent.progress = 0;
    acg = 0;
    self.isRunning = NO;
    hostIPValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"host_ip"];
    hostIPLabel.text = [NSString stringWithFormat:@"Using Host IP: %@", hostIPValue];
    [RKObjectManager objectManagerWithBaseURL:[NSString stringWithFormat:@"http://%@/web", hostIPValue]];
    [PegelMessung initMap:[RKObjectManager sharedManager]];
}

- (void)viewDidUnload
{
    [self setHostIPLabel:nil];
    [self setSignal:nil];
    [self setSignalPercent:nil];
    [self setBer:nil];
    [self setAcg:nil];
    [self setReloadRate:nil];
    [self setReloadLabel:nil];
    [self setPauseContinueButton:nil];
    [self setSignalPercentLabel:nil];
    [self setAcgLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)pauseUpdatingPegel {
   //To change the template use AppCode | Preferences | File Templates.

}

- (void)continueUpdatingPegel {
    PegelMessung *pegelMessung = [PegelMessung new];

    if(self.isRunning == YES) {
        [[RKObjectManager sharedManager] getObject:pegelMessung delegate:self];
    }
}

- (IBAction)pauseContinuePressed:(id)sender {
    if (self.isRunning == YES) {
        self.isRunning = NO;
        [pauseContinueButton setTitle:@"Continue" forState:UIControlStateNormal];
        [self pauseUpdatingPegel];
    } else {
        self.isRunning = YES;
        [pauseContinueButton setTitle:@"Pause" forState:UIControlStateNormal];
        [self continueUpdatingPegel];
    }
}

- (IBAction)rateChanged:(id)sender {
    self.reloadLabel.text = [NSString stringWithFormat:@"Reload Data (%2.f per minute)", reloadRate.value];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object {
    NSLog(@"Found PegelMessung");
    PegelMessung *pegelMessung = object;
    float _signalPercent = [[pegelMessung.signalPercent substringToIndex:(pegelMessung.signalPercent.length - 2)] floatValue];
    float _acg = [[pegelMessung.acg substringToIndex:(pegelMessung.acg.length - 2)] floatValue];
    NSString *_ber = pegelMessung.ber;
    
    self.signal.text = [NSString stringWithFormat:@"Signal = %@", pegelMessung.signal];
    self.signalPercent.progress = _signalPercent / 100;
    self.signalPercentLabel.text = [NSString stringWithFormat:@"Signal = %2.f %%", _signalPercent];
    self.acg.progress = _acg / 100;
    self.acgLabel.text =  [NSString stringWithFormat:@"ACG = %2.f %%", _acg];
    self.ber.text = [NSString stringWithFormat:@"BER = %@", _ber];
    
    wait((int *) (int)(1000 / reloadRate.value * 17));
    [self continueUpdatingPegel];
}


- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    NSLog(@"ERROR reading PegelMessung %@", error);
}

@end
