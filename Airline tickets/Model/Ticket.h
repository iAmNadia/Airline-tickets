//
//  Ticket.h
//  Airline tickets
//
//  Created by NadiaMorozova on 15.05.2019.
//  Copyright © 2019 NadiaMorozova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject

@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *airline;
@property (nonatomic, strong) NSDate *departure;
@property (nonatomic, strong) NSDate *expires;
@property (nonatomic, strong) NSNumber *flightNumber;
@property (nonatomic, strong) NSDate *returnDate;
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *to;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


