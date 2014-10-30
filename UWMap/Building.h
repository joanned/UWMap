//
//  Building.h
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/13/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

@interface Building : NSObject

@property (nonatomic, readonly) CGFloat positionX;
@property (nonatomic, readonly) CGFloat positionY;
@property (nonatomic, copy, readonly) NSString *hours;

- (instancetype)initWithpositionX:(CGFloat)positionX
                        positionY:(CGFloat)positionY
                            hours:(NSString *)hours;

@end
