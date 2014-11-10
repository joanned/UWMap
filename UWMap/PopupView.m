//
//  PopupView.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 11/2/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import "PopupView.h"

static CGFloat maxHeight = 168.0;


@implementation PopupView
@synthesize color = _color;


- (id) init {
    self = [super init];
    if (self) {
//        [self setupSubviews];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        [self setupSubviews];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
//        [self setupSubviews];
    }
    return self;
}

- (id)initWithWidth:(CGFloat)width {
    return [self initWithFrame:CGRectMake(0.0, 0.0, width, 98.0)];
}

- (id)initWithTitle:(NSString *)title detail:(NSString *)detail
{
    [self setupSubviewsWithTitle:title detail:detail];
    
    self = [self initWithFrame:CGRectMake(0, 0, _titleLabel.frame.size.width+31, _titleLabel.frame.size.height +34)];
    [self addSubview:_titleLabel];

    [self setupSubviewsWithTitle:title detail:detail];
    return self;
}

- (void) setupSubviewsWithTitle:(NSString *)title detail:(NSString *)detail {
    self.backgroundColor = [UIColor clearColor];
    self.color = [UIColor blackColor];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 13, 130, 500)];
    [_titleLabel setText:title];
    _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.shadowColor = [UIColor blackColor];
    _titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLabel.numberOfLines = 0;
    
    [_titleLabel sizeToFit];
}

- (void) setColor:(UIColor *)color {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    UIColor* border = [color colorWithAlphaComponent:0.6];
//    UIColor* topColor = [self lightenColor:border value:0.37];
//    UIColor* midColor = [self lightenColor:border value:0.1];
//    UIColor* bottomColor = [self lightenColor:border value:0.12];
//    
//    NSArray* newGradientColors = [NSArray arrayWithObjects:
//                                  (id)topColor.CGColor,
//                                  (id)midColor.CGColor,
//                                  (id)border.CGColor,
//                                  (id)border.CGColor,
//                                  (id)bottomColor.CGColor, nil];
//    CGFloat newGradientLocations[] = {0, 0.500, 0.501, 0.66, 1};
    
    
    NSArray* newGradientColors = [NSArray arrayWithObjects:
                                  (id)[UIColor clearColor].CGColor,
                                  (id)[UIColor blackColor].CGColor, nil];
    CGFloat newGradientLocations[] = {0, 1};

    
    CGGradientRelease(_gradient);
    _gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)newGradientColors, newGradientLocations);
    CGColorSpaceRelease(colorSpace);
    
    [self setNeedsDisplay];
}

- (void) setTitle:(NSString *)title {
    [_titleLabel setText:title];
}
- (NSString *)title {
    return [_titleLabel text];
}

- (void) setDetail:(NSString *)detail {
    [_detailLabel setText:detail];
}
- (NSString*)detail {
    return [_detailLabel text];
}

- (void) setWidth:(CGFloat)width {
    CGRect f = self.frame;
    f.size.width = width;
    [self setFrame:f];
}
- (CGFloat) width {
    return self.bounds.size.width;
}

- (void)drawRect:(CGRect)rect
{
    //TODO: move constants out
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat borderWidth = 1;
    CGFloat radius = 5;
    CGFloat arrowHeight = 1;
    CGFloat arrowWidth = 8;
    CGFloat roomForShadow = 5;
    CGFloat rectWidth = rect.size.width;
    CGFloat rectHeight = rect.size.height;
    
    CGFloat spaceToSide = roomForShadow + borderWidth;

    UIBezierPath *popupPath = [UIBezierPath bezierPath];
    
    //top left
    [popupPath moveToPoint:CGPointMake(radius + spaceToSide, spaceToSide)];
    [popupPath addLineToPoint:CGPointMake(rectWidth - radius - spaceToSide, spaceToSide)];
    
    //top right
    [popupPath addArcWithCenter:CGPointMake(rectWidth - spaceToSide - radius, spaceToSide + radius) radius:radius startAngle:-M_PI/2 endAngle:0 clockwise:YES];
    [popupPath addLineToPoint:CGPointMake(rectWidth - spaceToSide, rectHeight - spaceToSide - roomForShadow - radius-arrowHeight)];
    [popupPath addArcWithCenter:CGPointMake(rectWidth - spaceToSide - radius, rectHeight - roomForShadow - spaceToSide - radius-arrowHeight) radius:radius startAngle:0 endAngle:M_PI/2 clockwise:YES];
    
    //arrow part
    [popupPath addLineToPoint:CGPointMake(rectWidth/2 + arrowWidth, rectHeight - roomForShadow - spaceToSide-arrowHeight)];
    [popupPath addLineToPoint:CGPointMake(rectWidth/2, rectHeight - spaceToSide +arrowHeight)];
    [popupPath addLineToPoint:CGPointMake(rectWidth/2 - arrowWidth, rectHeight - roomForShadow - spaceToSide-arrowHeight)];
    
    //bottom left
    [popupPath addLineToPoint:CGPointMake(spaceToSide + radius, rectHeight - roomForShadow - spaceToSide-arrowHeight)];
    [popupPath addArcWithCenter:CGPointMake(spaceToSide + radius, rectHeight - roomForShadow - spaceToSide - radius-arrowHeight) radius:radius startAngle:M_PI/2 endAngle:M_PI clockwise:YES];
    
    
    
    [popupPath addLineToPoint:CGPointMake(spaceToSide, spaceToSide + radius)];
    [popupPath addArcWithCenter:CGPointMake(spaceToSide + radius, spaceToSide + radius) radius:radius startAngle:M_PI endAngle:-M_PI/2 clockwise:YES];
    [popupPath closePath];
    

    
    //////
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
    UIColor* border = [[UIColor blackColor] colorWithAlphaComponent:0.75];
    
    // Shadow Declarations
    UIColor* shadow2 = [[UIColor blackColor] colorWithAlphaComponent:1];
    CGSize shadow2Offset = CGSizeMake(3, 3);
    CGFloat shadow2BlurRadius = 4;
//
////    // Rounded Rectangle Drawing
//    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(4.5, 2.5, rect.size.width-15, rect.size.height-15) cornerRadius: 10];
//    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow2Offset, shadow2BlurRadius, shadow2.CGColor);
    CGContextSetFillColorWithColor(context, [[UIColor blackColor] colorWithAlphaComponent:0.6].CGColor);
    [popupPath fill];
    [popupPath addClip];
    
    
    
    CGContextDrawLinearGradient(context, _gradient, CGPointMake(0.0, 2.5), CGPointMake(0.0, rect.size.height-5.5), 0);
    
    
//    CGContextRestoreGState(context);
    
    [border setStroke];
    popupPath.lineWidth = 1;
    [popupPath stroke];
}



- (UIColor *)lightenColor:(UIColor *)oldColor value:(float)value {
    int   totalComponents = CGColorGetNumberOfComponents(oldColor.CGColor);
    bool  isGreyscale     = totalComponents == 2 ? YES : NO;
    
    CGFloat* oldComponents = (CGFloat *)CGColorGetComponents(oldColor.CGColor);
    CGFloat newComponents[4];
    
    if (isGreyscale) {
        newComponents[0] = oldComponents[0]+value > 1.0 ? 1.0 : oldComponents[0]+value;
        newComponents[1] = oldComponents[0]+value > 1.0 ? 1.0 : oldComponents[0]+value;
        newComponents[2] = oldComponents[0]+value > 1.0 ? 1.0 : oldComponents[0]+value;
        newComponents[3] = oldComponents[1];
    } else {
        newComponents[0] = oldComponents[0]+value > 1.0 ? 1.0 : oldComponents[0]+value;
        newComponents[1] = oldComponents[1]+value > 1.0 ? 1.0 : oldComponents[1]+value;
        newComponents[2] = oldComponents[2]+value > 1.0 ? 1.0 : oldComponents[2]+value;
        newComponents[3] = oldComponents[3];
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
    CGColorSpaceRelease(colorSpace);
    
    UIColor *retColor = [UIColor colorWithCGColor:newColor];
    CGColorRelease(newColor);
    
    return retColor;
}

@end
