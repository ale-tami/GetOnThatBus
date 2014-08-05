//
//  MKAnnotationView+JSONProperty.m
//  GetOnThatBus
//
//  Created by Alejandro Tami on 05/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "MKAnnotationView+JSONProperty.h"

#import <objc/runtime.h>

static void * JSONPropertyKey = &JSONPropertyKey;

@implementation MKPointAnnotation (JSONProperty)


- (NSDictionary *)jsonAttribute {
    return objc_getAssociatedObject(self, JSONPropertyKey);
}

- (void)setJsonAttribute:(NSDictionary *)jsonAttribute {
    objc_setAssociatedObject(self, JSONPropertyKey, jsonAttribute, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}




@end
