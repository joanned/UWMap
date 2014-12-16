//
//  DateStringConverter.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 12/15/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import "DateStringConverter.h"

@interface DateStringConverter ()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation DateStringConverter

- (instancetype)init {
    if (self = [super init]) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [self.dateFormatter setLocale:locale];
        [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    }
    
    return self;
}

- (NSString *)convertedDateFromString:(NSString *)dateString {
    [self.dateFormatter setDateFormat:@"HH:mm"];
    NSDate *date = [self.dateFormatter dateFromString:(NSString *)dateString];
    [self.dateFormatter setDateFormat:@"h:mma"];
    
    NSString *convertedDateString = [[self.dateFormatter stringFromDate:date] lowercaseString];;
    
    return convertedDateString;
}

@end
