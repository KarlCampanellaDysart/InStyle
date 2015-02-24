//
//  ViewController.m
//  InStyle
//
//  Created by Karl Campanella-Dysart on 11/24/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import "KCDLoginViewController.h"


/*basic clothes/weather distinctions
 
 gender - male, female
 
 snow - snow jacket, boots, earmuffs, longsleeve
 rain - rain jacket, rain boots, pants, longsleeve, hoods
 hot - sandles, sun hat, bathing suits, shorts, tanks
 cold and dry - sweater, sneakers, longsleeve, buttonups
 warm - shorts, teeshirts, boatshoes,
 fall moderate - scarf, pants, flannels, buttonups, sneakers
 
 Partly Cloudy
 Light rain shower
 Patchy rain nearby
 Light Snow, Mist
 Smoke
 Overcast
 Clear
 Sunny
 */

@interface KCDLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *createAccountButton;

@end

NSNumber *freezingTemp;
NSNumber *coldTemp;
NSNumber *moderateTemp;
NSNumber *warmTemp;
NSNumber *hotTemp;

NSNumber *precipWeather;


@implementation KCDLoginViewController

- (IBAction)usernameChange:(id)sender {
    if([self.usernameText.text isEqual:@""]){
        self.loginButton.enabled = false;
        self.createAccountButton.enabled = false;
    }
    else{
        self.loginButton.enabled = true;
        self.createAccountButton.enabled = true;
    }
}

- (IBAction)passChanged:(id)sender {
    if([self.passwordText.text isEqual:@""]){
        self.loginButton.enabled = false;
        self.createAccountButton.enabled = false;
    }
    else{
        self.loginButton.enabled = true;
        self.createAccountButton.enabled = true;
    }
}

- (IBAction)loginPressed:(id)sender {
    //search plist for that account
    
    if([self.userClosets doesUsernameExistInFile:self.usernameText.text]){
        //login exists
        if([self.userClosets checkPassword:self.passwordText.text ForUsername:self.usernameText.text]){
            //segue
            self.userClosets.loggedUser = self.usernameText.text;
            [self.userClosets userLoggedIn];
            [self performSegueWithIdentifier:@"login" sender:self];
        }
        else{
        UIAlertView *incorrectPass = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Incorrect password" delegate:self cancelButtonTitle:@"Exit" otherButtonTitles: nil];
        [incorrectPass show];
        }
    }
    else{
        UIAlertView *cantLogin = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Username doesn't exist" delegate:self cancelButtonTitle:@"Exit" otherButtonTitles: nil];
        [cantLogin show];
    }
}

- (IBAction)createAccountPressed:(id)sender {
    //search plist for that account, check if repeated
    //create account and login
    if([self.userClosets doesUsernameExistInFile:self.usernameText.text]){
        //login exists
        UIAlertView *cantCreateAccount = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Username alread exists" delegate:self cancelButtonTitle:@"Exit" otherButtonTitles: nil];
        [cantCreateAccount show];
    }
    else{
        //create account
        
        UIAlertView *getGender = [[UIAlertView alloc] initWithTitle:@"Gender" message:@"What is your gender" delegate:self cancelButtonTitle:@"Male" otherButtonTitles: @"Female", nil];
        [getGender show];
        
        
        ////[self.userClosets makeNewAccount:self.usernameText.text withPass:self.passwordText.text AndGender:];
        //self.userClosets.loggedUser = self.usernameText.text;
        //[self performSegueWithIdentifier:@"login" sender:self];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle=[alertView buttonTitleAtIndex:buttonIndex];
    if([buttonTitle isEqualToString:@"Male"]) {
        [self.userClosets makeNewAccount:self.usernameText.text withPass:self.passwordText.text AndGender:@"Male"];
        self.userClosets.loggedUser = self.usernameText.text;
        [self.userClosets userLoggedIn];
        [self performSegueWithIdentifier:@"login" sender:self];
    }
    else if([buttonTitle isEqualToString:@"Female"]) {
        [self.userClosets makeNewAccount:self.usernameText.text withPass:self.passwordText.text AndGender:@"Female"];
        self.userClosets.loggedUser = self.usernameText.text;
        [self.userClosets userLoggedIn];
        [self performSegueWithIdentifier:@"login" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"login"]){
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setup temperatures
    freezingTemp= @32;
    coldTemp = @50;
    moderateTemp = @75;
    warmTemp = @85;
    hotTemp = @100;
    
    precipWeather = @0.0;
    
    //setup singleton model
    self.userClosets = [KCDUserClosetModel sharedModel];
    
    //location updates
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    self.locationManager.distanceFilter = 500; // meters
    [self.locationManager startUpdatingLocation];
    
    //setup initial location
    self.location = [[CLLocation alloc] init];
    self.location = _locationManager.location;
    
    //weather from location
    NSString* weatherUrl = [NSString stringWithFormat:@"http://api.worldweatheronline.com/free/v2/weather.ashx?key=adc806be389bed380ac6f465c53e6&q=%.2f,%.2f&num_of_days=2&tp=3&format=json",self.location.coordinate.latitude,self.location.coordinate.longitude];
   
    self.userWeather = [KCDDictionary dictionaryWithContentsOfJSONURLString:weatherUrl];
    NSDictionary* data = [NSDictionary dictionaryWithDictionary:[self.userWeather objectForKey:@"data"]];
    NSArray *array = [data objectForKey:@"current_condition"];
    NSDictionary * currentCondition = [array objectAtIndex:0];
    NSNumber * temp =[currentCondition objectForKey:@"FeelsLikeF"];
    NSNumber * precip = [currentCondition objectForKey:@"precipMM"];
    
    if(temp){
        if([temp doubleValue] < [freezingTemp doubleValue]){
            self.userClosets.typeWeather = @"freezing";
        }
        else if([temp doubleValue] < [coldTemp doubleValue]){
            self.userClosets.typeWeather = @"cold";
        }
        else if([temp doubleValue] < [moderateTemp doubleValue]){
            self.userClosets.typeWeather = @"moderate";
        }
        else if([temp doubleValue] < [warmTemp doubleValue]){
            self.userClosets.typeWeather = @"warm";
        }
        else if([temp doubleValue] < [hotTemp doubleValue]){
            self.userClosets.typeWeather = @"hot";
        }
        else{
            self.userClosets.typeWeather = @"hot";
        }
        NSLog(@"%@",self.userClosets.typeWeather);
    }
    else{
    }
    
    if(precip){
        if([precip doubleValue] > [precipWeather doubleValue]){
            self.userClosets.isPrecip = true;
        }
        else{
            self.userClosets.isPrecip = false;
        }
        NSLog(@"%d",self.userClosets.isPrecip);
    }
    else{
    }
    
    //set up dictionaries with cloth types
    NSArray * keys = [NSArray arrayWithObjects:@"name",@"picture", nil];
    
    NSArray * picName = [NSArray arrayWithObjects:@"snow jackets", @"jacket.png", nil];
    NSDictionary *d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];
    
    picName = [NSArray arrayWithObjects:@"heavy jackets", @"jacket.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];
    
    picName = [NSArray arrayWithObjects:@"boots", @"boots.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];
    
    picName = [NSArray arrayWithObjects:@"earmuffs", @"hat.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];

    picName = [NSArray arrayWithObjects:@"longsleeves", @"longshirt.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];

    picName = [NSArray arrayWithObjects:@"hoodies", @"jacket.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];
    
    picName = [NSArray arrayWithObjects:@"rain jackets", @"jacket.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];

    picName = [NSArray arrayWithObjects:@"button down shirts", @"jacket.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];

    picName = [NSArray arrayWithObjects:@"pants", @"pants.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];
    
    picName = [NSArray arrayWithObjects:@"snow pants", @"pants.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];
    
    picName = [NSArray arrayWithObjects:@"sandles", @"shoe.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];
    
    picName = [NSArray arrayWithObjects:@"sun hats", @"hat.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];
    
    picName = [NSArray arrayWithObjects:@"hats", @"hat.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];

    picName = [NSArray arrayWithObjects:@"bathing suits", @"shorts.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];
    
    picName = [NSArray arrayWithObjects:@"shorts", @"shorts.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];
    
    picName = [NSArray arrayWithObjects:@"tanktops", @"tanktop.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];
    
    picName = [NSArray arrayWithObjects:@"sweaters", @"longshirt.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];
    
    picName = [NSArray arrayWithObjects:@"sneakers", @"shoe.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];
    
    picName = [NSArray arrayWithObjects:@"buttonups", @"longshirt.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];
    
    picName = [NSArray arrayWithObjects:@"tees", @"teeshirt.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];
    
    picName = [NSArray arrayWithObjects:@"boatshoes", @"shoe.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];

    picName = [NSArray arrayWithObjects:@"scarfs", @"scarf.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];
    
    picName = [NSArray arrayWithObjects:@"light jackets", @"jacket.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];
    
    picName = [NSArray arrayWithObjects:@"flannels", @"longshirt.png", nil];
    d = [NSDictionary dictionaryWithObjects:picName forKeys:keys];
    [self.userClosets.clothesTypes addObject:d];
    
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        //weather from location
        self.location = _locationManager.location;
        
        NSString* weatherUrl = [NSString stringWithFormat:@"http://api.worldweatheronline.com/free/v2/weather.ashx?key=adc806be389bed380ac6f465c53e6&q=%.2f,%.2f&num_of_days=2&tp=3&format=json",self.location.coordinate.latitude,self.location.coordinate.longitude];
        
        self.userWeather = [KCDDictionary dictionaryWithContentsOfJSONURLString:weatherUrl];
        NSDictionary* data = [NSDictionary dictionaryWithDictionary:[self.userWeather objectForKey:@"data"]];
        NSArray *array = [data objectForKey:@"current_condition"];
        NSDictionary * currentCondition = [array objectAtIndex:0];
        NSNumber * temp =[currentCondition objectForKey:@"FeelsLikeF"];
        NSNumber * precip = [currentCondition objectForKey:@"precipMM"];
        
        if(temp){
            if([temp doubleValue] < [freezingTemp doubleValue]){
                self.userClosets.typeWeather = @"freezing";
            }
            else if([temp doubleValue] < [coldTemp doubleValue]){
                self.userClosets.typeWeather = @"cold";
            }
            else if([temp doubleValue] < [moderateTemp doubleValue]){
                self.userClosets.typeWeather = @"moderate";
            }
            else if([temp doubleValue] < [warmTemp doubleValue]){
                self.userClosets.typeWeather = @"warm";
            }
            else if([temp doubleValue] < [hotTemp doubleValue]){
                self.userClosets.typeWeather = @"hot";
            }
            else{
                self.userClosets.typeWeather = @"hot";
            }
            NSLog(@"%@",self.userClosets.typeWeather);
        }
        else{
        }
        
        if(precip){
            if([precip doubleValue] > [precipWeather doubleValue]){
                self.userClosets.isPrecip = true;
            }
            else{
                self.userClosets.isPrecip = false;
            }
            NSLog(@"%d",self.userClosets.isPrecip);
        }
        else{
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
