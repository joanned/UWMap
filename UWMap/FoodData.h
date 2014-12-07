//
//  FoodData.h
//  UWMap
//
//  Created by DEV FLOATER 119 on 12/1/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodData : NSObject

@property   NSString *title;
@property   CGFloat xPosition;
@property   CGFloat yPosition;
@property   NSString *imageUrl;
@property   NSString *foodDescription;
@property   NSString *building;
@property   BOOL isOpenNow;
@property   NSString *mondayOpen;
@property   NSString *mondayClose;
@property   NSString *tuesdayOpen;
@property   NSString *tuesdayClose;
@property   NSString *wednesdayOpen;
@property   NSString *wednesdayClose;
@property   NSString *thursdayOpen;
@property   NSString *thursdayClose;
@property   NSString *fridayOpen;
@property   NSString *fridayClose;
@property   NSString *saturdayOpen;
@property   NSString *saturdayClose;
@property   NSString *sundayOpen;
@property   NSString *sundayClose;

//- (instancetype)initWithTitle:(NSString *)title
//                        imageUrl:(NSURL *)imageUrl
//                  description:(NSString *)description
//                    isOpenNow:(BOOL)isOpenNow
//                   mondayOpen:(NSString *)mondayOpen
//                  mondayClose:(NSString *)mondayClose
//                  tuesdayOpen:(NSString *)tuesdayOpen
//                 tuesdayClose:(NSString *)tuesdayClose
//                wednesdayOpen:(NSString *)wednesdayOpen
//               wednesdayClose:(NSString *)wednesdayClose
//                 thursdayOpen:(NSString *)thursdayOpen
//                thursdayClose:(NSString *)thursdayClose
//                   fridayOpen:(NSString *)fridayOpen
//                  fridayClose:(NSString *)fridayClose
//                 saturdayOpen:(NSString *)saturdayOpen
//                saturdayClose:(NSString *)saturdayClose
//                   sundayOpen:(NSString *)sundayOpen
//                  sundayClose:(NSString *)sundayClose;
//



@end
