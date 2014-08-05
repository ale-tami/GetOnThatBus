//
//  ViewController.m
//  GetOnThatBus
//
//  Created by Alejandro Tami on 05/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "ViewController.h"
#import "JSONManager.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<JSONManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property JSONManager *jsonManager;

@property NSArray *stopsArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.jsonManager = [[JSONManager alloc] init];
    self.jsonManager.delegate = self;
    [self.jsonManager makeRequestWithCriteria:nil];
    
    
}

- (void) responseWithJSON:(NSDictionary *) json
{
    self.stopsArray = [json objectForKey:@"row"];
    
    for (NSDictionary *dict in self.stopsArray) {
        
        MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc]init];
        CLLocationCoordinate2D location;
        
        location.latitude = [[dict objectForKey:@"latitude"] floatValue];
        location.longitude = [[dict objectForKey:@"longitude"] floatValue];

        pointAnnotation.coordinate = location;
        pointAnnotation.title = [dict objectForKey: @"cta_stop_name"];
        
        [self.mapView addAnnotation:pointAnnotation];
        
    }
    
    
    
    
}

@end
