//
//  LYRUIConversationListTest.m
//  LayerUIKit
//
//  Created by Kevin Coleman on 12/16/14.
//
//

#import <XCTest/XCTest.h>
#import <LayerUIKit/LayerUIKit.h>
#import "LYRUITestInterface.h"
#import "LYRClientMock.h"
#import "LYRUISampleConversationListViewController.h"

@interface LYRUIConversationListViewController ()

@property (nonatomic) LYRQueryController *queryController;

@end

@interface LYRUIConversationListTest : XCTestCase

@property (nonatomic) LYRUITestInterface *testInterface;
@property (nonatomic) LYRUIConversationListViewController *viewController;

@end

@implementation LYRUIConversationListTest

- (void)setUp
{
    [super setUp];
    
    LYRUserMock *mockUser = [LYRUserMock userWithMockUserName:LYRClientMockFactoryNameRussell];
    LYRClientMock *layerClient = [LYRClientMock layerClientMockWithAuthenticatedUserID:mockUser.participantIdentifier];
    self.testInterface = [LYRUITestInterface testIntefaceWithLayerClient:layerClient];
}

- (void)tearDown
{
    [self resetAppearance];
    [[LYRMockContentStore sharedStore] resetContentStore];
    self.viewController.queryController = nil;
    self.testInterface = nil;
    
    [super tearDown];
}

- (void)testToVerifyConversationListBaseUI
{
    self.viewController = [LYRUISampleConversationListViewController conversationListViewControllerWithLayerClient:(LYRClient *)self.testInterface.layerClient];
    self.viewController.allowsEditing = YES;
    [self setRootViewController:self.viewController];
    
    [tester waitForViewWithAccessibilityLabel:@"Messages"];
    [tester waitForViewWithAccessibilityLabel:@"Edit Button"];
}

//Load the list and verify that all conversations returned by conversationForIdentifiers: is presented in the list.
- (void)testToVerifyConversationListDisplaysAllConversationsInLayer
{
    self.viewController = [LYRUISampleConversationListViewController conversationListViewControllerWithLayerClient:(LYRClient *)self.testInterface.layerClient];
    [self setRootViewController:self.viewController];
    
    NSString *message1 = @"Message1";
    LYRUserMock *mockUser1 = [LYRUserMock userWithMockUserName:LYRClientMockFactoryNameMarshawn];
    LYRConversationMock *conversation1 = [self.testInterface conversationWithParticipants:[NSSet setWithObject:mockUser1.participantIdentifier] lastMessageText:message1];
    
    NSString *message2 = @"Message2";
    LYRUserMock *userMock2 = [LYRUserMock randomUser];
    LYRConversationMock *conversation2 = [self.testInterface conversationWithParticipants:[NSSet setWithObject:userMock2.participantIdentifier] lastMessageText:message2];
    
    NSString *message3 = @"Message3";
    LYRUserMock *userMock3 = [LYRUserMock randomUser];
    LYRConversationMock *conversation3 =  [self.testInterface conversationWithParticipants:[NSSet setWithObject:userMock3.participantIdentifier] lastMessageText:message3];
    
    [tester waitForViewWithAccessibilityLabel:[self.testInterface conversationLabelForConversation:conversation1]];
    [tester waitForViewWithAccessibilityLabel:[self.testInterface conversationLabelForConversation:conversation2]];
    [tester waitForViewWithAccessibilityLabel:[self.testInterface conversationLabelForConversation:conversation3]];
}

//Test swipe to delete for deleting a conversation. Verify the conversation is deleted from the table and from the Layer client.
- (void)testToVerifyGlobalDeletionButtonFunctionality
{
    self.viewController = [LYRUISampleConversationListViewController conversationListViewControllerWithLayerClient:(LYRClient *)self.testInterface.layerClient];
    [self setRootViewController:self.viewController];
    
    NSString *message1 = @"Message1";
    LYRUserMock *mockUser1 = [LYRUserMock userWithMockUserName:LYRClientMockFactoryNameMarshawn];
    LYRConversationMock *conversation1 = [self.testInterface conversationWithParticipants:[NSSet setWithObject:mockUser1.participantIdentifier] lastMessageText:message1];
    
    [tester waitForViewWithAccessibilityLabel:[self.testInterface conversationLabelForConversation:conversation1]];
    [tester swipeViewWithAccessibilityLabel:[self.testInterface conversationLabelForConversation:conversation1] inDirection:KIFSwipeDirectionLeft];
    [self deleteConversation:conversation1 deletionMode:LYRDeletionModeAllParticipants];
}

//Test swipe to delete for deleting a conversation. Verify the conversation is deleted from the table and from the Layer client.
- (void)testToVerifyLocalDeletionButtonFunctionality
{
    self.viewController = [LYRUISampleConversationListViewController conversationListViewControllerWithLayerClient:(LYRClient *)self.testInterface.layerClient];
    [self setRootViewController:self.viewController];
    
    NSString *message1 = @"Message1";
    LYRUserMock *mockUser1 = [LYRUserMock userWithMockUserName:LYRClientMockFactoryNameMarshawn];
    LYRConversationMock *conversation1 = [self.testInterface conversationWithParticipants:[NSSet setWithObject:mockUser1.participantIdentifier] lastMessageText:message1];
    
    [tester waitForViewWithAccessibilityLabel:[self.testInterface conversationLabelForConversation:conversation1]];
    [tester swipeViewWithAccessibilityLabel:[self.testInterface conversationLabelForConversation:conversation1] inDirection:KIFSwipeDirectionLeft];
    [self deleteConversation:conversation1 deletionMode:LYRDeletionModeLocal];
}

//Test engaging editing mode and deleting several conversations at once. Verify that all conversations selected are deleted from the table and from the Layer client.
- (void)testToVerifyEditingModeAndMultipleConversationDeletionFunctionality
{
    self.viewController = [LYRUISampleConversationListViewController conversationListViewControllerWithLayerClient:(LYRClient *)self.testInterface.layerClient];
    [self setRootViewController:self.viewController];
    
    NSString *message1 = @"Message1";
    LYRUserMock *mockUser1 = [LYRUserMock userWithMockUserName:LYRClientMockFactoryNameMarshawn];
    LYRConversationMock *conversation1 = [self.testInterface conversationWithParticipants:[NSSet setWithObject:mockUser1.participantIdentifier] lastMessageText:message1];
    
    NSString *message2 = @"Message2";
    LYRUserMock *mockUser2 = [LYRUserMock userWithMockUserName:LYRClientMockFactoryNameCam];
    LYRConversationMock *conversation2 = [self.testInterface conversationWithParticipants:[NSSet setWithObject:mockUser2.participantIdentifier] lastMessageText:message2];
    
    NSString *message3 = @"Message3";
    LYRUserMock *mockUser3 = [LYRUserMock userWithMockUserName:LYRClientMockFactoryNameBobby];
    LYRConversationMock *conversation3 =  [self.testInterface conversationWithParticipants:[NSSet setWithObject:mockUser3.participantIdentifier] lastMessageText:message3];
    
    [tester waitForViewWithAccessibilityLabel:[self.testInterface conversationLabelForConversation:conversation1]];
    [tester waitForViewWithAccessibilityLabel:[self.testInterface conversationLabelForConversation:conversation2]];
    [tester waitForViewWithAccessibilityLabel:[self.testInterface conversationLabelForConversation:conversation3]];
    
    [tester tapViewWithAccessibilityLabel:@"Edit"];
    
    [tester tapViewWithAccessibilityLabel:[NSString stringWithFormat:@"Delete %@", mockUser1.fullName]];
    [self deleteConversation:conversation1 deletionMode:LYRDeletionModeLocal];
    
    [tester tapViewWithAccessibilityLabel:[NSString stringWithFormat:@"Delete %@", mockUser2.fullName]];
    [self deleteConversation:conversation2 deletionMode:LYRDeletionModeLocal];
    
    [tester tapViewWithAccessibilityLabel:[NSString stringWithFormat:@"Delete %@", mockUser3.fullName]];
    [self deleteConversation:conversation3 deletionMode:LYRDeletionModeLocal];
}

//Disable editing and verify that the controller does not permit the user to attempt to edit or engage swipe to delete.
- (void)testToVerifyDisablingEditModeDoesNotAllowUserToDeleteConversations
{
    self.viewController = [LYRUISampleConversationListViewController conversationListViewControllerWithLayerClient:(LYRClient *)self.testInterface.layerClient];
    [self.viewController setAllowsEditing:NO];
    [self setRootViewController:self.viewController];
    
    NSString *message1 = @"Message1";
    LYRUserMock *mockUser1 = [LYRUserMock userWithMockUserName:LYRClientMockFactoryNameMarshawn];
    LYRConversationMock *conversation1 = [self.testInterface conversationWithParticipants:[NSSet setWithObject:mockUser1.participantIdentifier] lastMessageText:message1];
    [tester waitForViewWithAccessibilityLabel:[self.testInterface conversationLabelForConversation:conversation1]];
    
    [tester swipeViewWithAccessibilityLabel:[self.testInterface conversationLabelForConversation:conversation1] inDirection:KIFSwipeDirectionLeft];
    [tester waitForAbsenceOfViewWithAccessibilityLabel:[NSString stringWithFormat:@"Global"]];
    [tester waitForAbsenceOfViewWithAccessibilityLabel:[NSString stringWithFormat:@"Local"]];
}

//Customize the fonts and colors using UIAppearance and verify that the configuration is respected.
- (void)testToVerifyColorAndFontChangeFunctionality
{
    self.viewController = [LYRUISampleConversationListViewController conversationListViewControllerWithLayerClient:(LYRClient *)self.testInterface.layerClient];
    [self setRootViewController:self.viewController];
    
    UIFont *testFont = [UIFont systemFontOfSize:20];
    UIColor *testColor = [UIColor redColor];
    
    [[LYRUIConversationTableViewCell appearance] setConversationLabelFont:testFont];
    [[LYRUIConversationTableViewCell appearance] setConversationLabelColor:testColor];
    
    NSString *message1 = @"Message1";
    LYRUserMock *mockUser1 = [LYRUserMock userWithMockUserName:LYRClientMockFactoryNameMarshawn];
    LYRConversationMock *conversation1 =  [self.testInterface conversationWithParticipants:[NSSet setWithObject:mockUser1.participantIdentifier] lastMessageText:message1];
    
    [tester waitForViewWithAccessibilityLabel:[self.testInterface conversationLabelForConversation:conversation1]];
    
    NSString *conversationLabel = [self.testInterface conversationLabelForConversation:conversation1];
    
    LYRUIConversationTableViewCell *cell = (LYRUIConversationTableViewCell *)[tester waitForViewWithAccessibilityLabel:conversationLabel];
    expect(cell.conversationLabelFont).to.equal(testFont);
    expect(cell.conversationLabelColor).to.equal(testColor);
}

//Customize the row height and ensure that it is respected.
- (void)testToVerifyCustomRowHeightFunctionality
{
    self.viewController = [LYRUISampleConversationListViewController conversationListViewControllerWithLayerClient:(LYRClient *)self.testInterface.layerClient];
    [self.viewController setRowHeight:100];
    [self setRootViewController:self.viewController];
    
    NSString *message1 = @"Message1";
    LYRUserMock *mockUser1 = [LYRUserMock userWithMockUserName:LYRClientMockFactoryNameMarshawn];
    LYRConversationMock *conversation1 =  [self.testInterface conversationWithParticipants:[NSSet setWithObject:mockUser1.participantIdentifier] lastMessageText:message1];
    
    [tester waitForViewWithAccessibilityLabel:[self.testInterface conversationLabelForConversation:conversation1]];
    
    NSString *conversationLabel = [self.testInterface conversationLabelForConversation:conversation1];
    LYRUIConversationTableViewCell *cell = (LYRUIConversationTableViewCell *)[tester waitForViewWithAccessibilityLabel:conversationLabel];
    
    expect(cell.frame.size.height).to.equal(100);
}

//Customize the cell class and ensure that the correct cell is used to render the table.
-(void)testToVerifyCustomCellClassFunctionality
{
    self.viewController = [LYRUISampleConversationListViewController conversationListViewControllerWithLayerClient:(LYRClient *)self.testInterface.layerClient];
    [self.viewController setCellClass:[LYRUITestConversationCell class]];
    [self setRootViewController:self.viewController];
    
    NSString *message1 = @"Message1";
    LYRUserMock *mockUser1 = [LYRUserMock userWithMockUserName:LYRClientMockFactoryNameMarshawn];
    LYRConversationMock *conversation1 =  [self.testInterface conversationWithParticipants:[NSSet setWithObject:mockUser1.participantIdentifier] lastMessageText:message1];
    
    [tester waitForViewWithAccessibilityLabel:[self.testInterface conversationLabelForConversation:conversation1]];
    
    LYRUIConversationTableViewCell *cell = (LYRUIConversationTableViewCell *)[tester waitForViewWithAccessibilityLabel:[self.testInterface conversationLabelForConversation:conversation1]];
    
    expect([cell class]).to.equal([LYRUITestConversationCell class]);
    expect([cell class]).toNot.equal([LYRUIConversationTableViewCell class]);
}

//Verify that attempting to provide a cell class that does not conform to LYRUIConversationPresenting results in a runtime exception.
- (void)testToVerifyCustomCellClassNotConformingToProtocolRaisesException
{
    self.viewController = [LYRUISampleConversationListViewController conversationListViewControllerWithLayerClient:(LYRClient *)self.testInterface.layerClient];
    [self setRootViewController:self.viewController];
    expect(^{ [self.viewController setCellClass:[UITableViewCell class]]; }).to.raise(NSInternalInconsistencyException);
}

//Verify that attempting to change the cell class after the table is loaded results in a runtime error.
- (void)testToVerifyChangingCellClassAfterViewLoadRaiseException
{
    self.viewController = [LYRUISampleConversationListViewController conversationListViewControllerWithLayerClient:(LYRClient *)self.testInterface.layerClient];
    [self setRootViewController:self.viewController];
    expect(^{ [self.viewController setCellClass:[LYRUITestConversationCell class]]; }).to.raise(NSInternalInconsistencyException);
}

//Verify that attempting to change the cell class after the table is loaded results in a runtime error.
- (void)testToVerifyChangingCellHeighAfterViewLoadRaiseException
{
    self.viewController = [LYRUISampleConversationListViewController conversationListViewControllerWithLayerClient:(LYRClient *)self.testInterface.layerClient];
    [self setRootViewController:self.viewController];
    expect(^{ [self.viewController setRowHeight:40]; }).to.raise(NSInternalInconsistencyException);
}

//Verify that attempting to change the cell class after the table is loaded results in a runtime error.
- (void)testToVerifyChangingEditingSettingAfterViewLoadRaiseException
{
    self.viewController = [LYRUISampleConversationListViewController conversationListViewControllerWithLayerClient:(LYRClient *)self.testInterface.layerClient];
    [self setRootViewController:self.viewController];
    expect(^{ [self.viewController setAllowsEditing:YES]; }).to.raise(NSInternalInconsistencyException);
}

//Synchronize a new conversation and verify that it live updates into the conversation list.
- (void)testToVerifyCreatingANewConversationLiveUpdatesConversationList
{
    self.viewController = [LYRUISampleConversationListViewController conversationListViewControllerWithLayerClient:(LYRClient *)self.testInterface.layerClient];
    [self setRootViewController:self.viewController];
    
    NSString *message1 = @"Message1";
    LYRUserMock *mockUser1 = [LYRUserMock userWithMockUserName:LYRClientMockFactoryNameMarshawn];
    LYRConversationMock *conversation1 =  [self.testInterface conversationWithParticipants:[NSSet setWithObject:mockUser1.participantIdentifier] lastMessageText:message1];
    
    [tester waitForViewWithAccessibilityLabel:[self.testInterface conversationLabelForConversation:conversation1]];
}

- (void)deleteConversation:(LYRConversationMock *)conversation deletionMode:(LYRDeletionMode)deletionMode
{
    switch (deletionMode) {
        case LYRDeletionModeAllParticipants:
            [tester waitForViewWithAccessibilityLabel:@"Global"];
            [tester tapViewWithAccessibilityLabel:[NSString stringWithFormat:@"Global"]];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:[self.testInterface conversationLabelForConversation:conversation]];
            break;
        case LYRDeletionModeLocal:
            [tester waitForViewWithAccessibilityLabel:@"Local"];
            [tester tapViewWithAccessibilityLabel:[NSString stringWithFormat:@"Local"]];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:[self.testInterface conversationLabelForConversation:conversation]];
            break;
        default:
            break;
    }
}

- (void)setRootViewController:(UITableViewController *)controller
{
    [self.testInterface setRootViewController:controller];
    expect([controller.tableView numberOfRowsInSection:0]).to.equal(0);
    [tester waitForTimeInterval:1];
}

- (void)resetAppearance
{
    [[LYRUIConversationTableViewCell appearance] setConversationLabelFont:[UIFont systemFontOfSize:14]];
    [[LYRUIConversationTableViewCell appearance] setConversationLabelColor:[UIColor blackColor]];
    [[LYRUIConversationTableViewCell appearance] setLastMessageLabelFont:[UIFont systemFontOfSize:12]];
    [[LYRUIConversationTableViewCell appearance] setLastMessageLabelColor:[UIColor grayColor]];
    [[LYRUIConversationTableViewCell appearance] setDateLabelFont:[UIFont systemFontOfSize:12]];
    [[LYRUIConversationTableViewCell appearance] setDateLabelColor:[UIColor grayColor]];
    [[LYRUIConversationTableViewCell appearance] setUnreadMessageIndicatorBackgroundColor:[UIColor cyanColor]];
    [[LYRUIConversationTableViewCell appearance] setCellBackgroundColor:[UIColor whiteColor]];
    
}

@end