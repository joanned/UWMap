//
//  PinView.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/19/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import "PinView.h"

@interface PinView ()



@end

const float strokeWidth = 1.0f;
const float borderRadius = 8;
const float triangleHeight = 20;
const float triangleWidth = 40;

@implementation PinView

- (void)drawRect:(CGRect)rect {
    CGRect currentFrame = CGRectMake(0, 0, 100, 50);
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, strokeWidth);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75].CGColor);
    
    // Draw and fill the bubble
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, borderRadius + strokeWidth + 0.5f, strokeWidth + triangleHeight + 0.5f);
    CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f - triangleWidth / 2.0f) + 0.5f, triangleHeight + strokeWidth + 0.5f);
    CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f) + 0.5f, strokeWidth + 0.5f);
    CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0f + triangleWidth / 2.0f) + 0.5f, triangleHeight + strokeWidth + 0.5f);
    CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth - 0.5f, strokeWidth + triangleHeight + 0.5f, currentFrame.size.width - strokeWidth - 0.5f, currentFrame.size.height - strokeWidth - 0.5f, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth - 0.5f, currentFrame.size.height - strokeWidth - 0.5f, round(currentFrame.size.width / 2.0f + triangleWidth / 2.0f) - strokeWidth + 0.5f, currentFrame.size.height - strokeWidth - 0.5f, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, strokeWidth + 0.5f, currentFrame.size.height - strokeWidth - 0.5f, strokeWidth + 0.5f, triangleHeight + strokeWidth + 0.5f, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, strokeWidth + 0.5f, strokeWidth + triangleHeight + 0.5f, currentFrame.size.width - strokeWidth - 0.5f, triangleHeight + strokeWidth + 0.5f, borderRadius - strokeWidth);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // Draw a clipping path for the fill
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, borderRadius + strokeWidth + 0.5f, round((currentFrame.size.height + triangleHeight) * 0.50f) + 0.5f);
    CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth - 0.5f, round((currentFrame.size.height + triangleHeight) * 0.50f) + 0.5f, currentFrame.size.width - strokeWidth - 0.5f, currentFrame.size.height - strokeWidth - 0.5f, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth - 0.5f, currentFrame.size.height - strokeWidth - 0.5f, round(currentFrame.size.width / 2.0f + triangleWidth / 2.0f) - strokeWidth + 0.5f, currentFrame.size.height - strokeWidth - 0.5f, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, strokeWidth + 0.5f, currentFrame.size.height - strokeWidth - 0.5f, strokeWidth + 0.5f, triangleHeight + strokeWidth + 0.5f, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, strokeWidth + 0.5f, round((currentFrame.size.height + triangleHeight) * 0.50f) + 0.5f, currentFrame.size.width - strokeWidth - 0.5f, round((currentFrame.size.height + triangleHeight) * 0.50f) + 0.5f, borderRadius - strokeWidth);
    CGContextClosePath(context);
    CGContextClip(context);
    
}

//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context=UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, .5f);
//    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
//        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75].CGColor);
//    
//    CGRect rrect = CGRectMake(0, 0, 100, 50);
//    rrect.origin.y++;
//    CGFloat radius = borderRadius;
//    
//    CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
//    CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
//    
//    CGMutablePathRef outlinePath = CGPathCreateMutable();
////    
////    if (![User isCurrentUser:message.user])
////    {
//        minx += 20;
//    
//        CGPathMoveToPoint(outlinePath, nil, midx, miny);
//        CGPathAddArcToPoint(outlinePath, nil, maxx, miny, maxx, midy, radius);
//        CGPathAddArcToPoint(outlinePath, nil, maxx, maxy, midx, maxy, radius);
//        CGPathAddArcToPoint(outlinePath, nil, minx, maxy, minx, midy, radius);
//        CGPathAddLineToPoint(outlinePath, nil, minx, miny + 20);
//        CGPathAddLineToPoint(outlinePath, nil, minx - 5, miny + 15);
//        CGPathAddLineToPoint(outlinePath, nil, minx, miny + 10);
//        CGPathAddArcToPoint(outlinePath, nil, minx, miny, midx, miny, radius);
//        CGPathCloseSubpath(outlinePath);
//        
//        CGContextSetShadowWithColor(context, CGSizeMake(0,1), 1, [UIColor lightGrayColor].CGColor);
//        CGContextAddPath(context, outlinePath);
//        CGContextFillPath(context);
//        
//        CGContextAddPath(context, outlinePath);
//        CGContextClip(context);
//        CGPoint start = CGPointMake(rect.origin.x, rect.origin.y);
//        CGPoint end = CGPointMake(rect.origin.x, rect.size.height);
//        CGContextDrawLinearGradient(context, [self normalGradient], start, end, 0);
////    }
////    else
////    {
////        maxx-=5;
////        CGPathMoveToPoint(outlinePath, nil, midx, miny);
////        CGPathAddArcToPoint(outlinePath, nil, minx, miny, minx, midy, radius);
////        CGPathAddArcToPoint(outlinePath, nil, minx, maxy, midx, maxy, radius);
////        CGPathAddArcToPoint(outlinePath, nil, maxx, maxy, maxx, midy, radius);
////        CGPathAddLineToPoint(outlinePath, nil, maxx, miny + 20);
////        CGPathAddLineToPoint(outlinePath, nil, maxx + 5, miny + 15);
////        CGPathAddLineToPoint(outlinePath, nil, maxx, miny + 10);
////        CGPathAddArcToPoint(outlinePath, nil, maxx, miny, midx, miny, radius);
////        CGPathCloseSubpath(outlinePath);
////        
////        CGContextSetShadowWithColor(context, CGSizeMake(0,1), 1, [UIColor lightGrayColor].CGColor);
////        CGContextAddPath(context, outlinePath);
////        CGContextFillPath(context);
////        
////        CGContextAddPath(context, outlinePath);
////        CGContextClip(context);
////        CGPoint start = CGPointMake(rect.origin.x, rect.origin.y);
////        CGPoint end = CGPointMake(rect.origin.x, rect.size.height);
////        CGContextDrawLinearGradient(context, [self greenGradient], start, end, 0);
////    }
//    
//    
//    CGContextDrawPath(context, kCGPathFillStroke);
//    
//}
//
//- (CGGradientRef)normalGradient
//{
//    
//    NSMutableArray *normalGradientLocations = [NSMutableArray arrayWithObjects:
//                                               [NSNumber numberWithFloat:0.0f],
//                                               [NSNumber numberWithFloat:1.0f],
//                                               nil];
//    
//    
//    NSMutableArray *colors = [NSMutableArray arrayWithCapacity:2];
//    
//    UIColor *color = [UIColor blackColor];
//    [colors addObject:(id)[color CGColor]];
//    color = [UIColor darkGrayColor];
//    [colors addObject:(id)[color CGColor]];
//    NSMutableArray  *normalGradientColors = colors;
//    
//    int locCount = [normalGradientLocations count];
//    CGFloat locations[locCount];
//    for (int i = 0; i < [normalGradientLocations count]; i++)
//    {
//        NSNumber *location = [normalGradientLocations objectAtIndex:i];
//        locations[i] = [location floatValue];
//    }
//    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
//    
//    CGGradientRef normalGradient = CGGradientCreateWithColors(space, (__bridge CFArrayRef)normalGradientColors, locations);
//    CGColorSpaceRelease(space);
//    
//    return normalGradient;
//}
//

@end
