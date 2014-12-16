//
//  FoodDataParser.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 12/15/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import "FoodDataParser.h"
#import "Constants.h"
#import "FoodData.h"
#import "NSString+HTML.h"
#import "DateStringConverter.h"

@implementation FoodDataParser

+ (NSMutableDictionary *)foodDictionaryFromJson:(NSData *)data shortformArray:(NSArray *)shortformArray error:(NSError **)error {
    DateStringConverter *dateStringConverter = [[DateStringConverter alloc] init];
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableDictionary *foodDataDictionary = [[NSMutableDictionary alloc] init];
    NSDictionary *foodsDictionary = [parsedObject valueForKey:@"data"];
    
    for (NSDictionary *foodDictionary in foodsDictionary) {
        FoodData *foodData = [[FoodData alloc] init];
        
        //don't include this location if it's not on our map
        NSString *building = [foodDictionary valueForKey:@"building"];
        if (![shortformArray containsObject:building]) {
            continue;
        }
        [foodData setBuilding:building];
        
        NSString *adjustedString =  [[foodDictionary valueForKey:@"outlet_name"] stringByReplacingOccurrencesOfString:@"U" withString:@"u"];//TODO:must change this later..
        
        [foodData setTitle:adjustedString];
        
        if ([[foodDictionary valueForKey:@"logo"] isKindOfClass:[NSNull class]]) {
            [foodData setImageUrl:nil];
        } else {
            [foodData setImageUrl:[foodDictionary valueForKey:@"logo"]];
        }
        
        if ([[foodDictionary valueForKey:@"description"] isKindOfClass:[NSNull class]]) {
            [foodData setFoodDescription:nil];
        } else {
            NSString *foodDescription = [foodDictionary valueForKey:@"description"];
            foodDescription = [foodDescription stringByDecodingHTMLEntities];
            [foodData setFoodDescription:foodDescription];
        }
        
        if ([[foodDictionary valueForKey:@"notice"] isKindOfClass:[NSNull class]]) {
            [foodData setNotice:nil];
        } else {
            NSString *foodNotice = [foodDictionary valueForKey:@"notice"];
            foodNotice = [foodNotice stringByDecodingHTMLEntities];
            [foodData setNotice:foodNotice];
        }
        
        if ([[foodDictionary valueForKey:@"is_open_now"] isKindOfClass:[NSNull class]]) {
            [foodData setIsOpenNow:nil];
        } else {
            [foodData setIsOpenNow:[foodDictionary valueForKey:@"is_open_now"]];
        }
        
        NSDictionary *hoursDictionary = [foodDictionary valueForKey:@"opening_hours"];
        
        NSDictionary *mondayHours = [hoursDictionary valueForKey:@"monday"];
        
        if ([[mondayHours valueForKey:@"opening_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setMondayOpen:nil];
        } else {
            NSString *convertedDateString = [dateStringConverter convertedDateFromString:[mondayHours valueForKey:@"opening_hour"]];
            [foodData setMondayOpen:convertedDateString];
        }
        
        if ([[mondayHours valueForKey:@"closing_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setMondayClose:nil];
        } else {
            NSString *convertedDateString = [dateStringConverter convertedDateFromString:[mondayHours valueForKey:@"closing_hour"]];
            [foodData setMondayClose:convertedDateString];
        }
        
        NSDictionary *tuesdayHours = [hoursDictionary valueForKey:@"tuesday"];
        
        if ([[tuesdayHours valueForKey:@"opening_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setTuesdayOpen:nil];
        } else {
            NSString *convertedDateString = [dateStringConverter convertedDateFromString:[tuesdayHours valueForKey:@"opening_hour"]];
            [foodData setTuesdayOpen:convertedDateString];
        }
        
        if ([[tuesdayHours valueForKey:@"closing_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setTuesdayClose:nil];
        } else {
            NSString *convertedDateString = [dateStringConverter convertedDateFromString:[tuesdayHours valueForKey:@"closing_hour"]];
            [foodData setTuesdayClose:convertedDateString];
        }
        
        NSDictionary *wednesdayHours = [hoursDictionary valueForKey:@"wednesday"];
        
        if ([[wednesdayHours valueForKey:@"opening_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setWednesdayOpen:nil];
        } else {
            NSString *convertedDateString = [dateStringConverter convertedDateFromString:[wednesdayHours valueForKey:@"opening_hour"]];
            [foodData setWednesdayOpen:convertedDateString];
        }
        
        if ([[wednesdayHours valueForKey:@"closing_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setWednesdayClose:nil];
        } else {
            NSString *convertedDateString = [dateStringConverter convertedDateFromString:[wednesdayHours valueForKey:@"closing_hour"]];
            [foodData setWednesdayClose:convertedDateString];
        }
        
        NSDictionary *thursdayHours = [hoursDictionary valueForKey:@"thursday"];
        
        if ([[thursdayHours valueForKey:@"opening_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setThursdayOpen:nil];
        } else {
            NSString *convertedDateString = [dateStringConverter convertedDateFromString:[thursdayHours valueForKey:@"opening_hour"]];
            [foodData setThursdayOpen:convertedDateString];
        }
        
        if ([[thursdayHours valueForKey:@"closing_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setThursdayClose:nil];
        } else {
            NSString *convertedDateString = [dateStringConverter convertedDateFromString:[thursdayHours valueForKey:@"closing_hour"]];
            [foodData setThursdayClose:convertedDateString];
        }
        
        NSDictionary *fridayHours = [hoursDictionary valueForKey:@"friday"];
        
        if ([[fridayHours valueForKey:@"opening_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setFridayOpen:nil];
        } else {
            NSString *convertedDateString = [dateStringConverter convertedDateFromString:[fridayHours valueForKey:@"opening_hour"]];
            [foodData setFridayOpen:convertedDateString];
        }
        
        if ([[fridayHours valueForKey:@"closing_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setFridayClose:nil];
        } else {
            NSString *convertedDateString = [dateStringConverter convertedDateFromString:[fridayHours valueForKey:@"closing_hour"]];
            [foodData setFridayClose:convertedDateString];
        }
        
        NSDictionary *saturdayHours = [hoursDictionary valueForKey:@"saturday"];
        
        if ([[saturdayHours valueForKey:@"opening_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setSaturdayOpen:nil];
        } else {
            NSString *convertedDateString = [dateStringConverter convertedDateFromString:[saturdayHours valueForKey:@"opening_hour"]];
            [foodData setSaturdayOpen:convertedDateString];
        }
        
        if ([[saturdayHours valueForKey:@"closing_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setSaturdayClose:nil];
        } else {
            NSString *convertedDateString = [dateStringConverter convertedDateFromString:[saturdayHours valueForKey:@"closing_hour"]];
            [foodData setSaturdayClose:convertedDateString];
        }
        
        NSDictionary *sundayHours = [hoursDictionary valueForKey:@"sunday"];
        
        if ([[sundayHours valueForKey:@"opening_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setSundayOpen:nil];
        } else {
            NSString *convertedDateString = [dateStringConverter convertedDateFromString:[sundayHours valueForKey:@"opening_hour"]];
            [foodData setSundayOpen:convertedDateString];
        }
        
        if ([[sundayHours valueForKey:@"closing_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setSundayClose:nil];
        } else {
            NSString *convertedDateString = [dateStringConverter convertedDateFromString:[sundayHours valueForKey:@"closing_hour"]];
            [foodData setSundayClose:convertedDateString];
        }
        
        [foodDataDictionary setValue:foodData forKey:foodData.title];
    }
    return foodDataDictionary;
}

@end
