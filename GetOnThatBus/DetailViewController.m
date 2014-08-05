//
//  DetailViewController.m
//  GetOnThatBus
//
//  Created by Alejandro Tami on 05/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *stopAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *busRoutesLabel;
@property (weak, nonatomic) IBOutlet UILabel *intermodalLabel;

@end

@implementation DetailViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *dict = self.annotation.jsonAttribute;
    
    self.stopAddressLabel.text = [dict objectForKey:@"_address"];
    self.busRoutesLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"routes"] ];
    self.intermodalLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"inter_modal"] ];
    
}

@end
