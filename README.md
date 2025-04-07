# Kaiwa

Kaiwa (会話) helps you to create projects, comment inside them and track the changes of the
project's statuses

## Table of Contents

- [Tech Stack](#tech-stack)
- [Q/A Teammates](#qa-teammates)
- [Caveats](#caveats)

## Tech Stack

- Ruby on Rails
- SQLite
- TailwindCSS

## Q/A Teammates

Q: Should projects page be in the first thing someone sees when accessing the platform?
A: Yes, projects page should be the home

Q: How should I display the projects?
A: You can use a table-like design to displayed them, it would be nice that you can see actions
   buttons to the right of the project row.

Q: Can I display comments inside project show page?
A: Yeah, that's the way to do it, so it is like a pull request page where you can see the whole comments
   in that page ordered in ascending order by created_at attribute

Q: Now that turbo is so popular, I'm planning to use Turbo in this page to display the "Add comment" form
   and when created append to the end of the comments list.

Q: I'm thinking that using the model Comment for storing comments and changes would avoid us to merge
   two models to display the project conversation.
A: Yeah, for a small project like this could be a good idea to be pragmatic but in the mid and long term
   the idea is to have specialized models to store user's comments and project changes.
   
   The problem is that makes a bit more diffcult to display the project conversation/history
   but using a gem like [scenic](https://github.com/scenic-views/scenic) would allow us to create a view to merge both model results
   and use it from an Active Record model, this help us to use pagination, but if pagination is not needed
   you can fetch everything and sort in memory.

## Caveats

Please be aware that I've used the rails way to build the application but this is not how 
I build applications, just did it for this assignment but that's why I'm writing these lines, also
that could take more than 3 hours to do it properly, including everything well tested.

To build a real application where the code can scale I don't follow rails way so what I use to do it?
I can explain how I work at Hubbado but you can use similar approaches to generate quality code.

### Controllers
Typically the controllers won't have an business logic and will be delegated to other class.
At hubbado we use [Trailblazer operations](https://trailblazer.to/2.1/docs/operation/) to do the whole request process inside that so the typical
operation that we use will do the following:
- Find or build a model
- Authorization step using a policy
- Building a [Reform contract](https://trailblazer.to/2.1/docs/reform/) for a form
- Load all the info needed from DB to avoid database calls from views
- Validate params
- Save the model

Sometimes we use POROs inside operations, some complex operations that deserves to test in isolation.

### Views
Use [Trailblazer cells](https://trailblazer.to/2.1/docs/cells/) to create view components (as the gem you use) to reuse them and test
them in isolation.

### Models
Don't store any business logic or callbacks in models, only use for adding scopes and relationships.
My experience has taught me that callbacks are very problematic so I prefer to not used them.

### Folder Organization
Try to avoid default rails folder organization, better to store concepts inside app/concepts so 
you can properly organize fields per concept, e.g:

Having the concept `assignments` the folder structure inside `app/concepts/assignments` could be
- controllers
- models
- cells
- contracts
- operations (or op)
- ...

### Testing
Structuring applications using a good folder structure and moving business logic to POROs or other
testable structures, makes easy test otherwise using Rails-way you have to depend a lot in systemt tests
that are really slow.

