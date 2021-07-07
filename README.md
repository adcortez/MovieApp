# Description of MovieApp

I used MVC and MVVM architectural pattern in order to create the app.

The networking is ApiService.swift here I perform the calls to the API.

The app is based in Storyboard, the ViewControllers that interact with this storyboard are PopularViewController, TopReatedViewController and UpcomingViewController 
through the MovieViewModel, the DetailsViewControlles interact directly with the Model.

The MovieViewModel is responsable to get the movie data and update the table views of Popular, TopRated and Upcoming controllers

The PopularViewController is responsable to interact with the view of Popular Movies
The TopRatedViewController is responsable to interact with the view of TopRated Movies
The UpcomingViewController is responsable to interact with the view of Upcoming Movies

The DetailsViewController is responsable to interact with the view of the movie details.

The Movie.swift is the Model to create new movies.

The ApiServiceUnitTest.swift is responsable to perform some test of the app.

*****ANSWERS*******

Single responsibility:

Is part of the SOLID acronym:
•	S (SRP): Single responsibility principle - A class should have just one reason to change. In other words should have just one responsability. 
For Example: class that creates user shouldn’t have the responsibility to encrypt the password. 

Clean Code:

For me a clean code should be easy to read, with good comments, apply the SOLID principles, also maintainable





