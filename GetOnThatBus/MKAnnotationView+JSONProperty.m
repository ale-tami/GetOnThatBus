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
static void * UIImagePropertyKey = &UIImagePropertyKey;

@implementation MKPointAnnotation (JSONProperty)


- (NSDictionary *)jsonAttribute {
    return objc_getAssociatedObject(self, JSONPropertyKey);
}

- (void)setJsonAttribute:(NSDictionary *)jsonAttribute {
    objc_setAssociatedObject(self, JSONPropertyKey, jsonAttribute, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)image {
    return objc_getAssociatedObject(self, UIImagePropertyKey);
}

- (void)setImage:(UIImage *)img {
    objc_setAssociatedObject(self, UIImagePropertyKey, img, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void) pinBasedOnTransfer:(NSDictionary*)transfer
{

    if ([[transfer objectForKey:@"inter_modal"] isEqualToString:@"Pace"]) {
        self.image = [UIImage imageNamed:@"pace"];
    } else if ([[transfer objectForKey:@"inter_modal"] isEqualToString:@"Metra"]) {
        self.image = [UIImage imageNamed:@"metra"];
    }

}

@end
