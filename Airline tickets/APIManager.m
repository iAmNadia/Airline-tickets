//
//  APIManager.m
//  Airline tickets
//
//  Created by NadiaMorozova on 13.05.2019.
//  Copyright © 2019 NadiaMorozova. All rights reserved.
//

#import "APIManager.h"

#define API_TOKEN @"<<af9512dd115b1081290b9ca7f0d418a2>>"
#define API_URL_IP_ADDRESS @"https://api.ipify.org/?format=json"
#define API_URL_CHEAP @"https://api.travelpayouts.com/v1/prices/cheap"
#define API_URL_CITY_FROM_IP @"https://www.travelpayouts.com/whereami?ip="



@implementation APIManager

+ (instancetype)sharedInstance {
    static APIManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[APIManager alloc] init];
    });
    return instance;
}

- (void)cityForCurrentApi:(void (^)(City *))completion {
  
}

@end
