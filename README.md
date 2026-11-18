<img width="1526" height="890" alt="image" src="https://github.com/user-attachments/assets/64430815-421b-4572-9d9b-1dfc22f4a28c" />

<div align="center">

# 📓 Journali

### ✨ Your Thoughts, Your Story.

*A little space for your thoughts, a beautiful place for your memories.*

**Swift · SwiftUI · SwiftData · MVVM · Sketch**

---

**Write it. Save it. Remember it. 💜**

</div>

## 💜 About Journali

Every thought matters. Every memory tells a story.

**Journali** is a personal iOS journaling app that provides a simple and comfortable space to capture thoughts, experiences, and special moments.

With a minimal dark interface and easy-to-use features, Journali helps users write, organize, and revisit their memories anytime.

---

## ✨ Main Features

### 📝 Create Journal Entries
- Create personal journal entries.
- Write a title, content, or both.
- Automatically use "Untitled Journal" when no title is provided.
- Save the date of each entry.

### 📖 View & Edit Journals
- Display saved journals in organized cards.
- View journal titles, dates, and content previews.
- Open and edit existing entries.
- Show a confirmation before discarding unsaved changes.

### 🔖 Bookmark Journals
- Bookmark favorite or important journal entries.
- Remove bookmarks whenever needed.
- Easily recognize bookmarked entries.

### 🔍 Search Journals
- Search journals by title or content.
- Find matching entries quickly.
- Update search results as the user types.

### ↕️ Sort Journals
- **Sort by Entry Date:** Display the newest entries first.
- **Sort by Bookmark:** Display bookmarked entries first.

### 🗑️ Delete Journals
- Swipe left on a journal card to reveal the Delete button.
- Display a confirmation alert before deletion.
- Allow users to cancel or confirm.
- Update the journal list after deletion.

### 🌙 Dark Mode
- Consistent dark appearance across the app.
- Custom gradient Splash Screen.
- Purple accents and rounded journal cards.
- Native iOS controls and interactions.

### 💾 Local Data Persistence
- Store journal entries locally using SwiftData.
- Keep entries after closing and reopening the app.
- Save changes to existing entries.

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Swift | Programming language |
| SwiftUI | Building the user interface |
| SwiftData | Saving and managing local data |
| Combine | Observing data changes |
| MVVM | Organizing the app architecture |
| Xcode | Development and testing |
| Sketch | UI/UX design |
| SF Symbols | Native Apple icons |

---

## 🏗️ Architecture — MVVM

Journali follows the **Model–View–ViewModel (MVVM)** architecture to separate the user interface, application logic, and data.

### Model
The Model represents the journal data.

Each journal contains:
- Title
- Content
- Date
- Bookmark status

### View
The View displays the interface and handles user interactions.

Main Views:
- `ContentView`
- `EmptyStateView`
- `NewJournalView`

### ViewModel
The ViewModel manages the application logic.

Its responsibilities include:
- Loading saved journals.
- Validating user input.
- Creating and editing journals.
- Managing bookmarks.
- Searching and sorting entries.
- Deleting journals.
- Handling saving errors.

### Application Flow

    User Interaction
           |
           v
       SwiftUI View
           |
           v
        ViewModel
           |
           v
       ModelContext
           |
           v
     SwiftData Storage
           |
           v
       Journal Model

---

## 📁 Project Structure

    Journali/
    |
    |-- JournaliApp.swift
    |   App entry point and SwiftData setup
    |
    |-- ContentView.swift
    |   Splash Screen
    |
    |-- Journal.swift
    |   Journal data model
    |
    |-- EmptyStateView.swift
    |   Home Screen and journal cards
    |
    |-- EmptyStateViewModel.swift
    |   Loading, searching, sorting,
    |   bookmarking, and deleting journals
    |
    |-- NewJournalView.swift
    |   Create and edit journal screen
    |
    |-- NewJournalViewModel.swift
    |   Input validation and saving logic
    |
    |-- Assets.xcassets
        Images and visual assets

---

## 🎯 User Stories

### Create Journal
As a user, I want to create a new journal entry so that I can write my thoughts and experiences.

### Edit Journal
As a user, I want to edit an existing journal entry so that I can update or correct my thoughts.

### Delete Journal
As a user, I want to delete a journal entry so that I can remove memories I no longer want to keep.

### Search Journals
As a user, I want to search for specific words or phrases so that I can quickly find relevant thoughts or memories.

### Bookmark Journals
As a user, I want to bookmark important journal entries so that I can easily find them later.

### Sort Journals
As a user, I want to sort my journal entries by date or bookmark status so that I can easily find my newest or most important entries.

---

## 🧭 User Flow

### 01 — Create a Journal

Open App → Home Screen → Tap + → Write Entry → Save → Home Screen

### 02 — Edit a Journal

Open Journal → Edit Title or Content → Save Changes

If there are unsaved changes, the user can choose to discard them or continue editing.

### 03 — Search & Organize

Home Screen → Search Journals → Bookmark Entries → Sort by Date or Bookmark

### 04 — Delete a Journal

Home Screen → Swipe Left → Delete → Confirmation Alert → Updated Journal List

---

## 🚀 Getting Started

### Requirements

- A Mac with Xcode installed.
- An iPhone simulator or compatible iOS device.
- An Xcode version supporting SwiftUI and SwiftData.

### Installation

1. Download or clone the repository.
2. Open the Journali project in Xcode.
3. Select an iPhone simulator.
4. Build and run the app using `Command + R`.

### How to Use

1. Launch Journali.
2. Tap the `+` button to create a journal.
3. Enter a title, content, or both.
4. Tap the checkmark to save.
5. Tap an existing journal to edit it.
6. Use Search, Bookmark, and Sort to organize entries.
7. Swipe left to delete a journal with confirmation.

---

## 🎓 What I Learned

Building Journali helped me develop my iOS programming skills and understand how to transform a design into a functional application.

### SwiftUI Layout
- Using `VStack`, `HStack`, and `ZStack`.
- Building interfaces with `Text`, `Image`, and `List`.
- Creating backgrounds using `LinearGradient`.
- Working with Assets and SF Symbols.

### Navigation
- Using `NavigationStack`.
- Creating native toolbars.
- Presenting screens with Sheets.
- Managing screen presentation and dismissal.

### State Management
- Using `@State` for local interface state.
- Using `@StateObject` to manage ViewModels.
- Using `@Published` to notify Views about changes.
- Understanding Binding.
- Using `@FocusState` for keyboard focus.

### MVVM Architecture
- Separating interface code from application logic.
- Creating Models and ViewModels.
- Connecting Views with ViewModels.

### Data Management
- Using SwiftData for local persistence.
- Creating a data model with `@Model`.
- Using `ModelContext`.
- Inserting, fetching, updating, and deleting data.
- Handling errors with `do-catch`.

### Journal Features
- Implementing search with `filter()`.
- Sorting entries using `sorted()`.
- Managing bookmarks with `toggle()`.
- Creating native swipe actions.
- Building confirmation alerts.
- Validating user input before saving.

### User Experience
- Designing an Empty State.
- Handling unsaved changes.
- Maintaining a consistent Dark Mode.
- Using native iOS components.
- Testing features in the Xcode simulator.

---

## 🎨 Design Philosophy

### Simple. Personal. Distraction-Free.

Journali was designed with **Sketch** and implemented using SwiftUI.

The design focuses on:
- A minimal and clean interface.
- Consistent dark colors.
- Soft purple highlights.
- Easy navigation.
- Clear typography.
- A comfortable journaling experience.

The goal is to make writing feel simple, natural, and enjoyable.

---

## 📸 Screenshots

Screenshots of the following screens can be added here:

- Splash Screen
- Empty State
- Main Page
- New Journal
- Edit Journal
- Delete Confirmation

---

## 🔮 Future Improvements

Possible improvements for future versions include:

- Adding photos to journal entries.
- Creating custom journal categories.
- Supporting additional themes.
- Adding more personalization options.

These features are ideas for future development and are not included in the current version.

---

<div align="center">

## 💜 Journali

### Every day has a story worth remembering.

**Your Thoughts, Your Story.**

*Made with SwiftUI and 💜*

</div>
