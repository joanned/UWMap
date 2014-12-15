//
//  LoadingView.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 12/15/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
}

- (IBAction)refreshButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(refreshButtonTapped)]) {
        [self.delegate refreshButtonTapped];
    }
}


@end
