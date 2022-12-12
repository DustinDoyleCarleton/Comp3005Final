
-- Delete all tables if they exist before rebuilding them
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Owner;
DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Author;
DROP TABLE IF EXISTS Genre;
DROP TABLE IF EXISTS Publisher;
DROP TABLE IF EXISTS Publish;
DROP TABLE IF EXISTS Phone_number;
DROP TABLE IF EXISTS BookOrder;
DROP TABLE IF EXISTS Contains;
DROP TABLE IF EXISTS Report;
DROP TABLE IF EXISTS Update_Report;
DROP TABLE IF EXISTS Sales_per_genre;
DROP TABLE IF EXISTS Sales_per_author;
DROP TABLE IF EXISTS Sales_per_publisher;
DROP TABLE IF EXISTS View_Report;
DROP TABLE IF EXISTS View_Publisher;
DROP TABLE IF EXISTS Add_Book;
DROP TABLE IF EXISTS Remove_Book;
DROP TABLE IF EXISTS Track;
DROP TABLE IF EXISTS Cart;
DROP TABLE IF EXISTS Cart_orders;
DROP TABLE IF EXISTS Search;
DROP TABLE IF EXISTS Search_parameters;

-- Create the various Tables needed to form our database
CREATE TABLE User (
   number INTEGER NOT NULL PRIMARY KEY,
   fName TEXT NOT NULL,
   lName TEXT NOT NULL,
   billing TEXT NOT NULL,
   shipping TEXT NOT NULL,
   password TEXT NOT NULL, 
   type TEXT
);

CREATE TABLE Owner (
    fName TEXT NOT NULL, 
    lName TEXT NOT NULL, 
    password TEXT NOT NULL,
    PRIMARY KEY (fName, lName)
);

CREATE TABLE Book (
    ISBN INTEGER NOT NULL PRIMARY KEY,
    sales_percent DECIMAL(10,2) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    title TEXT NOT NULL,
    number_of_pages INTEGER NOT NULL
);

CREATE TABLE Author (
    ISBN INTEGER NOT NULL,
    author_name TEXT NOT NULL,
    PRIMARY KEY (ISBN, author_name),
    FOREIGN KEY (ISBN) REFERENCES Book(ISBN)
);

CREATE TABLE Genre (
    ISBN INTEGER NOT NULL,
    genre TEXT NOT NULL,
    PRIMARY KEY (ISBN, genre),
    FOREIGN KEY (ISBN) REFERENCES Book(ISBN)
);

CREATE TABLE Publisher (
   name TEXT NOT NULL PRIMARY KEY,
   banking_account TEXT NOT NULL,
   address TEXT NOT NULL,
   email TEXT NOT NULL
);

CREATE TABLE Publish (
    ISBN INTEGER NOT NULL,
    publisher_name TEXT NOT NULL,
    PRIMARY KEY (ISBN, publisher_name),
    FOREIGN KEY (ISBN) REFERENCES Book(ISBN),
    FOREIGN KEY (publisher_name) REFERENCES Publisher(name)
);

CREATE TABLE Phone_number (
    phone_number INTEGER NOT NULL,
    publisher_name TEXT NOT NULL,
    PRIMARY KEY (phone_number, publisher_name),
    FOREIGN KEY (publisher_name) REFERENCES Publisher(name)
);

CREATE TABLE BookOrder (
    number INTEGER NOT NULL,
    current_location TEXT DEFAULT "BooksOrUs" NOT NULL, 
    current_shipping_service TEXT DEFAULT "BooksOrUs Prime Delivery" NOT NULL, 
    expected_ship_date TEXT DEFAULT "Today" NOT NULL, 
    actual_ship_date TEXT DEFAULT "Unknown at this time" NOT NULL, 
    status TEXT DEFAULT "Order Received" NOT NULL, 
    user_number INTEGER NOT NULL, 
    billing TEXT NOT NULL, 
    shipping TEXT NOT NULL,
    PRIMARY KEY (number),
    FOREIGN KEY (user_number) REFERENCES User(number)
);

CREATE TABLE Contains (
    order_number INTEGER NOT NULL,
    ISBN INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    PRIMARY KEY (order_number, ISBN),
    FOREIGN KEY (ISBN) REFERENCES Book(ISBN),
    FOREIGN KEY (order_number) REFERENCES BookOrder(number)
);

CREATE TABLE Report (
    sales_period TEXT NOT NULL,
    sales DECIMAL(10,2) NOT NULL,
    expenditures DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (sales_period)
);

CREATE TABLE Update_Report (
    order_number INTEGER NOT NULL,
    report_sales_period TEXT NOT NULL,
    PRIMARY KEY (order_number, report_sales_period),
    FOREIGN KEY (report_sales_period) REFERENCES Report(sales_period),
    FOREIGN KEY (order_number) REFERENCES BookOrder(number)
);

CREATE TABLE Sales_per_genre (
    sales_per_genre DECIMAL(10,2) NOT NULL,
    report_sales_period TEXT NOT NULL,
    genre TEXT NOT NULL,
    PRIMARY KEY (report_sales_period, genre),
    FOREIGN KEY (report_sales_period) REFERENCES Report(sales_period)
);

CREATE TABLE Sales_per_author (
    sales_per_author DECIMAL(10,2) NOT NULL,
    report_sales_period TEXT NOT NULL,
    author TEXT NOT NULL,
    PRIMARY KEY (report_sales_period, author),
    FOREIGN KEY (report_sales_period) REFERENCES Report(sales_period)
);

CREATE TABLE Sales_per_publisher (
    sales_per_publisher DECIMAL(10,2) NOT NULL,
    report_sales_period TEXT NOT NULL,
    publisher TEXT NOT NULL,
    PRIMARY KEY (report_sales_period, publisher),
    FOREIGN KEY (report_sales_period) REFERENCES Report(sales_period)
);

CREATE TABLE View_Report (
    report_sales_period TEXT NOT NULL,
    fName TEXT NOT NULL, 
    lName TEXT NOT NULL, 
    password TEXT NOT NULL,
    PRIMARY KEY (fName, lName, report_sales_period),
    FOREIGN KEY (fName) REFERENCES Owner(fName),
    FOREIGN KEY (lName) REFERENCES Owner(lName),
    FOREIGN KEY (report_sales_period) REFERENCES Report(sales_period)
);

CREATE TABLE View_Publisher (
    publisher_name TEXT NOT NULL,
    fName TEXT NOT NULL, 
    lName TEXT NOT NULL, 
    password TEXT NOT NULL,
    PRIMARY KEY (fName, lName, publisher_name),
    FOREIGN KEY (fName) REFERENCES Owner(fName),
    FOREIGN KEY (lName) REFERENCES Owner(lName),
    FOREIGN KEY (publisher_name) REFERENCES Publisher(name)
);

CREATE TABLE Add_Book (
    ISBN INTEGER NOT NULL,
    fName TEXT NOT NULL, 
    lName TEXT NOT NULL,
    PRIMARY KEY (ISBN),
    FOREIGN KEY (ISBN) REFERENCES Book(ISBN),
    FOREIGN KEY (fName) REFERENCES Owner(fName),
    FOREIGN KEY (lName) REFERENCES Owner(lName)
);

CREATE TABLE Remove_Book (
    ISBN INTEGER NOT NULL,
    fName TEXT NOT NULL, 
    lName TEXT NOT NULL,
    PRIMARY KEY (ISBN),
    FOREIGN KEY (ISBN) REFERENCES Book(ISBN),
    FOREIGN KEY (fName) REFERENCES Owner(fName),
    FOREIGN KEY (lName) REFERENCES Owner(lName)
);

CREATE TABLE Track (
    order_number INTEGER NOT NULL,
    user_number INTEGER NOT NULL,
    user_input INTEGER NOT NULL,
    PRIMARY KEY (order_number),
    FOREIGN KEY (user_number) REFERENCES User(number),
    FOREIGN KEY (order_number) REFERENCES BookOrder(number)
);

CREATE TABLE Cart (
    user_number INTEGER NOT NULL,
    PRIMARY KEY (user_number),
    FOREIGN KEY (user_number) REFERENCES User(number)
);

CREATE TABLE Cart_orders (
    user_number INTEGER NOT NULL,
    ISBN INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    PRIMARY KEY (user_number, ISBN, quantity),
    FOREIGN KEY (user_number) REFERENCES User(number)
);

CREATE TABLE Search (
    user_number INTEGER NOT NULL,
    ISBN INTEGER NOT NULL,
    PRIMARY KEY (user_number, ISBN),
    FOREIGN KEY (user_number) REFERENCES User(number),
    FOREIGN KEY (ISBN) REFERENCES Book(ISBN)
);

CREATE TABLE Search_parameters (
    user_number INTEGER NOT NULL,
    ISBN INTEGER NOT NULL,
    search_parameters TEXT NOT NULL,
    PRIMARY KEY (user_number, ISBN, search_parameters),
    FOREIGN KEY (user_number) REFERENCES User(number),
    FOREIGN KEY (ISBN) REFERENCES Book(ISBN)
);
