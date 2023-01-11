# card_maximizer

Summary:
The App recognize your location and based on that it will tell you what is the best credit card to use in that specific store.
The choice of the credit card is based on the rewards you will get using one specific card. 
The most valueble reward (cashback/points) will be the main factor which will determine what card the app will suggest the user.
For example, if our location understands that we are inside a restaurant it will suggest us to use, among the credit cards we previously inserted, which card has the highest cashback.
In this way we will always maximize how much money we are getting back.


Before Running:
1) Needs to install CocoaPod. Go with the terminal and run:
    a) sudo gem install cocoapods
    b) cd <path-to-project>
    c) pod install
    
2) Open project from the file with the extension "xcworkspace" and NOT "xcodeproj"

3) For security reasons the API keys have been removed, hence you should use your own "Places API".
    a) You can find out how to get your own API keys from here: https://developers.google.com/maps/documentation/places/ios-sdk/get-api-key
    b) Once you have your own "Places API" key:
        - Go to AppDelegate.swift 
        - Look in the first function for the line: GMSPlacesClient.provideAPIKey("YOUR_API_KEY")
        - Change "YOUR_API_KEY" with your own API
        
4) For extra security, the Place APIs used are restricted. You can request up to 3 API calls per minute and no more than 100 per day.

