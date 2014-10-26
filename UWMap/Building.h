//
//  Building.h
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/13/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

@interface Building : NSObject

@property (nonatomic, readonly) NSValue *locationPoint;
@property (nonatomic, readonly) NSValue *locationRect;
@property (nonatomic, copy, readonly) NSString *hours;

- (instancetype)initWithlocationPoint:(NSValue *)locationPoint
                         locationRect:(NSValue *)locationRect
                                hours:(NSString *)hours;

@end
