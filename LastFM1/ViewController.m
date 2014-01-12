//
//  ViewController.m
//  LastFM1
//
//  Created by Russell Barnes on 1/7/14.
//  Contains code from gangverk example
//

#import "ViewController.h"
// Import the Last.Fm SDK
#import <LastFm/LastFm.h>
// Import the map view
#import "MapViewController.h"

@interface ViewController ()

// Username text field
@property (weak, nonatomic) IBOutlet UITextField *username;
// Password text field
@property (weak, nonatomic) IBOutlet UITextField *password;
// Label that displays the result of the request
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (weak, nonatomic) IBOutlet UIButton *userButton;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *sendRequestButton;

// Button that switches to map
@property (weak, nonatomic) IBOutlet UIButton *mapButton;

// Array for objects containing values for lat & long of event.
// Must be strong to pass to MapViewController
@property (strong, nonatomic) NSArray *eventArray;
@property (strong, nonatomic) NSMutableArray *eventMutableArray;   // Local use only

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Initialize data
    self.eventMutableArray = [[NSMutableArray alloc] init];
}

- (IBAction)userAccountButtonPressed:(id)sender {
    // Show the user fields
    self.userButton.hidden = YES;
    self.usernameLabel.hidden = NO;
    self.passwordLabel.hidden = NO;
    self.username.hidden = NO;
    self.password.hidden = NO;
    self.loginButton.hidden = NO;
    // Hide the request button until the user has finished entering their creds
    self.sendRequestButton.hidden = YES;
}

- (IBAction)logInPressed:(id)sender {
    // Hide the keyboard
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    
    // Show the result text box
    self.resultLabel.hidden = NO;
    
    [[LastFm sharedInstance] getSessionForUser:self.username.text password:self.password.text successHandler:^(NSDictionary *result) {
        
        // Save the session into NSUserDefaults. It is loaded on app start up in AppDelegate.
        [[NSUserDefaults standardUserDefaults] setObject:result[@"key"] forKey:SESSION_KEY];
        [[NSUserDefaults standardUserDefaults] setObject:result[@"name"] forKey:USERNAME_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // Set it manually for the current app session
        [LastFm sharedInstance].session = result[@"key"];
        [LastFm sharedInstance].username = result[@"name"];
        // FIXME iostestaccount
        
        self.resultLabel.text = @"User Session Created Successfully";
        
        // Hide the user fields
        self.userButton.hidden = YES;
        self.usernameLabel.hidden = YES;
        self.passwordLabel.hidden = YES;
        self.username.hidden = YES;
        self.password.hidden = YES;
        self.loginButton.hidden = YES;
        // Show the request button
        self.sendRequestButton.hidden = NO;
        
    } failureHandler:^(NSError *error) {
        NSLog(@"Failure: %@", [error localizedDescription]);
        self.resultLabel.text = @"An error has occurred while obtaining session key";
    }];

}

- (IBAction)requestPressed:(id)sender {
    // Hide the keyboard
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    
    // Hide the user fields
    self.userButton.hidden = YES;
    self.usernameLabel.hidden = YES;
    self.passwordLabel.hidden = YES;
    self.username.hidden = YES;
    self.password.hidden = YES;
    self.loginButton.hidden = YES;
    // Hide the request button
    self.sendRequestButton.hidden = YES;
    // Show the result text box
    self.resultLabel.hidden = NO;
    
    
    // Get artist info
    /*[[LastFm sharedInstance] getInfoForArtist:@"Pink Floyd" successHandler:^(NSDictionary *result) {
        self.resultLabel.font = [self.resultLabel.font fontWithSize:20];
        self.resultLabel.text = [result description];
    } failureHandler:^(NSError *error) {
        NSLog(@"error: %@", error);
        self.resultLabel.text = @"An error has occurred while retrieving artist info";
    }];*/
    
    
    // Get event info
    [[LastFm sharedInstance] getEventsForLocation:@"Portland" successHandler:^(NSArray *result) {
        //NSLog(@"result: %@", result);
        
        // Create array of EventClass objects for the events
        EventClass *tempEvent;
        for (int i = 0; i < [result count]; i++) {
            
            tempEvent = [[EventClass alloc] init];
            
            tempEvent.latitude = [[result objectAtIndex:i] objectForKey:@"latitude"];
            tempEvent.longitude = [[result objectAtIndex:i] objectForKey:@"longitude"];
            tempEvent.title = [[result objectAtIndex:i] objectForKey:@"title"];
            tempEvent.venue = [[result objectAtIndex:i] objectForKey:@"venue"];
            
            [self.eventMutableArray addObject:tempEvent];
        }
        
        self.eventArray = [NSArray arrayWithArray:self.eventMutableArray];
        
        // Display raw result in app
        self.resultLabel.font = [self.resultLabel.font fontWithSize:20];
        self.resultLabel.text = [result description];
        
        // Give user the option of viewing the coordinates on a map
        self.mapButton.hidden = NO;
        
    } failureHandler:^(NSError *error) {
        
        NSLog(@"error: %@", error);
        self.resultLabel.text = @"An error has occurred while retrieving event info";
        
    }]; // getEventsForLocation
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"switchToMap"]) {
        
        // Refer to instance of MapViewController
        MapViewController *newView = segue.destinationViewController;
        
        // Pass the map view the array of events
        newView.eventArray = self.eventArray;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
