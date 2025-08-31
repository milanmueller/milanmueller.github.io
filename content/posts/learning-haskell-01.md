+++
title = "Learning Haskell, Chapter 1 - What the hell is a monad?"
date = "2025-08-29"

[taxonomies]
tags=["programming", "learning", "Haskell"]

[extra]
repo_view = true
comment = true
+++

# Learning Haskell, Chapter 1 - What the hell is a monad?
_Note: This is not a tutorial, it is some kind of progress report about my personal experience with trying to learn the programming language [Haskell](https://www.haskell.org/)._

_Note: This is a first version of the post without any proofreading. I will go over it again and might do significant amounts of rewriting. Once I'm done, I will remove this second Note._

## Introduction

### The Motivation
In some of the university lectures I had the chance to attend, I was introduced to the idea of functional programming.
While being less intuitive than imperative languages, I found programming in a functional way to be quite satisfying compared to writing for loops all the time.
Somehow the abstract way of thinking which functional programming necessitates tickles similar parts of my brain as videos of hydraulic presses crushing stuff do.

I have also been wanting to do a personal programming project for some time, so I figured I might combine that with my curiosity for functional programming and try to solve some more complex problems than the usual toy programs from university lectures (which is not to say that those were too easy, what I mean by _complexity_ here, is the size of the program and also its real world usability rather than whether they are hard or easy to solve.)

### The Project
Here's the goal: I want to implement a very simple kind of [Time series database](https://en.wikipedia.org/wiki/Time_series_database). \
Now, calling what I'm planning to do a database might be a bit far fetched, so let's go with a more concrete description of my goal:
* The user should be able to define _metrics_. A _metric_ is a tuple `(name, type)`, where `name` is the name of the metric and `type` is, well, a datatype like number, flag (boolean), or some custom "one of" (i.e. enum) type.
  - I will not exactly fix the available types now, maybe I discover some other interesting types to support in the future.
* The user should then be able to track these metrics, i.e., insert a concrete value for a defined metric alongside a timestamp.
* The user should be able to fetch stored data for the metrics, optionally with applying some aggregation functions that are sensible w.r.t the respective datatype - this is probably where the bulk of the work is going to come from.

For now, inputting data should be possible through a command line tool, but maybe I will also implement a lightweight web api, cause that's what the cool kids do, right?

I want to implement all of this on a relatively low level. Of course I could use an existing database system and essentially write a wrapper around it, but where is the fun in that?

My language of choice is going to be Haskell, since I've already learned some Haskell at uni and it seems to be quite representative of the "functional experience".

### Where I'm coming from
While I'm not a first-time Haskell type of beginner, I'm definitely a beginner in Haskell programming and functional programming in general.
To be more precise, here are two statements of my current understanding of Haskell:
* I can understand the type signature of the bind operator `>>=` when I look at it.
* Five minutes later, I again have no clue what a monad is supposed to be.

### Personal Goals
* I want to put some concepts I've heard (like monads) of into practice within a real project.
* I finally want to get around to actually following through on one of my many ideas for personal projects.
* I want to "properly" write a piece of software. Even though my goal is not to write a production ready postgresql replacement, I would still like to do things as right as I can. The process of creating this thing should be as close to "real world" programming as possible. \
  Little spoiler: I'm going to go with a "get hands dirty, cleanup later" kind of approach here.
  While I do want to do things properly, I will come back to testing and documentation later and focus on actually writing some code first.

### Methodology
This is a personal blog that no one other than me is ever going to read, so choosing "methodology" as the `h3` heading here seems really overkill. \
Still, I want to to be transparent about how I am approaching this. Especially in the era of "vibe coding".

* I do not have llm-based autocomplete in my editor. The Haskell language server is all I'm using on that front. My editor of choice is [Helix](https://helix-editor.com/).
* I will ask ChatGPT or gemini cli whenever I get stuck with something for a longer period of time. I do think that there is something to gain from this approach even if it sometimes means to just do whatever an llm tells you. I can still use the generated stuff to have something that works and use it to learn why and how to then improve upon it.

I made the project public on [Github](https://github.com/milanmueller/tasdb) so that if anyone ever reads this, they could have a look at the source.

## Getting started
When I was younger, I tried to learn to draw. One of the hardest things about that, I felt like, was the initial hurdle of getting started with a drawing.
It felt like if I placed the first line of the initial sketch at the wrong position, the entire piece was doomed to be a complete failure.
Maybe this is a form of procrastination, maybe it is a form of perfectionism, or maybe both.

When I tried to get into some other project with languages I feel like I'm supposed to know (like Python, Java or to some degree C++ in my case), I would struggle with a similar thing.
Maybe this could be attributed to some ideas from oop, but I always feel like unless I find the perfect representation, class hierarchy, UML diagram or whatever right away, the project was going to end in an utter mess.

With Haskell, it seems I don't suffer from that. Maybe it's because I don't feel like I'm supposed to know what I'm doing in the first place.

A straight forward way to start this project seemed to be some datatypes to represent my database thingy. Here is what I came up with:
``` Haskell
-- from `src/Core.hs`
type MetricName = String
data MetricType = TInt | TBool | TEnum (HashSet String)
data MetricValue = VInt Int | VBool Bool | VEnum String
data DataPoint = DataPoint { value :: MetricValue, time :: UTCTime }
```
One thing I'd like to point out here is how easily this follows from my rough ideas up in [# The Project](#the-project).
In oop languages this is already the point where I would maybe be wasting a lot of time thinking about class hierarchies and how to encapsulate this data properly but in Haskell I feel like I can just type down whatever comes to mind (at least for now).

The choice of the proper datatype for timestamps is apparently not trivial, according to [this article](https://wiki.haskell.org/Time), but I decided to not worry too much about it for now and just pick `UTCTime` here as I think think it would not be too hard to change this in the future if I ever felt like I need to.

Now to actually store data, we of course need some kind of representation of "state".
To get started, I first want to store everything in memory and then tackle the hard part of serializing data, writing it to, and reading it from disk later on.
My memory allocated state looks like this:
``` Haskell
-- from `src/Core.hs`
data DBState = DBState
  { types :: Map MetricName MetricType
  , values :: Map MetricName [DataPoint]
  }
```
Note that `Data.Map`, which implements a Hashmap, is imported as `Map` here. If that's considered bad practice, I apologize.

One thing to note here, is that these six lines of code are already enough to represent some kind of _insane_ state.
Lets say we have
$$
\begin{align*}
  \textit{types} &= \lbrace \textit{foo} \rightarrow \texttt{bool}, \textit{bar} \rightarrow \texttt{int} \rbrace \\\\
  \textit{values} &= \lbrace \textit{foo} \rightarrow [1, 2, 3] \rbrace
\end{align*}
$$
_Note: I've omitted the timestamps here for simplicity._

This state is legal w.r.t. our defined Haskell types, but it is a state that does not make sense, since _foo_ is supposed to collect boolean values, not integer values. The type checker will not save us from such a state unfortunately.

Maybe there exists some kind of Haskell magic to prevent such states just through the type system, but if so, I am not aware of it (yet).

From what I've heard, the `Either` type is a decent way of encapsulating potentially erroneous states, so I elect to use that to differentiate between sane and insane states.

I had gemini create some sensible Error types for me which look like this:
``` Haskell
data DBError
  = MetricNotFound MetricName
  | TypeMismatch MetricName MetricType MetricValue
  | InvalidEnumValue MetricName String (HashSet String)
  | MetricAlreadyExists MetricName
  | InvalidInput String
```

Another predefined type that might be useful to us here is the `State` type, since we are dealing with, well, some kind of state.

Using `Either` and `State` gives raise to the following monad stack (at least I hope that's what this thing is called):
``` Haskell
type DBMonad = StateT DBState (Either DBError)
```
I'm using the `mtl` package here to stack these monads, though I have to say I'm not sure if this could also be achieved with `transformers`.
I might come back to this question at some point, to get a deeper understanding of monads and the workings of their stacking ^^.

What I do believe to know is that this scenario (state and errors) is one of the use cases of monads, so I'm just trying to use them and see where that's going to lead me :)

## State is evil - so lets change it
Again with the help of gemini (since I'm just not used to monads enough), I created some functions to modify my little state representation.
The most interesting one is probably `addDataPoint`:
```Haskell
addDataPoint :: MetricName -> MetricValue -> UTCTime -> DBMonad ()
addDataPoint name val timestamp = do
  mtype <- getMetricType name
  case validateValue mtype val name of
    Left err -> lift $ Left err
    Right () -> do
      s <- Control.Monad.State.get
      let oldPoints = Map.findWithDefault [] name (values s)
          newPoint = DataPoint val timestamp
          newPoints = newPoint : oldPoints
      Control.Monad.State.put $ s{values = Map.insert name newPoints (values s)}
```
The purpose of the used helper function `getMetricType name` is quite self explanatory - it checks if `name` is an existing metric and returns it's type if so.

What I would like to point out here, is how we don't have to check whether it returns an error since the potential error is encoded in our monad stack `DBMonad`, similarly to how we might be able to use the `?` operator in rust.

The other helper function `validateType` checks if the value of our new data type is compatible with the respective metric's type and might also generate a fitting error, if not.

In addition to `addDataPoint`, there are also two other functions which I will not show here, but they are implemented in a similar manner:
* `addMetric` - to define new metrics. This one might produce an error if a metric already exists.
* `deleteMetric` - to delete metrics. It will produce an error if the given metric does not exist, since some kind of idempotent deletion, if desired, should probably be "opt in" at a higher level.

## Handling user input
We want to support user interaction. For now through a little cli tool.
Since state only lives in memory until we do proper databasing, I decided to create a little repl for this.

This turned out a bit challenging for me and after some attempts with using a specialized library for cli argument parsing, I decided to use [Parsec](https://hackage.haskell.org/package/parsec) for parsing my repl's input and then translating that into calls to my previously created functions.

Maybe in the future I will go back to this step and do the parsing myself, since I think this might be a nice learning challenge.

Another though of mine is that Parsec, being a _monadic_ parsing library, might be a bit overkill and using an _applicative_ parser would be sufficient for this use case.
For now however, I wanted something that _just works_ and Parsec did not disappoint me.

We want to be able to parse two commands for now:
* `metric add "name" <type>`
* `value insert "name" "value"`

To represent these two commands, I came up with the following little grammar for my commands:
```
<ident> ::= <string>
<val> ::= <integer> | true | false | <string>
<type> ::= int | bool | enum [<string> (,<string>)*]
<mcmd> ::= add <ident> <type>
<vcmd> ::= insert <ident> <val>
<cmd> ::= metric <mcmd> | value <vcmd>
```
I hope it's clear how this grammar can be used to build our two commands, even though it probably can not hold up to any standards of formal correctness.
Our enum type should be definable like `metric add "colors" enum ["red", "green", "blue"]`, that's what the weird pseudo-regex for `<type>` is supposed to encode.

Of course I also tried to design this little grammar in a way such that it could easily be extended in the future.

In Haskell, the AST we want to parse into, follows directly from the grammar above:
``` Haskell
data Val = VStr String | VInt Int | VBool Bool 
data Type = TInt | TBool | TEnum [String]
data MetricCmd = Add String Type
data ValueCmd = Insert String Val
data Cmd = MCmd MetricCmd | VCmd ValueCmd
```

With Parsec, we can define a lexer with one simple function:
``` Haskell
lexer :: TokenParser ()
lexer = makeTokenParser style where
  style = emptyDef
    { reservedNames = ["metric", "value", "insert", "int", "bool", "enum", "true", "false"]
    , reservedOpNames = ["[", "]", ","]
    }
```
I should note that none of what I'm doing here is supposed to be best practice. I'm using Parsec for the first time and I like to use a "try until it works" approach when learning new things.

For each type of our AST, we create a parsing function. I won't include all of them here (the complete source is on [github](https://github.com/milanmueller/tasdb)), but as an example, here is the parser for our metric types (this one should be able to parse `int`, `bool` or custom enums `enum ["option1", "option2", "option3"]`):
``` Haskell
parseType :: Parser Type
parseType = parseIntType <|> parseBoolType <|> parseEnumType
  where
    parseIntType = reserved lexer "int" >> return TInt
    parseBoolType = reserved lexer "bool" >> return TBool
    parseEnumType = do
      reserved lexer "enum"
      enumValues <- brackets lexer (commaSep1 lexer (stringLiteral lexer))
      return $ TEnum enumValues
```
Coming from imperative programming, this function does look quite complex to me at first. But once I started to understand what was happening, I started to really like how concise these definitions are. \
There are no `if`s here, no `else if`s, no "_darn it, in this language it's `elif` not `else if`_"'s here, which I feel like matches the more "stateless" way one would think about a grammar like the one above.

Remember what I said earlier about _monadic_ parser combinators being overkill for this project? Well `parseType` is the one parsing function in my project that actually uses the bind operator (hidden in do notation). All other parsing functions only use `>>`. \
So maybe I was wrong earlier? Or maybe I'm wrong for using monad stuff when it's not necessary and this could be done in a purely applicative style? \
Well maybe at some point I'll be able to tell ^^.

## Run cabal, run!
Going from the AST we've now parsed to calling the functions that modify our state is what I will refer to as _monkey pattern matching_ where we can just give a decently trained ape the type signature of our function and the monkey will then do the pattern matching for us.
One might also argue that instead of apes we could use llms for such tasks.

Since my cognitive ability is essentially equivalent to one of those "reasoning model" thingies being used on top of a monkey's brain for token prediction, I decided to implement functions like these myself:
``` Haskell
runParserType :: Type -> MetricType
runParserType Parser.TInt = Core.TInt
runParserType Parser.TBool = Core.TBool
runParserType (Parser.TEnum variants) = Core.TEnum (fromList variants)

runParserMCmd :: MetricCmd -> DBMonad ()
runParserMCmd (Add mname mtype) = addMetric mname (runParserType mtype)
```

What I found to be a lot more challenging was to now finally print stuff to stdout to build a little repl so that a user (maybe another ape?) could define some cool metrics.

Again, mostly because my monkey brain still can't fully handle monads, I let gemini help me with the following repl function:
``` Haskell
executeLine :: DBState -> String -> IO ()
executeLine _ ":q" = putStrLn "Bye!"
executeLine st ":show" = do
  print st
  repl st
executeLine st line = do
  currentTime <- getCurrentTime
  case parse parseCmd "" line of
    Left err -> do
      print err
      repl st
    Right cmd -> do
      let result = runStateT (runParserCmd cmd currentTime) st
      case result of
        Left dbErr -> do
          putStrLn $ "Error: " ++ show dbErr
          repl st
        Right ((), newState) -> do
          putStrLn "OK"
          repl newState

repl :: DBState -> IO ()
repl st = do
  putStr "> "
  hFlush stdout
  line <- getLine
  executeLine st line
```

This glues everything together and we get a nice little repl to track our really important data
```
Welcome to TASDB. Enter commands, :show to show current state or :q to exit.
> metric add "os" enum ["linux", "evilwindowcompany"]
OK
> value insert "os" "linux"
OK
> value insert "os" "evilwindowcompany"
OK
> value insert "foo" "bar"
Error: Metric 'foo' not found
> value insert "os" "solaris"
Error: Invalid enum value 'solaris' for metric 'os'. Valid options: ["evilwindowcompany","linux"]
> :show
Types:
("os",Enum [evilwindowcompany, linux])
Values:
("os",['evilwindowcompany' - at 2025-08-28 23:12:55.999177386 UTC,'linux' - at 2025-08-28 23:12:47.571831704 UTC])
```
Of course, the printing could be prettier, but I find for how few lines of code we had to write this works quite nicely.

In addition, I am a lot more confident in that my little program behaves as intended, than I would likely be had I written it in an imperative language.

## What's next
Of course there is a lot of incremental improvements to be made to our little repl tool.
More datatypes, input history (with up and down keys like in bash) and prettier printing are the first few that I can come up with on the spot.

However, this project was supposed to be about a database and we are not even writing anything to the disk yet - time to change that.

In the next part, I think I'm going to go back to the drawing board and think a little bit about how I want data to be stored.
Designing a storage backend for our database is obviously one of the most critical and challenging parts of this project, so let's look at that next.

As of writing this, the most recent commit on [github](https://github.com/milanmueller/tasdb/commit/0110a09e8826029fa7e8629dcd1453dd54fab2c2) has the hash `0110a09`. Code shown here might look very different on the repo at a future point in time.
