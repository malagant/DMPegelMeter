//
//  PegelMessung.h
//  DMPegelMeter
//
//  Created by Michael Johann on 22.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PegelMessung : NSObject {
    NSString *_signal;
    NSString *_signalPercent;
    NSString *_ber;
    NSString *_acg;
}

@property(nonatomic, retain) NSString *signal;
@property(nonatomic, retain) NSString *signalPercent;
@property(nonatomic, retain) NSString *ber;
@property(nonatomic, retain) NSString *acg;

+(void)initMap:(RKObjectManager *)manager;

@end
