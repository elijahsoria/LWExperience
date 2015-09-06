//
//  LWMShareNote.h
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface LWMShareNote : UIViewController <FBFriendPickerDelegate, FBLoginViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *friend_list_text;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *wait_wheel;
- (IBAction)Cancel:(id)sender;
@property (strong, nonatomic) IBOutlet FBLoginView *loginView;
@property (strong, nonatomic) IBOutlet UIView *post_wait_view;
@property (strong, nonatomic) IBOutlet UILabel *PostName;
@property (strong, nonatomic) IBOutlet UIImageView *PostPicture;
@property (strong, nonatomic) IBOutlet UIButton *PostButton;
- (IBAction)PostNow:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *AddButton;
- (IBAction)AddFriends:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *AtFriend;
@property (strong, nonatomic) IBOutlet UIButton *TagDisabled;
@property NSString *PostTags;
@property (strong, nonatomic) IBOutlet UIButton *ShareDisabled;
@property NSString *geoloc;
@property NSString *location;
@property (strong, nonatomic) IBOutlet UITextView *PostMessage;
@property BOOL post_complete;
@property UIImage *post_image;
@property NSString *post_message;
@property NSString *post_name;
@property FBSessionDefaultAudience ShareAudience;
- (IBAction)ShareDisabled:(id)sender;
@property (retain, nonatomic) FBFriendPickerViewController *friendPickerController;
- (IBAction)TagDisabled:(id)sender;
@property NSArray *selected_friends;
@property NSString *postID;
@end
