//
//  JSONManager.m
//  MeetUpClient
//
//  Created by Alejandro Tami on 04/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "JSONManager.h"

@implementation JSONManager

- (void)makeRequestWithCriteria:(NSString *)criteria
{
    // to be refactored, make it generic
    __block NSDictionary * responseJSON = [[NSDictionary alloc] init];
    
    
    NSString *stringURL = [NSString stringWithFormat:@"https://s3.amazonaws.com/mobile-makers-lib/bus.json"];
    
    NSURL *url = [NSURL URLWithString:stringURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        responseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        [self.delegate responseWithJSON:responseJSON];

    }];
    
}


- (void) responseWithJSON:(NSDictionary *) json
{
    
}

@end
