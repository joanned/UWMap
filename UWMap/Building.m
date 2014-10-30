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

- (instancetype)initWithpositionX:(CGFloat)positionX
                        positionY:(CGFloat)positionY
                            hours:(NSString *)hours {
    
    self = [super init];
    if (self) {
        _positionX = positionX;
        _positionY = positionY;
        _hours = hours;
    }
    
    return self;
}

@end
