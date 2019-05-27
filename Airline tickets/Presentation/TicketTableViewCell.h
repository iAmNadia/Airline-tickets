//
//  TicketTableViewCell.h
//  Airline tickets
//
//  Created by NadiaMorozova on 15.05.2019.
//  Copyright © 2019 NadiaMorozova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"Ticket.h"
#import "DataManager.h"
#import "APIManager.h"
#import "FavoriteTicket+CoreDataProperties.h"

@interface TicketTableViewCell : UITableViewCell

@property (nonatomic, strong) Ticket *ticket;
@property (nonatomic, strong) FavoriteTicket *favoriteTicket;
//- (void)setFavoriteTicket:(FavoriteTicket *)favoriteTicket;
@end


