//
//  PopupView.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 11/2/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import "PopupView.h"


@implementation PopupView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title hours:(NSString *)hours {
    CGSize size = CGSizeMake(100.0, 8000);
    
    CGRect titleRect = [title boundingRectWithSize:size
                                            options:
                         NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}
                                                      context:nil];
    
    CGRect hoursRect = [hours boundingRectWithSize:size
                                          options:
                       NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]}
                                          context:nil];
    CGFloat viewHeight = titleRect.size.height + hoursRect.size.height + 20.0;
    self = self initWithFrame:CGRectMake(0, 0, 100.0, viewHeight);
    if (self) {
        
    }
    
}

- (void) setupSubviews {
    
}

@end
