//
//  Country.h
//  Airline tickets
//
//  Created by NadiaMorozova on 06.05.2019.
//  Copyright © 2019 NadiaMorozova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSDictionary *translations;
@property (nonatomic, strong) NSString *code;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end
