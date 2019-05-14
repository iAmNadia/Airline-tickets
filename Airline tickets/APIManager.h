//
//  APIManager.h
//  Airline tickets
//
//  Created by NadiaMorozova on 13.05.2019.
//  Copyright © 2019 NadiaMorozova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"


@interface APIManager : NSObject


+ (instancetype)sharedInstance;
- (void)cityForCurrentApi:(void (^)(City *city))completion;

@end

