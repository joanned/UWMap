//
//  UIImage+image.h
//  UWMap
//
//  Created by DEV FLOATER 119 on 11/30/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (image)
//- (UIImage *)croppedImageUsingRect:(CGRect)rect;
//- (UIImage *)drawImage:(UIImage *)inputImage atPoint:(CGPoint)point;

- (UIImage *)imageWithRoundedCorners:(CGFloat)cornerRadius
                         borderWidth:(CGFloat)borderWidth
                         borderColor:(UIColor *)borderColor;

//+ (UIImage *)combineImage:(UIImage *)image1
//               aboveImage:(UIImage *)image2;
@end
