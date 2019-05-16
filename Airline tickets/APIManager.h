//
//  APIManager.h
//  Airline tickets
//
//  Created by NadiaMorozova on 13.05.2019.
//  Copyright © 2019 NadiaMorozova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"

#define AirlineLogo(iata) [NSURL URLWithString:[NSString stringWithFormat:@"https://pics.avs.io/200/200/%@.png", iata]];

typedef struct SearchRequest {
    __unsafe_unretained NSString *origin;
    __unsafe_unretained NSString *destionation;
    __unsafe_unretained NSDate *departDate;
    __unsafe_unretained NSDate *returnDate;
} SearchRequest;


@interface APIManager : NSObject


+ (instancetype)sharedInstance;
- (void)ticketsWithRequest:(SearchRequest)request withCompletion:(void (^)(NSArray *tickets))completion;

- (void)cityForCurrentApi:(void (^)(City *city))completion;

@end

