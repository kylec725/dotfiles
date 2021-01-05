# New Developer's Guide - AFFORDABLE Backend

This document is intended to introduce information relevant to AFFORDABLE backend developers about design decisions made and how to extend the existing codebase.

## TypeScript

The entire backend has been rewritten in [TypeScript](https://www.typescriptlang.org/). If you are familiar with JavaScript, it may be helpful to know that TypeScript is a superset of JavaScript (_i.e._ all syntactically correct JavaScript is syntactically correct TypeScript).

At all times, it is strongly recommended to take advantage of the type system provided by TypeScript. Using typings will provide the following benefits
* Compile-time static checking, preventing bugs that would otherwise not be caught until runtime
* Autocompletion benefits for IDEs is dramatically improved
* It will often force you to think critically about the conceptual implications of your design

## n-tier architecture

The AFFORDABLE backend is designed with a four-tier architecture. Each tier is designed to simplify logic in any individual part of the codebase and imply a separation of concerns. These tiers from top to bottom are:

* Router
* Controller
* Services
* Data Access

This is a common pattern in web applications that have many responsibilities (like Affordable). In other applications you may occasionally see the router and controller layers merged into one. Importantly, these layers have their own responsibilities, and it's important that these responsibilities are preserved.

For an example of how to extend Affordable within this architecture, see the [New Service Example guide](./NewServiceExample.md).

### Router and Controller

These two components are often rolled into one in some architectures, so we'll talk about them both here. Both of these layers deal with how your application interacts with web requests coming from outside of your application.

The router layer is where the REST API is defined. The logic in this layer "routes" HTTP requests to the correct method in the controller layer. In all circumstances, this layer will only need to interact with controllers. In these files, you will notice extensive comments formatted for [apiDocJS](https://apidocjs.com/). If formatted correctly, the documentation for the endpoints will be translated into an easy-to-read API documentation page with `yarn generate-docs`.

Controllers handle converting the HTTP request object into the data object(s) needed for the service layer to complete its tasks. The controller also takes the response from the service layer and converts it into an appropriate HTTP response.

In Affordable, both the routes and controller layers utilize [Express](https://expressjs.com/). It's important to understand how Express works before attempting to change routes, controllers, and middleware.

It's also important to think about [how to design a REST API](https://stackoverflow.blog/2020/03/02/best-practices-for-rest-api-design/). Keep in mind that while the code snippets in the linked resource can be illustrative about how to design an API in Express, they **don't** follow our architecture.

### Services

Services are the intended location of domain/business logic. In this layer, you would expect to see object validation, authorization checks, and any logic that is specific to the functional goals of the AFFORDABLE application. In this layer, you can expect to utilize the data access layer, as well as other services (but be careful to avoid cyclic dependencies).

It can sometimes be more useful to explain what you don't see in the service layer. In the service layer, you will not be 

* Handling the HTTP request or response objects (this is the job of the controller)
* Directly accessing or saving data via a SQL query or ORM library (this should be in the data access layer, explained next)

### Data Access

The data access layer handles any type of database calls, such as creating/reading/updating/deleting database objects.

This is where you should be putting SQL queries, or using [TypeORM](typeorm.io), which is a tool that manages converting TypeScript/JavaScript objects into SQL relations . Many core objects in Affordable are using TypeORM, so you may find many examples in this codebase and in the docs describing how to work with it.

## Folders

The src/ folder contains all of the TypeScript code that should be compiled into JavaScript. In this folder you will find many folders. Here is an abbreviated guide to what the purpose of each folder is:

| Folder       | Purpose       |
|:-------------|:-------------|
| controllers     | Contains controllers that handle HTTP requests and responses |
| database     | Handles database connections and classes that modify objects in the database |
| database/dao      | Contains classes/logic that utilize and modify the database |
| models | Plain objects that store data to be transferred around the application |
| models/orm | Objects that have their own database table. For more information, see [Models and TypeORM](#Models-and-TypeORM) |
|routes| Defines and documents the REST API endpoints |
|services| Handles the domain logic in the application |
|test| Integration tests (unit tests are co-located with the component being tested) |
|utils| Reusable utility functions |

# Resources

[Zurfyx's answer on SO: Building Enterprise App with Node/Express](https://stackoverflow.com/a/42164174)

# Glossary

* Data access object (DAO) - A data access object is an object that provides access to stored data. For example, it will often be an object that provides create/update/get/delete methods for a particular type of data stored in a database.
* Database object (DBO) - Database objects are objects that store values stored in a database. These objects may not always have intuitive semantic meaning because they represent components of your database model. See _object-relational mapping_.
* Data transfer object (DTO) - Data transfer objects are objects that store data, and are designed to be passed around the application. In many cases, DTOs are handled by the end user as well. These objects should have intuitive, semantic meaning within the domain logic of the application.
* Object-relational mapping (ORM) - An object relational mapping defines the conversion between _database objects_ (e.g. in JavaScript) and relations (records in a relational database, e.g. MySQL)
* Representational State Transfer (REST) - A pattern for designing an API that behaves statelessly.