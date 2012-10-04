//
//  InAppRageIAPHelper.m
//  InAppRage
//
//  Created by Ray Wenderlich on 2/28/11.
//  Copyright 2011 Ray Wenderlich. All rights reserved.
//

#import "InAppZapIAPHelper.h"

@implementation InAppZapIAPHelper


static InAppZapIAPHelper * _sharedHelper;

+ (InAppZapIAPHelper *) sharedHelper {
    
    if (_sharedHelper != nil) {
        return _sharedHelper;
    }
    _sharedHelper = [[InAppZapIAPHelper alloc] init];
    return _sharedHelper;
    
}

- (id)init {
    
    NSSet *productIdentifiers = [NSSet setWithObjects:@"28V8W66Z7L.com.videolark.StartupMarketingVideos.Pro", nil];
    if ((self = [super initWithProductIdentifiers:productIdentifiers])) {                
        
    }
    return self;
    
}

@end
