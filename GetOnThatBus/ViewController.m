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
@property CLLocationCoordinate2D chicagoCoordinates;

@property NSArray *stopsArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.jsonManager = [[JSONManager alloc] init];
    self.jsonManager.delegate = self;
    [self.jsonManager makeRequestWithCriteria:nil];
    
    
    NSString *address = @"Chicago";
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark * place = [placemarks objectAtIndex:0];
        self.chicagoCoordinates = place.location.coordinate;
        
    }];
}

- (void) responseWithJSON:(NSDictionary *) json
{
    self.stopsArray = [json objectForKey:@"row"];
    
    CLLocation *chicagoLocation = [[CLLocation alloc] initWithLatitude:self.chicagoCoordinates.latitude longitude:self.chicagoCoordinates.longitude];
    
    for (NSDictionary *dict in self.stopsArray) {
        
        CLLocationCoordinate2D location;
        
        location.latitude = [[dict objectForKey:@"latitude"] floatValue];
        location.longitude = [[dict objectForKey:@"longitude"] floatValue];
        
        CLLocation *jsonLocation = [[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
        
        if ( [chicagoLocation distanceFromLocation:jsonLocation] < 606000 ) //606km^2
        {
                
      
            MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc]init];
      

            pointAnnotation.coordinate = location;
            pointAnnotation.title = [dict objectForKey: @"cta_stop_name"];
            
            [self.mapView addAnnotation:pointAnnotation];
    
        }
    }
    
    
    
    
}

@end
