//
//  CoreDataHelper.m
//  Airline tickets
//
//  Created by NadiaMorozova on 24.05.2019.
//  Copyright © 2019 NadiaMorozova. All rights reserved.
//

#import "CoreDataHelper.h"
#import "FavoriteTicket+CoreDataClass.h"

@interface CoreDataHelper ()

@property (nonatomic, strong) NSPersistentContainer *persContainer;

@end

@implementation CoreDataHelper

+ (instancetype)sharedInstance
{
    static CoreDataHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataHelper alloc] init];
        [instance setup];
    });
    return instance;
}

- (void)setup {
    self.persContainer = [[NSPersistentContainer alloc]initWithName:@"AirCoreData"];
    [self.persContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * description, NSError * error) {
        if (error != nil) {
            NSLog(@"Failed Core Data stack: %@", error);
            abort();
        }
    }];
}

- (void)save {
    NSError *error;
     if ([self.persContainer.viewContext hasChanges] && ![self.persContainer.viewContext save:&error]) {
        NSLog(@"Failed Core Data context");
       abort();
    }
}
- (FavoriteTicket *)favoriteFromTicket:(Ticket *)ticket {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
        request.predicate = [NSPredicate predicateWithFormat:@"price == %ld AND airline == %@ AND from == %@ AND to == %@ AND departure == %@ AND expires == %@ AND flightNumber == %ld", (long)ticket.price.integerValue, ticket.airline, ticket.from, ticket.to, ticket.departure, ticket.expires, (long)ticket.flightNumber.integerValue];
    
    return [[self.persContainer.viewContext executeFetchRequest:request error:nil] firstObject];
    }

- (BOOL)isFavorite:(Ticket *)ticket {
        return [self favoriteFromTicket:ticket] != nil;
    }

- (void)addFavorite:(Ticket *)ticket {
        FavoriteTicket *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"FavoriteTicket" inManagedObjectContext:self.persContainer.viewContext];
        favorite.price = ticket.price.intValue;
        favorite.airline = ticket.airline;
        favorite.departure = ticket.departure;
        favorite.expires = ticket.expires;
        favorite.flightNumber = ticket.flightNumber.intValue;
        favorite.returnDate = ticket.returnDate;
        favorite.from = ticket.from;
        favorite.to = ticket.to;
        favorite.created = [NSDate date];
        [self save];
    }

- (void)removeFromFavorite:(Ticket *)ticket {
        FavoriteTicket *favorite = [self favoriteFromTicket:ticket];
        if (favorite) {
            [self.persContainer.viewContext deleteObject:favorite];
            [self save];
        }
    }

- (void)deleteFromFavorite:(FavoriteTicket *)ticket {
        [self.persContainer.viewContext deleteObject:ticket];
        [self save];
    }

    - (NSArray *)favorites {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:NO]];
        return [self.persContainer.viewContext executeFetchRequest:request error:nil];
    }

@end
