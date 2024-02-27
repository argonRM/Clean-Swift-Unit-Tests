# About
This is a mini-project that implements a weather forecast iOS application. The project's goal is to choose a convenient architecture for unit testing. In my opinion, one of the most convenient architectures is Clean Swift. By downloading the project, you can see a practical example of how to test an iOS application.

# Clean Swit
In the picture, you can see the schematic of the Clean Swift architecture, which is obviously different from another Clean architecture, VIPER, although it is similar to it. The main difference is that the dependency between the Interactor, Presenter, and ViewController is circular, unlike in VIPER, where the Presenter is at the center and has direct and reverse connections with the ViewController and Interactor. In my opinion, Clean Swift makes the code much more simple to understand and test.
![Group 21](https://github.com/argonRM/TheWeatherExample/assets/39482176/4cb58c08-9aae-4ea0-aa51-d73efedd5de9)

All objects are owned by each other through protocols. This makes testing very easy. For example, when testing the presenter, you can replace the Interactor with a mock object and the ViewController with a spy object.
### Interactor
<img width="435" alt="Screenshot 2024-02-27 at 11 01 49 PM" src="https://github.com/argonRM/TheWeatherExample/assets/39482176/f70d0bd8-f8dc-4dae-898e-2f11d62e0a41">

### Presenter
<img width="766" alt="Screenshot 2024-02-27 at 11 02 07 PM" src="https://github.com/argonRM/TheWeatherExample/assets/39482176/1f41da6c-1d49-4cb6-928c-78f4e5ac7c9b">

### ViewController
<img width="440" alt="Screenshot 2024-02-27 at 11 02 19 PM" src="https://github.com/argonRM/TheWeatherExample/assets/39482176/a98d7328-669e-4faa-87f4-bcb697a8c449">
