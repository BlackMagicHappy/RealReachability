//
//  ViewController.m
//  RealReachability
//
//  Created by Dustturtle on 16/1/9.
//  Copyright © 2016 QCStudio. All rights reserved.
//

#import "ViewController.h"
#import "RealReachability.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flagLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [GLobalRealReachability startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testAction:(id)sender
{
    [GLobalRealReachability reachabilityWithBlock:^(ReachabilityStatus status) {
        switch (status)
        {
            case NotReachable:
            {
                [[[UIAlertView alloc] initWithTitle:@"RealReachability" message:@"Nothing to do! offlineMode" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil] show];
                break;
            }
                
            case ReachableViaWiFi:
            {
                [[[UIAlertView alloc] initWithTitle:@"RealReachability" message:@"Do what you want! free!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil] show];
                break;
            }
                
            case ReachableViaWWAN:
            {
                [[[UIAlertView alloc] initWithTitle:@"RealReachability" message:@"Take care of your money! You are in charge!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil] show];
                break;
            }
                
            default:
                break;
        }
    }];
    
}

- (void)networkChanged:(NSNotification *)notification
{
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    NSLog(@"currentStatus:%@",@(status));
    
    if (status == NotReachable)
    {
        self.flagLabel.text = @"Network unreachable!";
    }
    
    if (status == ReachableViaWiFi)
    {
        self.flagLabel.text = @"Network wifi! Free!";
    }
    
    if (status == ReachableViaWWAN)
    {
        self.flagLabel.text = @"Network WWAN! In charge!";
    }
}
@end
