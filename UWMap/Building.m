//
//  Building.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/13/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import "Building.h"

@interface Building ()

@end

@implementation Building

- (instancetype)initWithlocationPoint:(NSValue *)locationPoint
                         locationRect:(NSValue *)locationRect
                                hours:(NSString *)hours {
    
    self = [super init];
    if (self) {
        _locationPoint = locationPoint;
        _locationRect = locationRect;
        _hours = hours;
    }
    
    return self;
}

@end
