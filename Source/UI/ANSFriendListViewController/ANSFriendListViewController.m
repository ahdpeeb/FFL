//
//  ANSViewControllerTables.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "ANSFriendListViewController.h"

#import "ANSFriendListView.h"
#import "ANSUserCell.h"
#import "ANSTableViewCell.h"
#import "ANSImageModel.h"
#import "ANSImageView.h"
#import "ANSNameFilterModel.h"
#import "ANSFBUser.h"
#import "ANSFBFriends.h"
#import "ANSFBFriendsContext.h"
#import "ANSMapViewController.h"
#import "ANSConstants.h"

#import "NSArray+ANSExtension.h"
#import "UINib+Extension.h"
#import "UITableView+Extension.h"
#import "ANSChangeModel+UITableView.h"
#import "UIViewController+ANSExtension.h"
#import "ANSLoadingView.h"

#import "ANSMacros.h"
#import "ANSGCD.h"

ANSViewControllerBaseViewProperty(ANSFriendListViewController, ANSFriendListView, friendListView);

@interface ANSFriendListViewController ()
@property (nonatomic, strong)   ANSFBFriends                        *friends;
@property (nonatomic, strong)   ANSProtocolObservationController  *usersController;

@property (nonatomic, strong)   ANSNameFilterModel                  *filteredModel;
@property (nonatomic, strong)   ANSProtocolObservationController  *filterModelController;

@property (nonatomic, strong)   ANSFBFriendsContext               *friendsContext;
@property (nonatomic, readonly) ANSArrayModel                      *presentedModel;;

@property (nonatomic, strong)   SRWebSocket                        *webSocket;
@property (nonatomic, strong)   ANSFBUser                          *targetUser;

- (void)resignSearchBar;
- (void)initFilterInfrastructure;
- (void)onLeftButton;

@end

@implementation ANSFriendListViewController;

@dynamic presentedModel;

#pragma mark -
#pragma Initialization and deallocation

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    [self initLeftButton];
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self initLeftButton];
   
    return self; 
}

#pragma mark -
#pragma mark Accsessors

- (void)setUser:(ANSFBUser *)user {
    if (_user != user) {
        _user = user;
        
        self.friends = [ANSFBFriends new];
        ANSFBFriendsContext *context = [[ANSFBFriendsContext alloc] initWithModel:self.friends];
        self.friendsContext = context;
        context.user = user;
        [context execute];
    }
}

- (void)setFriends:(ANSFBFriends *)friends {
    if (_friends != friends) {
        _friends = friends;
        
        self.usersController = [friends protocolControllerWithObserver:self];
        [self initFilterInfrastructure];
    }
}

- (void)setFilteredModel:(ANSNameFilterModel *)filteredModel {
    if (_filteredModel != filteredModel) {
        _filteredModel = filteredModel;
        
        self.filterModelController = [filteredModel protocolControllerWithObserver:self];
    }
}

- (ANSArrayModel *)presentedModel {
    BOOL isFirstResponder = self.friendListView.searchBar.isFirstResponder;
    
    return isFirstResponder ? self.filteredModel : self.friends;
}

- (void)setWebSocket:(SRWebSocket *)webSocket {
    if (_webSocket != webSocket) {
        _webSocket = webSocket;
        
        _webSocket.delegate = self;
    }
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = kANSTitleForHeaderSection;
}

#pragma mark -
#pragma mark BarButtonItems

- (void)initLeftButton {
    UIBarButtonItem *leftButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                                  target:self action:@selector(onLeftButton)];
    
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)onLeftButton {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Private methods

- (void)resignSearchBar {
    UISearchBar *searchBar = self.friendListView.searchBar;
    if (searchBar.isFirstResponder) {
        [self searchBarCancelButtonClicked:searchBar];
    }
}

- (void)initFilterInfrastructure {
    ANSFBFriends *friends = self.friends;
    ANSNameFilterModel *nameFilterModel = [[ANSNameFilterModel alloc]
                                           initWithObservableModel:friends];
    self.filteredModel = nameFilterModel;
}

- (void)socketConnection {
    NSURL *url = [NSURL URLWithString:kASNServerAdress];
    self.webSocket = [[SRWebSocket alloc] initWithURL:url];
    [self.webSocket open];
}

- (NSData *)JSONDataAskGeo {
    NSString *userID = @(self.user.ID).stringValue;
    NSString *targetUserId = @(self.targetUser.ID).stringValue;
    NSDictionary *json = @{@"type": @"ask_geo",
                         @"fb_id" : userID,
                     @"target_id" : targetUserId};
    
    return  [NSJSONSerialization dataWithJSONObject:json
                                            options:NSJSONWritingPrettyPrinted
                                              error:nil];
}

#pragma mark -
#pragma mark Gestures

- (IBAction)onRightSwipe:(UISwipeGestureRecognizer *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource protocol

- (nullable NSString *)tableView:(UITableView *)tableView
         titleForHeaderInSection:(NSInteger)section
{
    return section ? nil : kANSTitleForHeaderSection;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return kANSSectionsCount;
}

- (NSInteger)   tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
    return self.presentedModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ANSUserCell *cell = [tableView dequeueReusableCellWithClass:[ANSUserCell class]];
    ANSFBUser *user = self.presentedModel[indexPath.row];
    [cell fillWithUser:user];

    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate protocol

- (void)             tableView:(UITableView *)tableView
       didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.friendListView.loadingViewVisible = YES;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.targetUser = self.friends[indexPath.row];
    [self socketConnection];
}

#pragma mark -
#pragma mark UISearchBarDelegate protocol

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    
    [self.friendListView.tableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.filteredModel filterByfilterString:searchText];
}

#pragma mark -
#pragma mark ANSLoadableModelObserver protocol

- (void)loadableModelLoading:(ANSLoadableModel *)model {
    ANSPerformAsyncOnMainQueue(^{
        self.friendListView.loadingViewVisible = YES;
    });
}

- (void)loadableModelDidLoad:(ANSLoadableModel *)model {
    ANSPerformAsyncOnMainQueue(^{
        self.friendListView.loadingViewVisible = NO;
        [self.friendListView.tableView reloadData];
    });
}

#pragma mark -
#pragma mark ANSNameFilterModelProtocol 

- (void)nameFilterModelDidFilter:(ANSNameFilterModel *)model {
    ANSPerformAsyncOnMainQueue(^{
        NSLog(@"notified didFilterWithUserInfo - %@ ", model);
        [self.friendListView.tableView reloadData];
    });
}

#pragma mark -
#pragma mark SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
 //   [self.webSocket send:[self JSONDataAskGeo]];
    self.friendListView.loadingViewVisible = NO;
    ANSMapViewController *mapController = [ANSMapViewController new];
    mapController.userFriend = self.targetUser;
    mapController.frindLatitude = 50.40444260;
    mapController.frindlongitude = 30.55454572;
    [self.navigationController pushViewController:mapController animated:YES];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    self.friendListView.loadingViewVisible = NO;
    NSLog(@"[ERROr] %@", [error localizedDescription]);
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"[INFO] didReceiveMessage after ask_geo (message - %@)", message);
    [self.webSocket close];
    self.friendListView.loadingViewVisible = NO;
    ANSMapViewController *mapController = [ANSMapViewController new];
    //prepare for transition to mapController!!!!!!!!!
   
}

@end
