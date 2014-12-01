//
//  UIImage+image.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 11/30/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)

- (UIImage *)imageWithRoundedCorners:(CGFloat)cornerRadius
                         borderWidth:(CGFloat)borderWidth
                         borderColor:(UIColor *)borderColor {
    // If the image does not have an alpha layer, add one
    UIImage *image = [self imageWithAlpha];
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height );
    size_t fw = CGRectGetWidth(imageRect);
    size_t fh = CGRectGetHeight(imageRect);
    
    // Build a context that's the same dimensions as the new size
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 fw,
                                                 fh,
                                                 CGImageGetBitsPerComponent(image.CGImage),
                                                 0,
                                                 CGImageGetColorSpace(image.CGImage),
                                                 kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
   
    
    // Create a clipping path with rounded corners
    CGContextBeginPath(context);
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 0, 0);
    CGContextScaleCTM(context, 1, 1);
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, cornerRadius);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, cornerRadius);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, cornerRadius);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, cornerRadius);
    CGContextClosePath(context);
//    CGContextRestoreGState(context);
//    CGContextClosePath(context);
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGContextSetLineWidth(context, 10);
    CGContextStrokePath(context);

    CGContextClip(context);

    CGContextDrawImage(context, imageRect, image.CGImage);
    


    
    //    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:imageRect cornerRadius:(fw / 2.0f)];
    ////    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    ////    CGContextSetLineWidth(context, 5.0);
    //    bezierPath.lineWidth = 5.0f;
    //    CGContextAddPath(context, bezierPath.CGPath);
    //    [bezierPath strokeWithBlendMode:kCGBlendModeSaturation alpha:0.8f];
    
    // Create a CGImage from the context
    CGImageRef clippedImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    // Create a UIImage from the CGImage
    UIImage *roundedImage = [UIImage imageWithCGImage:clippedImage scale:1 orientation:UIImageOrientationUp];
    CGImageRelease(clippedImage);
    
    return roundedImage;
}

// Returns a copy of the given image, adding an alpha channel if it doesn't already have one
- (UIImage *)imageWithAlpha {
    if ([self hasAlpha]) {
        //        return self;
    }
    
    CGImageRef imageRef = self.CGImage;
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    // The bitsPerComponent and bitmapInfo values are hard-coded to prevent an "unsupported parameter combination" error
    CGContextRef offscreenContext = CGBitmapContextCreate(NULL,
                                                          width,
                                                          height,
                                                          8,
                                                          0,
                                                          CGImageGetColorSpace(imageRef),
                                                          kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    
    // Draw the image into the context and retrieve the new image, which will now have an alpha layer
    CGContextDrawImage(offscreenContext, CGRectMake(0, 0, width, height), imageRef);
    CGImageRef imageRefWithAlpha = CGBitmapContextCreateImage(offscreenContext);
    UIImage *imageWithAlpha = [UIImage imageWithCGImage:imageRefWithAlpha scale:self.scale orientation:self.imageOrientation];
    
    // Clean up
    CGContextRelease(offscreenContext);
    CGImageRelease(imageRefWithAlpha);
    
    return imageWithAlpha;
}

// Copied and modified from http://vocaro.com/trevor/blog/2009/10/12/resize-a-uiimage-the-right-way/
// Returns true if the image has an alpha layer
- (BOOL)hasAlpha {
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}


@end
