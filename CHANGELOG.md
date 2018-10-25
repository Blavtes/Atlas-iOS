# Atlas Changelog

## 1.2.1

### Bug Fixes

* Fixes a UI issue where messages could become hidden behind the navigation bar for new conversations. [IOS-3232]

## 1.2.0

### Enhancements

* Adds support for the newer versions of LayerKit (~> 4.0.0). [IOS-3413]

## 1.1.5

### Bug Fixes

* Fixes an error when installing Atlas via Carthage.

## 1.1.4

### Bug fixes

* Fixes UI of `ATLConversationViewController` for iPhone X
* Fixes a crash in `ATLConversationViewController` when rapidly sending multiple messages by multiple users.
* Fixes a crash in `ATLConversationViewController` when changing list of participants and sending or receiving message at the same time.

## 1.1.3

### Bug Fixes

* Fixes an error when installing Atlas via Carthage.

## 1.1.2

### Bug Fixes

* Fixes a crash in `ATLMediaInputStream` when sending an image from the camera roll on iOS 11. [IOS-3225]
* Fixes an issue where the text input and accessory buttons in the `ATLMessageInputToolbar` would not respond to tap actions on iOS 11.

## 1.1.1

### Public API Changes

* Added the `presenceStatusEnabled` property to the `ATLParticipantPresenting` protocol.
* Added the `presenceStatusEnabled` property to the `ATLAddressBarViewController`.
* Added the `shouldShowAvatarItem` and `presenceStatusEnabled` properties to the `ATLParticipantTableViewController`.

### Enhancements

* `ATLParticipantTableViewCell` will now show presence status based on the value of `presenceStatusEnabled` defined in the `ATLParticipantTableViewController`.
* The address bar's search results will now show presence status based on the value of `presenceStatusEnabled` defined in `ATLAddressBarViewController`.

### Bug Fixes

* Fixes a bug where an empty gap would display instead of the date and time above a message.
* Fixes a bug where re-creating a previously deleted conversation would cause the more-messages spinner to continously display without actually loading anything. [iOS-3013]
* Fixes a bug where the queryController pagination window could be set to zero, causing a crash. [iOS-3074]

## 1.1.0

Introducing the presence feature, which allows you to display a user's presence status as a color-coded icon next to their avatar image. [APPS-2740]

### Public API Changes

* Added a new `ATLPresenceStatusView` object, which renders a color-coded circle to represent a user's presence status. Added this to the `ATLAvatarItem`.
* `ATLAvatarImageView` was renamed to `ATLAvatarView`.
* Added the `presenceStatusEnabled` property to `ATLAvatarView`, which sets whether the presence status is shown. Default is `YES`.
* Added a read-only accessor `presenceStatus` to the `ATLAvatarItem`.

## 1.0.33

### Public API Changes

* Added `shouldDisplayUsernameForOneOtherParticipant` as a configurable property to `ATLConversationViewController`.
* `dateString` and `participantName` parameters marked as `nullable` within `ATLConversationCollectionViewHeader:headerHeightWithDateString:`.
* Made the return value of `ATLConversationListViewController:avatarItemForConversation:` `nullable`.

### Enhancements

* Refactored queryController delegate methods to return early if the view is not visible. This helps harden against `NSInternalInconsistencyException` errors.
* Refactored `ATLConversationListViewController` to track all changes from the queryController as they come in. Once the queryController finishes the changes, the tableView is updated. This helps harden against `NSInternalInconsistencyException` errors.
* Changed all `@import LayerKit` to `#import <LayerKit/LayerKit.h>`
* Refactored code to satisfy analyzer warnings.

### Bug Fixes

* `ATLConversationListViewController:configureCell:atIndexPath:` returns early if no conversation is found at `indexPath`.
* Prevent `ATLAvatarImageView` from flickering when setting the same `remoteImageURL`'s image
* Fixes a bug where the timestamp might incorrectly get overlaid across the message bubble.

## 1.0.32

### Bug Fixes

* Fixed an issue in `ATLMessageInputToolbar` where creating a new line would incorrectly offset the text above until the next character was entered. This also fixed a crash that could happen if Return was pressed rapidly in succession. [APPS-2663]
* Fixed a crash that could occur if the `tableFooterView` in the `ATLConversationListViewController` wasn't initialized. [APPS-2774]
* Fixed an issue where pulling to load more messages in a conversations wouldn't work when it should

## 1.0.31

### Enhancements

* Replaced deprecated `UISearchDisplayController` with `UISearchController` in `ATLConversationListViewController`. This reduces complexity by removing the need to switch between different query controllers.
* Replaced deprecated `UISearchDisplayController` with `UISearchController` in `ATLParticipantTableViewController`.
* Updated some deprecated `NSCalendar` objects in `ATLConversationTableViewCell`.
* Refactored `ATLConversationViewController` to harden against mismanagement and prevent common crashes and issues.

### Bug Fixes

* Fixed an issue in `ATLConversationViewController` where the "more messages indicator" would continue to display and spin even if all messages had been synced. This was due to a mismatch between the total number of messages in a conversation and the total number of non-deleted messages for that user. [APPS-2629]
* Fixed a pagination issue in `ATLConversationViewController` where, after navigating to a conversation, additional messages would not sync and the activity indicator would continue to spin until the user pulled down.
* `ATLConversationListViewController` no longer filters out conversations the authenticated user was removed from. This allows the user to access the conversation and mark messages as read in order to have an accurate unread badge count.
* Fixed a crash in `ATLAddressBarViewController` that could occur if a participant was selected while the `displayName` was `nil`. It will now appear as `Unknown Participant` instead.

## 1.0.30

### Enhancements

* `ATLParticipantTableDataSet` is now mutable and observes changes to Identity objects and updates the associated `UITableView`. [APPS-2470]
* Displays timestamps in `ATLConversationViewController` for groups of messages regardless of sorting. Messages sent first but displayed second will now show a timestamp. [APPS-2608]
* Adds pagination capabilities to the `ATLConversationViewController` query controller. [APPS-2524]

### Bug Fixes

* Fixes a case in `ATLConversationViewController` where the query controller's delegate would not be unset.
* Fixes a couple issues in `ATLConversationListViewController` where the query controller could be instantiated twice. [APPS-2598]
* Fixes an issue where the "more messages" indicator would not initially appear in `ATLConversationViewController`.

## 1.0.29

### Bug Fixes

* Fixes the build errors in the included Example classes.
* Fixes a crash when updating the `ATLConversationListViewController` while the search bar is active. [APPS-2587]
* Fixes an issue in iOS 9 where the list of conversations would briefly flash when returning from a view with an active keyboard. [APPS-2594]
* Fixes an issue in the `ATLMessageInputToolbar` where adding a new line would result in text misalignment. [APPS-2593]

## 1.0.28

### Bug Fixes

* Fixes an issue where messages in a new conversation would not appear until the conversation was reloaded.
* Fixes a crash in the `ATLConversationListViewController` related to the query controller being initialized multiple times.
* Fixes a crash when trying to get the avatar initials from a `LYRIdentity` object if it wasn't fully synced.

## 1.0.27

### Bug Fixes

* Fixes the crash related to the new `LYRQueryController` behavior introduced in LayerKit v0.23.0. [APPS-2560]

## 1.0.26

### Bug Fixes

* Fix of the conversation list query in the `ATLConversationListViewController`. [APPS-2506]

## 1.0.25

### Enhancements

* Upgraded `LayerKit` to version `0.22.0`. Due to breaking API changes introduced in LayerKit, affected code has been fixed.

## 1.0.24

### Enhancements

* `ATLAddressBarController` now uses the `ATLParticipant` `displayName` property instead of `firstName` when displaying names in the `ATLAddressBarTextView`.

## 1.0.23

### Enhancements

* Adds support for `CocoaPods` 1.0.0.
* Bumps `LayerKit` version to `0.21.0`.

## 1.0.22

### Bug Fixes

* Fixes an issue where a loading spinner wouldn't disappear for conversations deleted with `My Devices` deletion mode.

## 1.0.21

### Bug Fixes

* Fixes an issue where a loading spinner wouldn't disappear after pulling to load more messages in a conversation view controller.
* Fixes an issue where info.plist key could prevent app store submission.

## 1.0.20

### Enhancements

* Integrates LayerKit's partial-sync feature in the `ATLConversationDataSource` class.
* Integrates LayerKit's identity feature into the `ATLConversationListViewController` and `ATLConversationViewController` classes.
* Updated nullability support.
* Added in line push support.

### Public API Changes

* `ATLConversationViewController` datasource method `conversationViewController:participantForIdentifier:` has been changed to `conversationViewController:participantForIdentity:`.
* Adds `conversationListViewController:rowActionsForDeletionModes:` method to `ATLConversationListViewControllerDataSource`.

### Bug Fixes

* Fixes a bug where the pagination window in the `ATLConversationViewController` kept the spinner on screen even when no longer loading messages.
* Fixed an issue where message part data was `nil` for text messages.

## 1.0.19

## Bug Fixes

* Fixed an issue in the `ATLConversationListViewController` that caused an exception to be thrown during cell dequeueing.
* Added missing files into the `Atlas` target to fix a bug with Carthage installations.

## 1.0.18

### Enhancements

* Added support for new `LayerKit` deletion mode `LYRDeletionModeMyDevices`.
* Removed support for `LYRDeletionModeLocal` as it has been deprecated.
* Changed default conversation deletion option strings to `My Devices` and `Everyone` to make the options more explicit.

## 1.0.17

### Public API Changes

* Introduced `ATLBaseCollectionViewCell` which is now the base cell for all message cells containing a message bubble. Developers can now subclass the `ATLBaseCollectionViewCell` and add easily their own custom UI to a message bubble cell.
* Moved the following properties from `ATLMessageCollectionViewCell` to `ATLBaseCollectionViewCell`: `bubbleViewColor`, `bubbleViewCornerRadius`, `bubbleView`, `avatarImageView`, and `message`.

### Bug Fixes

* Fixes an issue which prevented application archives from being submitted to the app store. The issue was caused by and unnecessary key in the `Resources/info.plist` file.
* Fixes a `UILayoutConstraint` conflict when displaying a UIMapView in the `ATLMessageBubbleView`.

## 1.0.16

### Enhancements

* Added support for installing Atlas via [Carthage](https://github.com/Carthage/Carthage).

## 1.0.15

### Bug Fixes

* Changed dependency to LayerKit v0.17.1 to pick up module import changes.

## 1.0.14

### Enhancements

* Added support for configuring the right button title in `ATLMessageInputToolbar`.

### Bug Fixes

* Fixed an issue with slow scrolling performance under iOS 9.
* Fixed build problems in Swift projects regarding non-module header imports.

## 1.0.13

### Public API Changes

* Exposed `ATLConversationViewController` method `sendMessage:` to allow custom `LYRMessage` objects to use Atlas delegate handling.
* Introduced `verticalMargin` property on `ATLMessageInputToolbar` to specify top and bottom margins for the text input view.

### Enhancements

* Improved `UIMenuController` behavior.

### Bug Fixes

* Updated the Atlas podspec that caused build errors for some users.
* Fixed an iOS9 bug with duplicate keyboards being dismissed.

## 1.0.12

### Enhancements

* Improved `UIMenuController` behavior while scrolling.
* Cached message cell height to improve scrolling performance.
* Added native video support.
* Atlas uses `LayerKit v0.17.0` which provides support for dynamic frameworks.

### Bug Fixes

* Fixed iOS9 issue with the `ATLMessageInputToolbar` having a black background when presented on screen.
* Fixed iOS9 breaking layout constraints.

## 1.0.11

### Public API Changes

* Implemented `conversationViewController:configureCell:forMessage:` to allow `ATLConversationViewController` subclasses to add extra cell configuration.
* Added `shouldDisplayAvatarItemForAuthenticatedUser` to `ATLConversationViewController` to display avatar items for the authenticated user.
* Added `ATLAvatarItemDisplayFrequency` property to `ATLConversationViewController` to allow customization of avatar frequency.
* Exposed `LYRQueryController` on `ATLConversationViewController`.
* Added `NSTextCheckingType` on `ATLMessageBubbleView`.
* Added `menuControllerActions` on `ATLMessageBubbleView` to customize UIMenuController actions.

### Enhancements

* `ATLConversationViewController` caches unsent media attachments in the `ATLMessageInputToolbar` upon deallocation, and re-inserts them on creation.
* Added Localization support.
* Asynchronous image and GIF loading in `ATLMessageCollectionViewCell`.

### Bug Fixes

* Fixed bug that caused avatar images to flicker when loading photos from remote URLs.
* Fixed bug that caused UIMenuController to stay on screen during pan gesture.
* Fixed bug that caused images to stretch if smaller than the minimum cell size.

## 1.0.10

### Bug Fixes

* Fixed bug introduced in 1.0.9 relating to media attachment text color for attributed string.

## 1.0.9

### Public API Changes

* Exposed private initializers of `ATLConversationViewController` and `ATLConversationListViewController` to allow subclassing for custom initialization.

### Bug Fixes

* Removed compiler warnings that showed from direct installation due to deprecations.

## 1.0.8

### Enhancements

* Updated change notification handling code due to LayerKit library upgrade to v0.13.3, which has some braking changes in change notifications dictionary.

## 1.0.7

### Public API Changes

* Implemented `conversationListViewController:configurationForDefaultQuery:` to provide for query customization in the `ATLConversationListViewController`.
* Implemented `conversationViewController:configurationForDefaultQuery:` to provide for query customization in the `ATLConversationViewController`.

## 1.0.6

### Bug Fixes

* Removed all compiler warnings.

## 1.0.5

### Public API Changes

* Added `avatarImageURL` property to `ATLAvatarItem`.

### Enhancements

* Added logic to fetch image from a URL to `ATLAvatarImageView`.
* Added image cache to `ATLAvatarImageView`.

### Bug Fixes

* Fixed bug which caused `ATLConversationViewController` animation assertions when attempting to reload cells via the public API.
* Fixed bug which prevented cell font customizations from being appied.

## 1.0.4

### Public API Changes

* Moved `searchController` property to public API on `ATLConversationListViewController`.
* Moved `UIImagePickerControllerDelegate` and `UINavigationControllerDelegate` declarations to header of `ATLConversationViewController`.
* Added `leftAccessoryImage`, `rightAccessoryImage` and `displaysRightAccessoryImage` to `ATLMessageInputToolbar`.

## 1.0.3

### Enhancements

* Introduced new functionality to facilitate reloading content after asynchronous reloads of user information.

### Public API Changes

* Added `reloadCellsForMessagesSentByParticipantWithIdentitifier:` to `ATLConversationViewController`.
* Removed `collectionViewCellForMessage:` from `ATLConversationViewController`.

## 1.0.2

### Public API Changes

* Added `conversationListViewController:textForButtonWithDeletionMode:` to `ATLConversationListViewController`
* Added `conversationListViewController:colorForButtonWithDeletionMode:` to `ATLConversationListViewController`

## 1.0.1

* Updated LayerKit dependency to v0.10.3
* New compatible with CocoaPods >= 0.36.0

## 1.0.0

* Initial public release of Atlas.

## 0.8.2

### Public API Changes

* Added property `blockedParticipantIdentifiers` to `ATLParticipantTableViewController`.

## 0.8.0

### Public API Changes

* Added `addressBarViewControllerDidSelectWhileDisabled:` to `ATLAddressBarViewController`.
* Changed all class prefixes from `LYRUI` to `ATL`.
* Added `conversationListViewController:didSearchForText:completion` to `ATLConversationListViewController`.

### Enhancements

* Added search functionality to the `ATLConversationListViewController`.

## 0.7.0

### Public API Changes

* Changed `setPermanent` to `disable` on  `LYRUIAddressBarViewController`.
* Changed `isPermanent` to `isDisabled` on  `LYRUIAddressBarViewController`.
* Changed `updateWithConversationLabel:` to `updateWithConversationTitle:` on `LYRUIConversationPresenting`.
* Chanded `shouldDisplayAvatarImage:` to `shouldDisplayAvatarItem:` on `LYRUIMessagePresenting`.
* `LYRUIParticipant` now inherits from the `LYRUIAvatarItem` protocol.
* Changed `presentParticipant:withSortType:shouldShowAvatarImage:` to `presentParticipant:withSortType:shouldShowAvatarItem:` on `LYRUIParticipantPresenting`
* Added `avatarItem` property to `LYRUIAvatarImageView`.
* Removed `setInitialsForFullName:`
* Changed `conversationLabelColor` to `conversationTitleLabelColor` in `LYRUIConversationCell`.
* Changed `conversationLabelFont` to `conversationTitleLabelFont` in `LYRUIConversationCell`.
* Added `conversationListViewController:didSearchWithString:completion:` to `LYRUIConversationListViewController.`

## 0.6.0

### Public API Changes

* Deprecated `LYRUIParticipantPickerController`.
* Changed `LYRUIParticipantTableViewController` initailizer to `participantTableViewControllerWithParticipants:sortType`.

### Enhancements

* Added storyboard support for `LYRUIParticipantTableViewController`.
* Added storyboard support for `LYRUIConversationViewController`.
* Added storyboard support for `LYRUIConversationListViewController`.
* `layerClient` property is no longer read only in `LYRUIConversationViewController`.
* `layerClient` property is no longer read only in `LYRUIConversationListViewController`.

## 0.5.0

### Public API Changes

* Changed `displaysConversationImage` to `displaysAvatarItem` in `LYRUIConversationListViewController.h`.
* Changed `conversationListViewController:labelForConversation:` to `conversationListViewController:titleForConversation:` in `LYRUIConversationListViewController.h`.
* Added `deletionModes` to `LYRUIConversationListViewController.h`.
* Removed `conversationTitle` property in `LYRUIConversationViewController`.
* Removed `conversationViewController:shouldMarkMessagesAsRead:`
* Added `marksMessagesAsRead` property.
* Changed `layerClient` property to be readonly.
* Changed `conversationViewControllerWithConversation:layerClient:` to `conversationViewControllerWithLayerClient:`

## 0.2.2

### Backwards Incompatibility

* `LYRUIConversationViewController` now sends mixed content (e.g. an image and text) in multiple messages, i.e. one message per piece of content (e.g. one message with an image part and another message with a text part). Correspondingly, it now displays one cell for each message. The previous behavior was to display one cell for each message part. The default message cells assume that each message only has one part. So a multi-part message (e.g. one sent with the previous behavior) will only have its first part displayed.

### Public API Changes

* Moved `LYRUIUserDidTapLinkNotification` from `LayerUIKit.h` to `LYRUIMessageBubbleView.h`.
* Added `message` property to `LYRUIConversationCollectionViewHeader`.
* Added `LYRUIConversationDataSource`.
* Changed `LYRUITypingIndicatorView` to `LYRUITypingIndicatorViewController`.
* Added `LYRUIProgressView`.
* Removed method `isGroupConversation:` from `LYRUIMessagePresenting`.
* Added `LYRUIMIMETypeImageJPEGPreview` and `LYRUIMIMETypeImageSize` to `LYRUIMessagingUtilities`.
* Added `LYRUIPhotoForLocation` to `LYRUIMessagingUtilities`.
* Changed `conversationListViewController:imageForConversation:` to `conversationListViewController:avatarItemForConversation:`.
* Added `LYRUIAvatarItem` protocol.
* Added `imageViewBackgroundColor` property to `LYRUIAvatarImageView`.
* Added `conversationViewController:messagesForContentParts:` to `LYRUIConversationViewController`.
* Removed `conversationViewController:pushNotificationTextForMessagePart:` from `LYRUIConversationViewController`.
* Removed `avatarImageViewCornerRadius` property from `LYRUIMessageCollectionViewCell`.
* Added `avatarImageViewDiameter` property to `LYRUIAvatarImageView`.
* Removed `updateWithMessageSentState:` method from `LYRUIMessagePresenting`. Message sent state can be inferred from the `isSent` property on `LYRMessage`.
* Added `LYRUIUserDidTapLinkNotification` to `LayerUIKit`.
* Added `collectionViewCellForMessage:` to `LYRUIConversationViewController`.
* Added `bubbleViewCornerRadius` property to `LYRUIMessageCollectionViewCell`.  
* Added `avatarImageViewCornerRadius` property to `LYRUIMessageCollectionViewCell`.
* Changed `backgroundColor` property to `cellBackgroundColor` on `LYRUIConversationTableViewCell`.
* Removed `updateWithBubbleViewWidth:` from `LYRUIMessageCollectionViewCell`.
* Changed `-[<LYRUIConversationViewControllerDataSource> conversationViewController:pushNotificationTextForMessageParts:]` to `conversationViewController:pushNotificationTextForMessagePart:`. That is, one message part is passed instead of an array of message parts.
* Changed `-[<LYRUIMessagePresenting> presentMessagePart:]` to `presentMessage:`. That is, a message is passed instead of a message part.
* Added `isPermanent` to `LYRUIAddressBarViewController`.
* Changed `-[<LYRUIAddressBarControllerDataSource> searchForParticipantsMatchingText:completion:]` to `addressBarViewController:searchForParticipantsMatchingText:completion:`. That is, the view controller is now passed as the first parameter. This callback also now controls the order of search results by providing an `NSArray` instead of an `NSSet` in the completion block.
* Changed `-[LYRUIMessageInputToolbarDelegate messageInputToolbarDidBeginTyping:]` to `messageInputToolbarDidType:`.
* `-[LYRUIMessageInputToolbar insertLocation:]` has been removed since it was unused.
* Removed `maxHeight` property from `LYRUIMessageComposeTextView`. Use the `maxNumberOfLines` property of `LYRUIMessageInputToolbar` instead.
* Removed `-[LYRUIMessageComposeTextView insertImage:]`. Use `-[LYRUIMessageInputToolbar insertImage:]` instead.
* Removed `-[LYRUIMessageComposeTextView removeAttachements]`. It doesn't have a replacement since it was meant for internal use only.
* Changed `placeHolderText` property of `LYRUIMessageComposeTextView` to `placeholder`.
* Removed `pendingBubbleViewColor` property of `LYRUIMessageCollectionViewCell`.
* Changed `avatarImage` property of `LYRUIMessageCollectionViewCell` to `avatarImageView`.
* Removed `initialViewBackgroundColor` property of `LYRUIAvatarImageView`. Use `backgroundColor` instead.
* Changed `initialFont` property of `LYRUIAvatarImageView` to `initialsFont`.
* Changed `initialColor` property of `LYRUIAvatarImageView` to `initialsColor`.
* Changed `-[<LYRUIParticipantPickerControllerDelegate> participantSelectionViewControllerDidCancel:]` to `participantPickerControllerDidCancel:`.
* Changed `-[<LYRUIParticipantPickerControllerDelegate> participantSelectionViewController:didSelectParticipant:]` to `participantPickerController:didSelectParticipant:`.
* Changed `-[<LYRUIParticipantPickerDataSource> searchForParticipantsMatchingText:completion:]` to `participantPickerController:searchForParticipantsMatchingText:completion:`.
* Changed `-[<LYRUIParticipantPickerDataSource> participants]` to `participantsForParticipantPickerController:`.
* Changed `-[<LYRUIParticipantTableViewControllerDelegate> participantTableViewControllerDidSelectCancelButton]` to `participantTableViewControllerDidCancel:`.
* Removed `selectionIndicator` property from `LYRUIParticipantTableViewController`.
* Added `participantPickerController:didDeselectParticipant:` to `LYRUIParticipantPickerControllerDelegate`.
* Added `participantTableViewController:didDeselectParticipant:` to `LYRUIParticipantTableViewControllerDelegate`.
* Replaced `presentParticipant:`, `updateWithSortType:` and `shouldShowAvatarImage:` on `LYRUIParticipantPresenting` with `presentParticipant:withSortType:shouldShowAvatarImage:`.
* Changed `LYRUIParticipantPickerControllerSortTypeFirst` to `LYRUIParticipantPickerSortTypeFirstName`.
* Changed `LYRUIParticipantPickerControllerSortTypeLast` to `LYRUIParticipantPickerSortTypeLastName`.
* Changed `LYRUIPaticipantSectionHeaderView` to `LYRUIParticipantSectionHeaderView`.
* Removed `initWithKey:` from `LYRUIParticipantSectionHeaderView`.
* Changed `keyLabel` property to `nameLabel` on `LYRUIParticipantSectionHeaderView`.
* Removed `conversationListViewController:didSearchWithString:completion:` from `LYRUIConversationListViewControllerDataSource`.
* Changed `layerClient` property on `LYRUIConversationListViewController` from `readwrite` to `readonly`.
* Changed `lastMessageTextFont` property on `LYRUIConversationTableViewCell` to `lastMessageLabelFont`.
* Changed `lastMessageTextColor` property on `LYRUIConversationTableViewCell` to `lastMessageLabelColor`.
* Added optional `conversationViewController:conversationWithParticipants:` method to `LYRUIConversationViewControllerDataSource`.
* Changed `selectedParticipants` property on `LYRUIAddressBarViewController` from a `readonly` `NSSet` to a `readwrite` `NSOrderedSet`.

### Bug Fixes

* Fixed bug which allowed name labels to be truncated in `LYRUIParticipantTableViewCell`.
* Fixed bug which would display an empty name string if the `fullName` property of `LYRUIParticipant` was nil in `LYRUIParticipantTableViewCell`.
* Fixed bug which would display inaccurate initials if the `fullName` property of `LYRUIParticipant` was nil in `LYRUIParticipantTableViewCell`.
* Fixed bug which allowed messages to be marked as read while app is in the background.
* Removed duplicate MIMEType constant declarations.
* Fixed possibility of customizations via `UIAppearance` being overridden.
* Fixed issue related to sending a push notification with `(null)` text.
* Fixed typo for property `conversationLabelColor` on `LYRUIConversationTableViewCell`.
* Fixed typo in C function signature `LYRUILightGrayColor()`.
* Added logic to guard against messages with external content in applications using LayerKit v0.9.2 and previous.

### Enhancements

* `LYRUIAddressBarViewController` now shows only first names when set permanent.
* Implemented progress view in `LYRUIBubbleView`.
* Implemented pagination in the `LYRUIConversationViewController`.
* `LYRUIConversationTableViewCell` no longer shows conversation image by default.
* Implemented `LayerUIKit` unit test suite.
* Re-implemented `LayerUIKit` mock objects.
* Re-factored `LayerUIKit` sample app to use new mock objects.
* Refactored internal constants.
* Added support for external content.
