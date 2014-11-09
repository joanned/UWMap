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
        [self setupSubviews];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (id)initWithWidth:(CGFloat)width {
    return [self initWithFrame:CGRectMake(0.0, 0.0, width, 98.0)];
}

- (id)initWithTitle:(NSString *)title detail:(NSString *)detail
{
    CGFloat defaultWidth = 150.0;
    
    CGSize size = CGSizeMake(100.0, 8000);
    
    CGRect titleRect = [title boundingRectWithSize:size
                                           options:
                        NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}
                                           context:nil];
    
    CGRect hoursRect = [detail boundingRectWithSize:size
                                           options:
                        NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]}
                                           context:nil];
    CGFloat viewHeight = titleRect.size.height + hoursRect.size.height + 20.0;
    self = [self initWithFrame:CGRectMake(0, 0, defaultWidth, viewHeight)];
    
//    CGFloat detailHeight = [[self detail] sizeWithFont:[_detailLabel font] constrainedToSize:CGSizeMake(defaultWidth-120.0, maxHeight-78.0) lineBreakMode:[_detailLabel lineBreakMode]].height;
//    if (detailHeight < 20)
//        detailHeight = 20.0;
//    CGFloat notifHeight = detailHeight + 78.0;
//    self = [self initWithFrame:CGRectMake(0.0, 0.0, defaultWidth, notifHeight)];
    if (self) {
        [_titleLabel setText:title];
        [_detailLabel setText:detail];
    }
    return self;
}

- (void) setupSubviews {
    self.backgroundColor = [UIColor clearColor];
    self.color = [UIColor blackColor];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 20)];
    _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.shadowColor = [UIColor blackColor];
    _titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    _titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLabel.numberOfLines = 3;
    [self addSubview:_titleLabel];
    
//    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(90.0, 52.0, self.frame.size.width-120.0, 20.0)];
//    _detailLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    _detailLabel.backgroundColor = [UIColor clearColor];
//    _detailLabel.textColor = [UIColor lightGrayColor];
//    _detailLabel.shadowColor = [UIColor blackColor];
//    _detailLabel.shadowOffset = CGSizeMake(0.0, 1.0);
//    _detailLabel.font = [UIFont boldSystemFontOfSize:16.0];
//    _detailLabel.numberOfLines = 0;
//    [self addSubview:_detailLabel];
}

- (void) setColor:(UIColor *)color {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    UIColor* border = [color colorWithAlphaComponent:0.6];
    UIColor* topColor = [self lightenColor:border value:0.37];
    UIColor* midColor = [self lightenColor:border value:0.1];
    UIColor* bottomColor = [self lightenColor:border value:0.12];
    
    NSArray* newGradientColors = [NSArray arrayWithObjects:
                                  (id)topColor.CGColor,
                                  (id)midColor.CGColor,
                                  (id)border.CGColor,
                                  (id)border.CGColor,
                                  (id)bottomColor.CGColor, nil];
    CGFloat newGradientLocations[] = {0, 0.500, 0.501, 0.66, 1};
    
    CGGradientRelease(_gradient);
    _gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)newGradientColors, newGradientLocations);
    CGColorSpaceRelease(colorSpace);
    
    [self setNeedsDisplay];
}

//- (UIColor *) color {
//    return _color;
//}

//- (void) setIcon:(UIImage *)icon {
//    if (_iconView) {
//        [_iconView setImage:icon];
//    }
//}
//- (UIImage *) icon {
//    return [_iconView image];
//}

- (void) setTitle:(NSString *)title {
    [_titleLabel setText:title];
}
- (NSString *)title {
    return [_titleLabel text];
}

- (void) setDetail:(NSString *)detail {
    [_detailLabel setText:detail];
//    [self updateHeight];
}
- (NSString*)detail {
    return [_detailLabel text];
}

- (void) setWidth:(CGFloat)width {
    CGRect f = self.frame;
    f.size.width = width;
    [self setFrame:f];
//    [self updateHeight];
}
- (CGFloat) width {
    return self.bounds.size.width;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor* border = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    //// Shadow Declarations
    UIColor* shadow = [self lightenColor:border value:0.65];
    CGSize shadowOffset = CGSizeMake(0, 2);
    CGFloat shadowBlurRadius = 0;
    UIColor* shadow2 = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    CGSize shadow2Offset = CGSizeMake(0.0, 2.0);
    CGFloat shadow2BlurRadius = 4.0;
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(4.5, 2.5, rect.size.width-8.0, rect.size.height-8.0) cornerRadius: 10];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow2Offset, shadow2BlurRadius, shadow2.CGColor);
    CGContextSetFillColorWithColor(context, shadow2.CGColor);
    [roundedRectanglePath fill];
    [roundedRectanglePath addClip];
    CGContextDrawLinearGradient(context, _gradient, CGPointMake(0.0, 2.5), CGPointMake(0.0, rect.size.height-5.5), 0);
    
    ////// Rounded Rectangle Inner Shadow
    CGRect roundedRectangleBorderRect = CGRectInset([roundedRectanglePath bounds], -shadowBlurRadius, -shadowBlurRadius);
    roundedRectangleBorderRect = CGRectOffset(roundedRectangleBorderRect, -shadowOffset.width, -shadowOffset.height);
    roundedRectangleBorderRect = CGRectInset(CGRectUnion(roundedRectangleBorderRect, [roundedRectanglePath bounds]), -1, -1);
    
    UIBezierPath* roundedRectangleNegativePath = [UIBezierPath bezierPathWithRect: roundedRectangleBorderRect];
    [roundedRectangleNegativePath appendPath: roundedRectanglePath];
    roundedRectangleNegativePath.usesEvenOddFillRule = YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = shadowOffset.width + round(roundedRectangleBorderRect.size.width);
        CGFloat yOffset = shadowOffset.height;
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                    shadowBlurRadius,
                                    shadow.CGColor);
        
        [roundedRectanglePath addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(roundedRectangleBorderRect.size.width), 0);
        [roundedRectangleNegativePath applyTransform: transform];
        [[UIColor grayColor] setFill];
        [roundedRectangleNegativePath fill];
    }
    CGContextRestoreGState(context);
    
    CGContextRestoreGState(context);
    
    [border setStroke];
    roundedRectanglePath.lineWidth = 1;
    [roundedRectanglePath stroke];
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

//- (void) updateHeight {
//    CGSize size = CGSizeMake(100.0, 8000);
//    
//        CGRect titleRect = [_title boundingRectWithSize:size
//                                                options:
//                             NSStringDrawingUsesLineFragmentOrigin
//                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}
//                                                          context:nil];
//    
//        CGRect hoursRect = [hours boundingRectWithSize:size
//                                              options:
//                           NSStringDrawingUsesLineFragmentOrigin
//                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]}
//                                              context:nil];
//        CGFloat viewHeight = titleRect.size.height + hoursRect.size.height + 20.0;
//        self = [self initWithFrame:CGRectMake(0, 0, 100.0, viewHeight)];
////    CGRect f = self.frame;
////    CGFloat detailHeight = [[self detail] sizeWithFont:[_detailLabel font] constrainedToSize:CGSizeMake(f.size.width-120.0, maxHeight-78.0) lineBreakMode:[_detailLabel lineBreakMode]].height;
////    if (detailHeight < 20)
////        detailHeight = 20.0;
////    f.size.height = detailHeight + 78.0;
////    self.frame = f;
////    
////    [_detailLabel setFrame:CGRectMake(90.0, 52.0, f.size.width-120.0, detailHeight)];
//}
//
//- (void) dealloc {
//    [_color release];
//    [_iconView release];
//    [_titleLabel release];x
//    [_detailLabel release];
//    
//    CGGradientRelease(_gradient);
//    [super dealloc];
//}

@end

//- (id) init {
//    self = [super init];
//    if (self) {
//        [self setupSubviews];
//    }
//    return self;
//}
//
//- (id)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self setupSubviews];
//    }
//    return self;
//}
//
//- (id) initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        [self setupSubviews];
//    }
//    return self;
//}
//
//- (id)initWithTitle:(NSString *)title hours:(NSString *)hours {
//    CGSize size = CGSizeMake(100.0, 8000);
//    
//    CGRect titleRect = [title boundingRectWithSize:size
//                                            options:
//                         NSStringDrawingUsesLineFragmentOrigin
//                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}
//                                                      context:nil];
//    
//    CGRect hoursRect = [hours boundingRectWithSize:size
//                                          options:
//                       NSStringDrawingUsesLineFragmentOrigin
//                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]}
//                                          context:nil];
//    CGFloat viewHeight = titleRect.size.height + hoursRect.size.height + 20.0;
//    self = [self initWithFrame:CGRectMake(0, 0, 100.0, viewHeight)];
//    if (self) {
//        [titleLabel setText:title];
//        [hoursLabel setText:hours];
//    }
//    return self;
//    
//}
//
//- (void) setupSubviews {
//    
////    CGRect rect = self.frame;
////    rect.size.width = 200;
////    [self setFrame:rect];
//    
//    [self setupGradient];
//    
//    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 50)];
//    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.shadowColor = [UIColor blackColor];
//    titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
//    titleLabel.font = [UIFont boldSystemFontOfSize:22.0];
//    [self addSubview:titleLabel];
//    
//    hoursLabel = [[UILabel alloc] initWithFrame:CGRectMake(90.0, 52.0, self.frame.size.width-120.0, 20.0)];
//    hoursLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    hoursLabel.backgroundColor = [UIColor clearColor];
//    hoursLabel.textColor = [UIColor lightGrayColor];
//    hoursLabel.shadowColor = [UIColor blackColor];
//    hoursLabel.shadowOffset = CGSizeMake(0.0, 1.0);
//    hoursLabel.font = [UIFont boldSystemFontOfSize:16.0];
//    hoursLabel.numberOfLines = 0;
//    [self addSubview:hoursLabel];
//}
//
//- (void)setupGradient {
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    
//    UIColor* border = [[UIColor blackColor] colorWithAlphaComponent:0.6];
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
//    
//    self.gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)newGradientColors, newGradientLocations);
//    CGColorSpaceRelease(colorSpace);
//    [self setNeedsDisplay];
//}
//
//- (void)drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    UIColor* border = [[UIColor blackColor] colorWithAlphaComponent:0.6];
//
//    //shadow
//    UIColor* shadowColour = [self lightenColor:border value:0.65];
//    UIColor *shadowColour2 = [[UIColor blackColor] colorWithAlphaComponent:0.75];
//    CGSize shadowOffset = CGSizeMake(1, 2);
//    CGFloat shadowBlurRadius = 0.2;
//    
//    //rounded rectangle
//    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(4.5, 2.5, rect.size.width-8.0, rect.size.height-8.0) cornerRadius: 10];
//    CGContextSaveGState(context);
//    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadowColour2.CGColor);
//    CGContextSetFillColorWithColor(context, shadowColour2.CGColor);
//    [roundedRectanglePath fill];
//    [roundedRectanglePath addClip];
//    CGContextDrawLinearGradient(context, _gradient, CGPointMake(0.0, 2.5), CGPointMake(0.0, rect.size.height-5.5), 0);
//    
//    // Rounded Rectangle Inner Shadow
//    CGRect roundedRectangleBorderRect = CGRectInset([roundedRectanglePath bounds], -shadowBlurRadius, -shadowBlurRadius);
//    roundedRectangleBorderRect = CGRectOffset(roundedRectangleBorderRect, -shadowOffset.width, -shadowOffset.height);
//    roundedRectangleBorderRect = CGRectInset(CGRectUnion(roundedRectangleBorderRect, [roundedRectanglePath bounds]), -1, -1);
//    
//    UIBezierPath* roundedRectangleNegativePath = [UIBezierPath bezierPathWithRect: roundedRectangleBorderRect];
//    [roundedRectangleNegativePath appendPath: roundedRectanglePath];
//    roundedRectangleNegativePath.usesEvenOddFillRule = YES;
//    
//    CGContextSaveGState(context);
//    {
//        CGFloat xOffset = shadowOffset.width + round(roundedRectangleBorderRect.size.width);
//        CGFloat yOffset = shadowOffset.height;
//        CGContextSetShadowWithColor(context,
//                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
//                                    shadowBlurRadius,
//                                    shadowColour.CGColor);
//        
//        [roundedRectanglePath addClip];
//        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(roundedRectangleBorderRect.size.width), 0);
//        [roundedRectangleNegativePath applyTransform: transform];
//        [[UIColor grayColor] setFill];
//        [roundedRectangleNegativePath fill];
//    }
//    CGContextRestoreGState(context);
//    
//    CGContextRestoreGState(context);
//    
//    [border setStroke];
//    roundedRectanglePath.lineWidth = 1;
//    [roundedRectanglePath stroke];
//
//}
//
//- (UIColor *)lightenColor:(UIColor *)oldColor value:(float)value {
//    int   totalComponents = CGColorGetNumberOfComponents(oldColor.CGColor);
//    bool  isGreyscale     = totalComponents == 2 ? YES : NO;
//    
//    CGFloat* oldComponents = (CGFloat *)CGColorGetComponents(oldColor.CGColor);
//    CGFloat newComponents[4];
//    
//    if (isGreyscale) {
//        newComponents[0] = oldComponents[0]+value > 1.0 ? 1.0 : oldComponents[0]+value;
//        newComponents[1] = oldComponents[0]+value > 1.0 ? 1.0 : oldComponents[0]+value;
//        newComponents[2] = oldComponents[0]+value > 1.0 ? 1.0 : oldComponents[0]+value;
//        newComponents[3] = oldComponents[1];
//    } else {
//        newComponents[0] = oldComponents[0]+value > 1.0 ? 1.0 : oldComponents[0]+value;
//        newComponents[1] = oldComponents[1]+value > 1.0 ? 1.0 : oldComponents[1]+value;
//        newComponents[2] = oldComponents[2]+value > 1.0 ? 1.0 : oldComponents[2]+value;
//        newComponents[3] = oldComponents[3];
//    }
//    
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
//    CGColorSpaceRelease(colorSpace);
//    
//    UIColor *retColor = [UIColor colorWithCGColor:newColor];
//    CGColorRelease(newColor);
//    
//    return retColor;
//}
//
//@end
