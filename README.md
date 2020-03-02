### StackOverflow

App will fetch list of top 20 user from StackOverflow and list in a table view.

- Implemented using MVP-Coordinator pattern.
- Images are cached using native code.
- Tests are written for core network services and presenters and coordinator.
- Mocks and tests for views are not implemented.
- UI can be more polished, but all functionality is built in. (Follow, Unfollow, Block, Unblock, and Expansion)

No third party frameworks are used.

Inorder to keep it simple, Coordinator is loaded with view from Storyboard.
Coordinator contains business and navigation logic(not required in this sample app), and also perform dependency injections.
Presenter acts as interface between Coordinator and View and keep the modules independent.
Since View is implemented using protocol, presenter is not coupled with a concrete ViewController.

Since for follow/block is locally simulated, Presenter handles the model updation.
If there was a network call, this duty would have been delegated to coordinator.
