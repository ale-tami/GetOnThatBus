//
//  MKAnnotationView+JSONProperty.h
//  GetOnThatBus
//
//  Created by Alejandro Tami on 05/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKPointAnnotation (JSONProperty)

@property NSDictionary *jsonAttribute;

@end
