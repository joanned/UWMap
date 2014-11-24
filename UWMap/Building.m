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

- (instancetype)initWithBuildingName:(NSString *)buildingName
                           shortform:(NSString *)shortform
                           positionX:(CGFloat)positionX
                        positionY:(CGFloat)positionY
                            hours:(NSString *)hours {
    
    self = [super init];
    if (self) {
        _buildingName = buildingName;
        _shortform = shortform;
        _positionX = positionX;
        _positionY = positionY;
        _hours = hours;
    }
    
    return self;
}

@end
