### StackOverflow

App will fetch list of top 20 users from StackOverflow and list in a table view.

- Implemented using MVP-Coordinator pattern.
- Images are cached using native code.
- Tests are written for core network services, presenter and coordinator.
- Mocks and tests for views are not implemented.
- UI can be more polished, but all functionality has been built in. (Follow, Unfollow, Block, Unblock, and Expansion)

No third party frameworks are used.

Inorder to keep it simple, Coordinator is loaded with view from Storyboard.
Coordinator contains business and navigation logic(not required in this sample app), and also perform dependency injections.
Presenter acts as interface between Coordinator and View, while keeping the modules independent.
Since View was implemented using protocol, presenter is not coupled with a concrete ViewController.

Since follow/block is locally simulated; Presenter handles the model updates.
If there was a network call, this duty would have been delegated to coordinator.
