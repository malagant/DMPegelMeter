//
//  PegelMessung.m
//  DMPegelMeter
//
//  Created by Michael Johann on 22.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <RestKit/RKRequest.h>
#import "PegelMessung.h"

@implementation PegelMessung

@synthesize acg = _acg;
@synthesize ber = _ber;
@synthesize signalPercent = _signalPercent;
@synthesize signal = _signal;


+ (void)initMap:(RKObjectManager *)manager {
    manager.acceptMIMEType = RKMIMETypeXML;
    RKObjectMapping *pmsg = [RKObjectMapping mappingForClass:[PegelMessung class]];
    [pmsg mapKeyPath:@"e2snrdb" toAttribute:@"signal"];
    [pmsg mapKeyPath:@"e2snr" toAttribute:@"signalPercent"];
    [pmsg mapKeyPath:@"e2ber" toAttribute:@"ber"];
    [pmsg mapKeyPath:@"e2acg" toAttribute:@"acg"];
    [manager.mappingProvider setMapping:pmsg forKeyPath:@"e2frontendstatus"];
    [[manager router] routeClass:[PegelMessung class] toResourcePath:@"signal" forMethod:RKRequestMethodGET];
}

@end
