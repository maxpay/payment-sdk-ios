# Maxpay Payment iOS SDK

The Maxpay Payment iOS SDK makes it quick and easy to build a payment screen in your iOS app. We provide customizable MXPPaymentViewController that can be used out-of-the-box.

## Content
* [Requirements](#requirements)
* [Installation](#installation)
* [Integration prebuilt UI](#integration-prebuilt-ui)


## Requirements
ios10, Xcode11, Swift 4.

## Installation
### 1. Clone or download repository.

### 2. Open downloaded project, you should see folders with example, framework binary and source files.
![Downloaded project](README/downloaded_project.png)

### 3. Create or open Xcode iOS project which will use framework.
![New project](README/new_project.png)

### 4. Select binary file.
![Binary file](README/select_project.png)

### 5. In Xcode project create new group, name it "Frameworks" for example.
![New group](README/new_group.png)

### 5. Drag and drom MaxpayPaymentSdk.frameworks to your project. Do not forget set checkmark to copy files.
![Import library in classes](README/drag_and_drop.png)
![Select 'Copy items if needed'](README/copy_if_needed.png)
![Copied files](README/copied_files.png)

### 6. Now import MaxpayPaymentSdk in source file and you will get access to all public objects from framework.
![Import library in classes](README/import_library_in_classes.png)

## Integration prebuilt UI
[How to use prebuilt UI see here](README/INTEGRATION.md).
