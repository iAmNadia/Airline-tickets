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

@interface TicketTableViewCell : UITableViewCell

@property (nonatomic, strong) Ticket *ticket;

@end


