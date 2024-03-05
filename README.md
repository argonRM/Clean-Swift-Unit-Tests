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

## Unit tests
If we look at the example of testing the Interactor, here I use a certain mock object of a provider, which instead of going to the internet, takes a pre-written JSON file, simulating an internet request. It also takes a hardcoded user location.

<img width="1062" alt="Screenshot 2024-02-27 at 11 58 05 PM" src="https://github.com/argonRM/TheWeatherExample/assets/39482176/f176b83c-78e3-4d72-9ac1-488ae63f32ae">

I also use a so-called spy object instead of the presenter, which implements WeatherPresentationLogic. This object does not take any active actions but simply stores the received result. Based on this result, we can understand if it corresponds to the expected one. This is the essence of the test.

<img width="476" alt="Screenshot 2024-02-27 at 11 58 14 PM" src="https://github.com/argonRM/TheWeatherExample/assets/39482176/330934bc-8a9e-4658-9031-1ee995503cda">

Here you can see an example of unit tests for the interactor, specifically the test method for getting weather data. Using comments, I've divided the test function in
to logical parts.

<img width="727" alt="Screenshot 2024-02-28 at 12 00 43 AM" src="https://github.com/argonRM/TheWeatherExample/assets/39482176/525fb39e-c942-48e2-81f9-6bbcc8ab98a3">

### Given-When-Then
Given-When-Then (GWT) is an approach to structuring automated tests. Each part of the structure serves a specific purpose:

Given: Defines the initial state of the system or the preconditions necessary for the test to run. This may include setting certain values, creating objects, or any preparatory work.

When: Describes the event or action that causes a change in the system's state. This could be calling a method or interacting with the system in some other way.

Then: Checks the expected outcome after the event or action has occurred. This is where assertions are made to ensure that the system behaves as expected.

Using GWT helps improve understanding of test scenarios and makes them easier to maintain and extend.

### Сonclusion
For a more detailed understanding of the Clean Swift architecture and unit tests for this architecture, you can download this project and see how everything fits together.

## Developed By
Roman Maiboroda

## License
Copyright 2024 Roman Maiboroda.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
