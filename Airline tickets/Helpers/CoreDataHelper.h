//
//  CoreDataHelper.h
//  Airline tickets
//
//  Created by NadiaMorozova on 24.05.2019.
//  Copyright © 2019 NadiaMorozova. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "DataManager.h"

//#import "Ticket.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataHelper : NSObject

+ (instancetype)sharedInstance;

- (BOOL)isFavorite:(Ticket *)ticket;
- (NSArray *)favorites;
- (void)addFavorite:(Ticket *)ticket;
- (void)removeFromFavorite:(Ticket *)ticket;

@end

NS_ASSUME_NONNULL_END
