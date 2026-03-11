+++
title = "Learning Haskell, Chapter 2 - Serialization"
date = "2025-08-30"
draft = true

[taxonomies]
tags=["programming", "learning", "Haskell"]

[extra]
repo_view = true
comment = true
+++

# Learning Haskell, Chapter 2 - Serialization
_Note: This is not a tutorial, it is some kind of progress report about my personal experience with trying to learn the programming language [Haskell](https://www.haskell.org/)._

_Note: The source of my little learning project is publicly visible on [github](https://github.com/milanmueller/tasdb)_

In my [last blog post](/posts/learning-haskell-01), I created a little repl to define metrics and store values for these metrics alongside a timestamp.
An example execution of this tool looks something like this:
```
Welcome to TASDB. Enter commands, :show to show current state or :q to exit.
> metric add "mgs of caffeine" int
OK
> value insert "mgs of caffeine" 40
OK
> value insert "mgs of caffeine" 96
OK
> value insert "mgs of caffeine" "many"
Error: Type mismatch for metric 'mgs of caffeine': expected Integer number but got many
> :show
Types:
("mgs of caffeine",Integer number)
Values:
("mgs of caffeine",['96' - at 2025-08-29 14:06:46.17451554 UTC,'40' - at 2025-08-29 14:05:55.213929649 UTC])
```
The original goal of my project was to create a simplistic database.
Databases usually can store data on the disk, my program only keeps it in memory and therefore all data is lost once the program is quit.

Storing and reading this data efficiently is one of the most - maybe the single most interesting challenges of this project as there is a lot of room to play with things like caching, data structures, data proximity in RAM and so on. 

Before we can really go into that, I think we first need to figure out serialization of our data, which in itself can be an interesting topic when you look into compression algorithms for example.
There appears to be a number of serialization libraries in Haskell which would do most of this work, but since this is supposed to be a learning project, I elect to reinvent the wheel a bit here and go a bit more low level with this.

## Byte Curry
For this part, I am mostly consulting [Hackage](https://hackage.haskell.org/package/bytestring), to get an idea of what to do. \
Apparently one would use `LazyByteStrings` for I/O stuff with bytes, so I'm also going to do that.
In addition, to create such byte strings efficiently, using [`Builders`](https://hackage-content.haskell.org/package/bytestring-0.12.2.0/docs/Data-ByteString-Builder.html) appears to be the way to go.
The linked Hackage page has some nice examples which I'm going to adapt to my own use case.

We will eventually have to do both serialization and deserialization, let's focus on serialization first.
Analogously to the aforementioned Hackage page on [`Builders`](https://hackage-content.haskell.org/package/bytestring-0.12.2.0/docs/Data-ByteString-Builder.html), we have to implement a function
``` Haskell
encodeDBEnv :: DBEnv -> L.LazyByteString
encodeDBEnv = toLazyByteString . renderDBEnv
```
As a reminder, in [Chapter 1](/posts/learning-haskell-01) we defined `DBEnv` as
``` Haskell
data DBEnv = DBEnv
  { types :: Map MetricName MetricType
  , values :: Map MetricName [DataPoint]
  }
```
_Note that in Chapter 1, this type was called `DBState`, but I figured `DBEnv` would be more fitting, since to my understanding `DBState` might imply some kind of monadic structure, which this type does not have._ \


