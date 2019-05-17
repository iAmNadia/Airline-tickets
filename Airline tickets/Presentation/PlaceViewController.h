//
//  PlaceViewController.h
//  Airline tickets
//
//  Created by NadiaMorozova on 07.05.2019.
//  Copyright © 2019 NadiaMorozova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

typedef enum PlaceType {
    PlaceTypeArrival,
    PlaceTypeDeparture
} PlaceType;

@protocol PlaceViewControllerDelegate <NSObject>
- (void)selectPlace:(id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType;
@end

@interface PlaceViewController : UIViewController <PlaceViewControllerDelegate, UITableViewDataSource>

@property (nonatomic, weak) id<PlaceViewControllerDelegate>delegate;
- (instancetype)initWithType:(PlaceType)type;


@end

