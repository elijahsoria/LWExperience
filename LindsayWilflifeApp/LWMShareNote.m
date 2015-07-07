//
//  LWMShareNote.m
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMShareNote.h"
#import <AddressBook/AddressBook.h>
#import "LWMStyle.h"

@interface LWMShareNote ()

@end

@implementation LWMShareNote
@synthesize wait_wheel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _post_complete=0;
        _ShareAudience=FBSessionDefaultAudienceOnlyMe;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [_post_wait_view setHidden:YES];
    [wait_wheel setHidden:YES];
    _selected_friends = nil;

    NSDictionary *attrs2 = [NSDictionary dictionaryWithObjectsAndKeys:
                            [LWMStyle setFont:@"description"], NSFontAttributeName,
                            [LWMStyle setTextColor:@"dark"], NSForegroundColorAttributeName, nil];
    
      _PostMessage.attributedText = [[NSMutableAttributedString alloc] initWithString:_post_message attributes:attrs2];
      
    
    _PostPicture.image=_post_image;
    _PostName.text=_post_name;
    _loginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    // If the user is logged in, they can post to Facebook using API calls, so we show the buttons
    [_TagDisabled setHidden:YES];
    [_ShareDisabled setHidden:YES];
    
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    // If the user is NOT logged in, they can't post to Facebook using API calls, so we show the buttons
    [_TagDisabled setHidden:NO];
    [_ShareDisabled setHidden:NO];
}

// You need to override loginView:handleError in order to handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures since that happen outside of the app.
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        //NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        //NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}



- (void)Tag{
    NSString *path = [NSString stringWithFormat:@"%@/tags", _postID];
    NSMutableArray *tags = [[NSMutableArray alloc] init];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [wait_wheel startAnimating];
    [_post_wait_view setHidden:NO];
    [wait_wheel setHidden:NO];
    
    for (id<FBGraphUser> user in _selected_friends) {
         NSString *tag = [[NSString alloc] initWithFormat:@"{\"tag_uid\":\"%@\"}",[user objectForKey:@"id"] ];
        [tags addObject:tag];
    }
    
    NSString *friendIdsSeparation=[tags componentsJoinedByString:@","];
    NSString *friendIds = [[NSString alloc] initWithFormat:@"[%@]",friendIdsSeparation ];
    [param setObject:friendIds forKey:@"tags"];
    
    
    
    [FBRequestConnection startWithGraphPath:path parameters:param HTTPMethod:@"POST"     completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        //check error here
        if (error) {
            //NSLog(@"NO");
        } else {
            //show success alert
            [wait_wheel stopAnimating];
            UIAlertView *Posted_withFriends = [[UIAlertView alloc] initWithTitle:@"Friends Tagged" message:@"You've share your field note with some friends!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
            [Posted_withFriends show];
        }
    }];
    
   
    
}
- (IBAction)PostNow:(id)sender {
    
    NSData *imageData = UIImagePNGRepresentation(_PostPicture.image);
    
    
    
    // We will post on behalf of the user, these are the permissions we need:
    NSArray *permissionsNeeded = @[@"publish_actions"];
    
    // Request the permissions the user currently has
    [FBRequestConnection startWithGraphPath:@"/me/permissions"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error){
                                  NSDictionary *currentPermissions= [(NSArray *)[result data] objectAtIndex:0];
                                  NSMutableArray *requestPermissions = [[NSMutableArray alloc] initWithArray:@[]];
                                  
                                  // Check if all the permissions we need are present in the user's current permissions
                                  // If they are not present add them to the permissions to be requested
                                  for (NSString *permission in permissionsNeeded){
                                      if (![currentPermissions objectForKey:permission]){
                                          [requestPermissions addObject:permission];
                                      }
                                  }
                                  
                                  // If we have permissions to request
                                  if ([requestPermissions count] > 0){
                                      // Ask for the missing permissions
                                      [FBSession.activeSession requestNewPublishPermissions:requestPermissions
                                                                            defaultAudience:_ShareAudience
                                                                          completionHandler:^(FBSession *session, NSError *error) {
                                                                              if (!error) {
                                                                                  // Permission granted, we can request the user information
                                                                                  //NSLog(@"Permissions Requested and Granted!");
                                                                                  [self postDataToFB:imageData andString:_PostMessage.text];
                                                                                  
                                                                              } else {
                                                                                  // An error occurred, handle the error
                                                                                  // See our Handling Errors guide: https://developers.facebook.com/docs/ios/errors/
                                                                                  //NSLog(@"Cannot request");
                                                                                  //NSLog(@"%@", error.description);
                                                                              }
                                                                          }];
                                  } else {
                                      // Permissions are present, we can request the user information
                                      //NSLog(@"Permissions Present");
                                      [self postDataToFB:imageData andString:_PostMessage.text];
                                  }
                                  
                              } else {
                                  // There was an error requesting the permission information
                                  // See our Handling Errors guide: https://developers.facebook.com/docs/ios/errors/
                                  //NSLog(@"Cannot access permission!");
                                  //NSLog(@"%@", error.description);
                              }
                          }];
}

-(void)postDataToFB:(NSData *)imageData andString:(NSString *)statusPostString
{
    NSString *text = [[NSString alloc] initWithFormat:@"%@\n\nTags: %@\n\nLocation: %@\n\nLat, Long: %@", _PostMessage.text, _PostTags, _location, _geoloc];
    NSDictionary *parameters = @{@"message": text, @"link": @"https://www.facebook.com/LWM.Encounters", @"picture": imageData};
    _PostButton.enabled=NO;
    _AddButton.enabled=NO;
    [_post_wait_view setHidden:NO];
    [wait_wheel setHidden:NO];

    [wait_wheel startAnimating];
    
    [FBRequestConnection startWithGraphPath:@"me/photos"
                                 parameters:parameters
                                 HTTPMethod:@"POST"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error)
     {
         
         if (error) {
    
         } else {
             _postID=[[NSString alloc] initWithString:[result objectForKey:@"id"]];
             

             _post_complete=1;
             
             if (_selected_friends.count==0) {
                 //show success alert
                 UIAlertView *Posted = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Your Field Note has been posted to Facebook!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
                
                 [_post_wait_view setHidden:YES];
                 [wait_wheel stopAnimating];
                 [wait_wheel setHidden:YES];
                 
                 [Posted show];
             }
             else{
                 UIAlertView *Tagging = [[UIAlertView alloc] initWithTitle:@"Tagging Friends" message:@"Your Field Note has been posted to Facebook!\n\nNow tagging your friends!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
                 [_post_wait_view setHidden:YES];
                 [wait_wheel stopAnimating];
                 [wait_wheel setHidden:YES];
                 
                 [Tagging show];
                 
             }
             
             
         }
     }];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    if ([identifier isEqualToString:@"showFriendPicker"]) {
        FBFriendPickerViewController *friendPickerViewController = segue.destinationViewController;
        //[friendPickerViewController setStatusBarStyle:UIStatusBarStyleLightContent];
        // Set up the friend picker to sort and display names the same way as the
        // iOS Address Book does.
        
        // Need to call ABAddressBookCreate in order for the next two calls to do anything.
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        friendPickerViewController.sortOrdering = (ABPersonGetSortOrdering() == FBFriendSortByFirstName ? FBFriendSortByFirstName : FBFriendSortByLastName);
        friendPickerViewController.displayOrdering = (ABPersonGetCompositeNameFormatForRecord(NULL)==kABPersonCompositeNameFormatFirstNameFirst ? FBFriendDisplayByFirstName : FBFriendDisplayByLastName);
        CFRelease(addressBook);
        
        [friendPickerViewController loadData];
        friendPickerViewController.selection = self.selected_friends;
        friendPickerViewController.delegate = self;
    }
}

- (IBAction)AddFriends:(id)sender {
    
}



- (void)facebookViewControllerCancelWasPressed:(id)sender
{
    [sender performSegueWithIdentifier:@"dismiss" sender:sender];
}

- (void)facebookViewControllerDoneWasPressed:(id)sender
{
    _selected_friends=((FBFriendPickerViewController *)sender).selection;

    [sender performSegueWithIdentifier:@"dismiss" sender:sender];
}

- (IBAction)showMain:(UIStoryboardSegue *)segue
{
    // This method exists in order to create an unwind segue to this controller.
}



- (void)viewWillAppear:(BOOL)animated{
    
    NSMutableString *list = [[NSMutableString alloc] init];
    NSDictionary *attrs2 = [NSDictionary dictionaryWithObjectsAndKeys:
                            [LWMStyle setFont:@"description"], NSFontAttributeName,
                            [LWMStyle setTextColor:@"dark"], NSForegroundColorAttributeName, nil];
    
    if (_selected_friends.count==0) {
        _friend_list_text.attributedText = [[NSMutableAttributedString alloc] initWithString:@"No Friends Selected" attributes:attrs2];
    }
    else{
        
        for (id<FBGraphUser> user in _selected_friends) {
            [list appendString: [user objectForKey:@"name"]];
            [list appendString:@"\n"];
        }
        
        
        
        _friend_list_text.attributedText=[[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@" %@ ", list]
                                                        attributes:attrs2];
    
        
    }
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    self.friendPickerController = nil;
}



- (IBAction)Cancel:(id)sender {
    UIAlertView *cancel_alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Changes you made have not been saved! Do you want to really want to cancel?" delegate:self cancelButtonTitle:@"Go Back" otherButtonTitles:@"Don't Save", nil];
    [cancel_alert show];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView.title isEqualToString:@"Warning"]) {
        if (buttonIndex == 1) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }
    
    else if([alertView.title isEqualToString:@"Success"]) {
        [self dismissViewControllerAnimated:YES completion:nil];

    }
    
    else if([alertView.title isEqualToString:@"Tagging Friends"]) {
        [self Tag];
        
    }
    
    else if([alertView.title isEqualToString:@"Friends Tagged"]) {
        [self dismissViewControllerAnimated:YES completion:nil];

    }
    
    else if ([alertView.title isEqualToString:@"Friends Tagged"]){
    }
}
- (IBAction)ShareDisabled:(id)sender {
    UIAlertView *Login = [[UIAlertView alloc] initWithTitle:@"Not Logged In" message:@"You have to log in with Facebook before you can share" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
    [Login show];
}
- (IBAction)TagDisabled:(id)sender {
    UIAlertView *Login = [[UIAlertView alloc] initWithTitle:@"Not Logged In" message:@"You have to log in with Facebook before you can share" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
    [Login show];
}
@end
