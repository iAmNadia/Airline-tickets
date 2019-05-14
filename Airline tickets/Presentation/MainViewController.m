//
//  ViewController.m
//  Airline tickets
//
//  Created by NadiaMorozova on 06.05.2019.
//  Copyright © 2019 NadiaMorozova. All rights reserved.
//

#import "MainViewController.h"
#import "DataManager.h"
#import "PlaceViewController.h"

typedef struct SearchRequest {

    __unsafe_unretained NSString *origin;
   __unsafe_unretained NSString *destionation;
    __unsafe_unretained NSString *departDate;
    __unsafe_unretained NSString *returnDate;

} SearchRequest;

@interface MainViewController () <PlaceViewControllerDelegate>
@property(nonatomic, strong) UIButton *departureButton;
@property(nonatomic, strong) UIButton *arrivalButton;
@property(nonatomic, assign) SearchRequest searchRequest;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[DataManager sharedInstance] loadData];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.title = @"Поиск";
    
    _departureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_departureButton setTitle:@"Откуда" forState: UIControlStateNormal];
    _departureButton.tintColor = [UIColor blackColor];
    _departureButton.frame = CGRectMake(30.0, 140.0, [UIScreen mainScreen].bounds.size.width - 60.0, 60.0);

    _departureButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [_departureButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_departureButton];
    
    _arrivalButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_arrivalButton setTitle:@"Куда" forState: UIControlStateNormal];
    _arrivalButton.tintColor = [UIColor blackColor];
    _arrivalButton.frame = CGRectMake(30.0, CGRectGetMaxY(_departureButton.frame) + 20.0, [UIScreen mainScreen].bounds.size.width - 60.0, 60.0);
    _arrivalButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [_arrivalButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_arrivalButton];
}

- (void)placeButtonDidTap:(UIButton *)sender {
    PlaceViewController *placeViewController;
    if ([sender isEqual:_departureButton]) {
        placeViewController = [[PlaceViewController alloc] initWithType: PlaceTypeDeparture];
    } else {
        placeViewController = [[PlaceViewController alloc] initWithType: PlaceTypeArrival];
    }
    placeViewController.delegate = self;
    [self.navigationController pushViewController: placeViewController animated:YES];
}
#pragma mark - PlaceViewControllerDelegate

- (void)selectPlace:(id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType {
    [self setPlace:place withDataType:dataType andPlaceType:placeType forButton: (placeType == PlaceTypeDeparture) ? _departureButton : _arrivalButton ];
}

- (void)setPlace:(id)place withDataType:(DataSourceType)dataType andPlaceType:(PlaceType)placeType forButton:(UIButton *)button {
    NSString *title;
    NSString *data;
    if (dataType == DataSourceTypeCity) {
        City *city = (City *)place;
        title = city.name;
        data = city.code;
    }
    else if (dataType == DataSourceTypeAirport) {
        Airport *airport = (Airport *)place;
        title = airport.name;
        data = airport.cityCode;
    }
    if (placeType == PlaceTypeDeparture) {
       _searchRequest.origin = data;
       [_departureButton setTitle:title forState:UIControlStateNormal];
    } else {
        _searchRequest.destionation = data;
        [_arrivalButton setTitle:title forState:UIControlStateNormal];
    }
    [button setTitle: title forState: UIControlStateNormal];
}

-(void)dataDidLoad : (NSNotification *)notification
{
    [_arrivalButton setEnabled:YES];
    [_departureButton setEnabled:YES];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataComplete) name:kDataManagerLoadDataDidComplete object:nil];



@end
