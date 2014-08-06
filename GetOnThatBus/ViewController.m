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

@interface ViewController ()<JSONManagerDelegate, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property JSONManager *jsonManager;
@property CLLocationCoordinate2D chicagoCoordinates;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSArray *stopsArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.hidden = YES;
    
    self.jsonManager = [[JSONManager alloc] init];
    self.jsonManager.delegate = self;
    [self.jsonManager makeRequestWithCriteria:nil];
    
    self.chicagoCoordinates = CLLocationCoordinate2DMake(41.88322, -87.63243);

    MKCoordinateRegion region;
    region.center.latitude = self.chicagoCoordinates.latitude;
    region.center.longitude = self.chicagoCoordinates.longitude;
    region.span.latitudeDelta =  1;
    region.span.longitudeDelta =  1;
    
    [self.mapView setRegion:region animated:YES];
}

- (void) responseWithJSON:(NSDictionary *) json
{
    self.stopsArray = [json objectForKey:@"row"];
    
    for (NSDictionary *dict in self.stopsArray) {
        
        CLLocationCoordinate2D location;
        
        location.latitude = [[dict objectForKey:@"latitude"] floatValue];
        location.longitude = [[dict objectForKey:@"longitude"] floatValue];
        
        MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc]init];
        
        if (![[dict objectForKey:@"_id"] isEqualToString:@"153"]) {
			location.latitude = [[dict objectForKey:@"latitude"] floatValue];
            location.longitude = [[dict objectForKey:@"longitude"] floatValue];
		} else {
			location.latitude = [[dict objectForKey:@"latitude"] floatValue];
            location.longitude = [[dict objectForKey:@"longitude"] floatValue]*-1;
		}
        
        pointAnnotation.title = [dict objectForKey: @"cta_stop_name"];
        pointAnnotation.subtitle = [NSString stringWithFormat:@"Routes: %@", [dict objectForKey: @"routes"]];
        pointAnnotation.coordinate = location;
        pointAnnotation.jsonAttribute = dict;
        [pointAnnotation pinBasedOnTransfer:dict];

        [self.mapView addAnnotation:pointAnnotation];


    }
    
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        MKPointAnnotation *annotation = [[self.mapView annotations] objectAtIndex:[self.tableView indexPathForCell:sender].row];
        [segue.destinationViewController setAnnotation:annotation];
        [segue.destinationViewController setTitle:annotation.title];
        
    } else {
        MKAnnotationView *annotationView = sender;
        [segue.destinationViewController setAnnotation:annotationView.annotation];
        [segue.destinationViewController setTitle:annotationView.annotation.title];
    }
    
}

- (IBAction)onTabPressed:(UISegmentedControl*)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        self.tableView.hidden = YES;
        self.mapView.hidden = NO;
    } else {
        self.tableView.hidden = NO;
        self.mapView.hidden = YES;
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stopsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    cell.textLabel.text = ((MKPointAnnotation *)[[self.mapView annotations] objectAtIndex:indexPath.row]).title;
    cell.detailTextLabel.text = ((MKPointAnnotation *)[[self.mapView annotations] objectAtIndex:indexPath.row]).subtitle;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"detailSegue" sender: [self.tableView cellForRowAtIndexPath:indexPath] ];

}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if (annotation != self.mapView.userLocation){
        
        MKPinAnnotationView *pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
        pin.canShowCallout = YES;
        pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        if (((MKPointAnnotation*)annotation).image) {
            pin.image = ((MKPointAnnotation*)annotation).image;
        }
        
        
        return pin;
    } else {
        return  nil;
    }
}

- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"detailSegue" sender: view];
    
}



@end
