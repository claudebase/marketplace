# Analogy Library for Code Explanations

## Data Structures

### Array
**Analogy**: A row of numbered mailboxes
- Each mailbox has a number (index)
- You can go directly to mailbox #5 without checking 1-4
- All mailboxes are the same size

### Linked List
**Analogy**: A treasure hunt with clues
- Each clue tells you where the next clue is
- To find clue #5, you must follow clues 1→2→3→4→5
- Easy to insert a new clue in the middle

### Hash Map/Dictionary
**Analogy**: A library card catalog
- Look up a book by title (key) → get location (value)
- Don't need to search every shelf
- Fast lookup, but catalog takes space

### Stack
**Analogy**: A stack of plates
- Can only add/remove from the top
- Last plate added is first removed (LIFO)
- Can't access plates in the middle

### Queue
**Analogy**: A line at a coffee shop
- First person in line is served first (FIFO)
- New people join at the back
- Fair and predictable ordering

### Tree
**Analogy**: A family tree or org chart
- One root at the top
- Each person can have children below
- Can trace path from any person to the root

### Graph
**Analogy**: A social network
- People (nodes) connected by friendships (edges)
- Connections can be one-way or two-way
- Some people have many connections, some few

## Programming Concepts

### Variables
**Analogy**: Labeled boxes
- The label is the name
- The box holds a value
- You can change what's in the box

### Functions
**Analogy**: A vending machine
- Put something in (parameters)
- Machine does its thing (processing)
- Get something out (return value)

### Classes
**Analogy**: A blueprint for a house
- Blueprint defines the structure
- Each house built from it is an instance
- Houses can have different colors (property values)

### Inheritance
**Analogy**: Parent-child traits
- Child inherits traits from parent
- Child can have additional unique traits
- Child can override parent traits

### Interfaces
**Analogy**: A power outlet standard
- Defines the shape of the plug (contract)
- Any device with the right plug works
- Doesn't care what the device does internally

### Closures
**Analogy**: A backpack from home
- Function carries variables from where it was created
- Even when function travels elsewhere
- Has access to its "home" context

### Async/Await
**Analogy**: Ordering at a restaurant
- Place order (start async operation)
- Do other things while kitchen works
- Get notified when food is ready (await)

### Promises
**Analogy**: A claim ticket at dry cleaning
- Ticket represents future result
- Can check status anytime
- Eventually resolves to your clothes (or error)

## Architecture Patterns

### MVC
**Analogy**: A restaurant
- Model = Kitchen (data/logic)
- View = Dining room (what customers see)
- Controller = Waiter (coordinates between)

### Microservices
**Analogy**: A food court
- Each restaurant is independent
- They share common space (network)
- Failure of one doesn't close others

### Event-Driven
**Analogy**: A newspaper subscription
- Subscribers don't ask for news constantly
- Publisher sends when there's news
- Many subscribers can receive same update

### Caching
**Analogy**: Keeping frequently used items on your desk
- Faster than walking to the filing cabinet
- Limited desk space
- Must update when original changes

### Load Balancing
**Analogy**: Multiple checkout lanes at grocery store
- Distribute customers across lanes
- Opens more lanes when busy
- Closes lanes when quiet

## Web Concepts

### HTTP
**Analogy**: Ordering at a restaurant
- Request: "I'd like a burger, please"
- Response: "Here's your burger" (or "Sorry, we're out")

### REST API
**Analogy**: A library system
- GET /books → List all books
- GET /books/123 → Get specific book
- POST /books → Add new book
- DELETE /books/123 → Remove book

### WebSocket
**Analogy**: A phone call
- Connection stays open
- Both parties can talk anytime
- More conversational than letter writing (HTTP)

### JWT
**Analogy**: A wristband at an event
- Given at entry (login)
- Shows what areas you can access
- Has expiration time
- Can be verified without calling the box office
