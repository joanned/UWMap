//
//  FoodDataFetcher.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 12/1/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import "FoodDataFetcher.h"
#import "DataProvider.h"

//const NSString *kAPILink = @"https://api.uwaterloo.ca/v2/foodservices/locations.json?key=31e50cdb727260547b9c7b6e40fb0288";

@implementation FoodDataFetcher

- (void)getFoodData {
    NSString *urlString = @"https://api.uwaterloo.ca/v2/foodservices/locations.json?key=31e50cdb727260547b9c7b6e40fb0288";

    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"fetching data failed with error: %@", [connectionError localizedDescription]);
        } else {
            [self receivedData:data];
        }
    }];
}

- (void)receivedData:(NSData *)data {
    NSError *error = nil;
    NSArray *foodDataArray = [DataProvider foodArrayFromJson:data error:&error];
    
    if (error) {
        NSLog(@"parsing data failed with error: %@", [error localizedDescription]);
    } else {
        [self.delegate foodDataFinishedLoading:foodDataArray];
    }
}





@end
