## About
This is a mini-project that implements a weather forecast iOS application. The project's goal is to choose a convenient architecture for unit testing. In my opinion, one of the most convenient architectures is Clean Swift. By downloading the project, you can see a practical example of how to test an iOS application.

## Clean Swit
In the picture, you can see the schematic of the Clean Swift architecture, which is obviously different from another Clean architecture, VIPER, although it is similar to it. The main difference is that the dependency between the Interactor, Presenter, and ViewController is circular, unlike in VIPER, where the Presenter is at the center and has direct and reverse connections with the ViewController and Interactor. In my opinion, this makes the code much more complex to understand and test.

![Group 18](https://github.com/argonRM/TheWeatherExample/assets/39482176/5a9c87b7-bdb7-4d08-9ab6-301b3e867975)
