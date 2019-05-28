//
//  NotificationCenter.h
//  Airline tickets
//
//  Created by NadiaMorozova on 28.05.2019.
//  Copyright © 2019 NadiaMorozova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef struct Notification {
    __unsafe_unretained NSString *_Nullable title;
    __unsafe_unretained NSString *_Nonnull body;
    __unsafe_unretained NSDate *_Nonnull date;
    __unsafe_unretained NSURL *_Nullable imageURL;
} Notification;

@interface NotificationCenter : NSObject

+(instancetype)sharedInstance;
-(void)registerService;
-(void)sendNotification:(Notification)notification;

Notification NotificationMake(NSString *_Nullable title, NSString *_Nonnull body, NSDate *_Nonnull date, NSURL *_Nullable imageURL);

@end
