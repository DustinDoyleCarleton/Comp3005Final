Note: This code is based on comp2406's tutorial 9 materials and answers by the professor Louis Nel
Dustin Doyle
Student Number: 101167317
Operating System: Windows 10 Home, Version 21H2
Install modules using "npm install" in the terminal inside of the answer_code\ServerWithSQLiteDatabase.
In other words the same place as server.js
Also it should be noted we need to make use of node to run server.js.
Thus Steps:
1. npm install inside the same folder as server.js
2. run bookstore.sql found inside of the data folder this will create our bookstore.db. 
3. run node .\server.js to start up the server.
4. Follow the links generated in the terminal which will send you to the correct webpages.
5. 		console.log('http://localhost:3000/addToCart?ISBN=42069&quantity=25')
		console.log('http://localhost:3000/index.html')
		console.log('http://localhost:3000/users')
		console.log('http://localhost:3000/checkoutCart?billing=ScamBank&shipping=ScamMeStreet')
		console.log('http://localhost:3000/books?title=Haha')
		console.log('http://localhost:3000/removeBook?title=Haha')
		console.log('http://localhost:3000/addBook?title=newBook&ISBN=100001&sales_percent=24&price=15.99&number_of_pages=39')
		console.log('http://localhost:3000/book/42069')
		console.log('http://localhost:3000/viewReports')
        These query's work for any book even the ones you create, thus if you add a book with ISBN that 12345, then doing http://localhost:3000/book/12345 will show you that book in detail, and if you do http://localhost:3000/removeBook?ISBN=12345' it will be removed.
6. I did this all in vscode and used the extension for sqlite to show databases and run my .sql file. Thus if running this via another method your results may vary.
