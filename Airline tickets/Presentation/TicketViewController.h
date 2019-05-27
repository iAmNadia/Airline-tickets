//
//  TicketViewController.h
//  Airline tickets
//
//  Created by NadiaMorozova on 15.05.2019.
//  Copyright © 2019 NadiaMorozova. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TicketViewController : UITableViewController
- (instancetype)initWithTickets:(NSArray *)tickets;
- (instancetype)initFavoriteTicketsController;

@end

NS_ASSUME_NONNULL_END
