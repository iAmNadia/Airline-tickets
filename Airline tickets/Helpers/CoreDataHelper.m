//
//  CoreDataHelper.m
//  Airline tickets
//
//  Created by NadiaMorozova on 24.05.2019.
//  Copyright © 2019 NadiaMorozova. All rights reserved.
//

#import "CoreDataHelper.h"

@interface CoreDataHelper ()

@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;

@property (nonatomic, strong) NSPersistentContainer *persistentContainer;
@end

@implementation CoreDataHelper

+ (instancetype)sharedInstance {
    static CoreDataHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataHelper alloc]init];
        [instance setup];
    });
    return instance;
}







- (NSManagedObjectContext *)context {
    return _persistentContainer.viewContext;

}

- (void)setup {
    self.persistentContainer = [[NSPersistentContainer alloc]initWithName:@"AirCoreData"];
    [self.persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * description, NSError * error) {
        if (error != nil) {
            NSLog(@"Failed to load Core Data stack: %@", error);
            abort();
        }
    }];
}


- (FavoriteTicket *)favoriteFromTicket:(Ticket *)ticket {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
    request.predicate = [NSPredicate predicateWithFormat:@"price == %ld AND airline == %@ AND from == %@ AND to == %@ AND departure == %@ AND expires == %@ AND flightNumber == %ld", (long)ticket.price.integerValue, ticket.airline, ticket.from, ticket.to, ticket.departure, ticket.expires, (long)ticket.flightNumber.integerValue];
    return [[self.context executeFetchRequest:request error:nil] firstObject];
}

- (void)save {
    NSError *error;
    if ([self.context hasChanges] && ![self.context save:&error]) {
        NSLog(@"Failed to save Core Data context");
        abort();
    }
}

- (BOOL)isFavorite:(Ticket *)ticket {
    return [self favoriteFromTicket:ticket] != nil;
}

- (void)addFavorite:(Ticket *)ticket {
    FavoriteTicket *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"FavoriteTicket" inManagedObjectContext:self.context];
    favorite.price = ticket.price.intValue;
    favorite.airline = ticket.airline;
    favorite.from = ticket.from;
    favorite.to = favorite.to;
    favorite.departure = favorite.departure;
    favorite.expires = favorite.expires;
    favorite.flightNumber = ticket.flightNumber.intValue;
    favorite.created = [NSDate date];
    [self save];
}

- (void)removeFromFavorite:(Ticket *)ticket {
    FavoriteTicket *favorite = [self favoriteFromTicket:ticket];
    if (favorite) {
        [self.context deleteObject:favorite];
        [self save];
    }
}

- (NSArray *)favorites {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:NO]];
    return [self.context executeFetchRequest:request error:nil];







//- (NSManagedObjectContext *)context {
//    return _persistentContainer.viewContext;
//
//}

//- (void)setup {
//    self.persistentContainer = [[NSPersistentContainer alloc]initWithName:@"AirCoreData"];
//    [self.persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * description, NSError * error) {
//        if (error != nil) {
//            NSLog(@"Failed to load Core Data stack: %@", error);
//            abort();
//        }
//    }];
//}

//- (void)setup {
//    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"air" withExtension:@"momd"];
//    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
//
//    NSURL *docsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
//    NSURL *storeURL = [docsURL URLByAppendingPathComponent:@"base.sqlite"];
//    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
//
//    NSPersistentStore* store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
//    if (!store) {
//        abort();
//    }
//
//    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
//    _managedObjectContext.persistentStoreCoordinator = _persistentStoreCoordinator;
//
//}
//
//- (void)save {
//    NSError *error;
//    [_managedObjectContext save: &error];
//    if (error) {
//        NSLog(@"%@", [error localizedDescription]);
//    }
//}
//
//- (FavoriteTicket *)favoriteFromTicket:(Ticket *)ticket {
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
//    request.predicate = [NSPredicate predicateWithFormat:@"price == %ld AND airline == %@ AND from == %@ AND to == %@ AND departure == %@ AND expires == %@ AND flightNumber == %ld", (long)ticket.price.integerValue, ticket.airline, ticket.from, ticket.to, ticket.departure, ticket.expires, (long)ticket.flightNumber.integerValue];
//    return [[_managedObjectContext executeFetchRequest:request error:nil] firstObject];
//}
//
////- (void)save {
////    NSError *error;
////    if ([self.context hasChanges] && ![self.context save:&error]) {
////        NSLog(@"Failed to save Core Data context");
////        abort();
////    }
////}
//
//- (BOOL)isFavorite:(Ticket *)ticket {
//    return [self favoriteFromTicket:ticket] != nil;
//}
//
//- (void)addFavorite:(Ticket *)ticket {
//    FavoriteTicket *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"FavoriteTicket" inManagedObjectContext:_managedObjectContext];
//    favorite.price = ticket.price.intValue;
//    favorite.airline = ticket.airline;
//    favorite.from = ticket.from;
//    favorite.to = favorite.to;
//    favorite.departure = favorite.departure;
//    favorite.expires = favorite.expires;
//    favorite.flightNumber = ticket.flightNumber.intValue;
//    favorite.created = [NSDate date];
//    [self save];
//}
//
//- (void)removeFromFavorite:(Ticket *)ticket {
//    FavoriteTicket *favorite = [self favoriteFromTicket:ticket];
//    if (favorite) {
//        [_managedObjectContext deleteObject:favorite];
//        [self save];
//    }
//}
//
//- (NSArray *)favorites {
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
//    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:NO]];
//    return [_managedObjectContext executeFetchRequest:request error:nil];
}

@end
