

This document examines the need for a separation of basic and advanced functionality in the DAISY Online Delivery specification.  It discusses some strategies for defining basic and advanced functionality in the specification.

The purpose of this document is to be transformed into exact definitions of basic and advanced operation.  Right now, it is very vague.  It should start being tightened up after the requirements review is completed.

# Basic vs. advanced: definitions and justification #

A **basic session** would have the following structure:

  * The Reading System connects to the Service and authenticates (if necessary).
  * The Service presents a list of content to the Reading System.
  * The Reading System downloads some, all, or none of the content.
  * The Reading System disconnects from the Service.

An **advanced session** is one that incorporates more components of the specification than included in a basic session.  (**Components** refers to whole API functions and DOML data structures as well as parts of the same, such as function arguments, sub-elements and attributes.)

A **basic client** is one that supports only basic sessions.  An **advanced client** is one that supports both basic and advanced sessions.  Similarly, a **basic server** is one that supports only basic sessions, and an **advanced server** is one that supports both basic and advanced sessions.

Clients and servers will need to negotiate the level of service to be offered.  If either the client or server is basic, then a basic session should be initiated.  The different levels of service should be interoperable.

A basic mode may be used by an organization that delivers content automatically to a user, e.g. a library that has a "profile" system where books are circulated to clients based on their genre preferences.  A basic mode may be also be used by an organization that already has an interface for users to select their content and do not wish to implement another, e.g. a library with an accessible OPAC (online public access catalogue).  An advanced mode may be used by an organization who wishes to include multiple ways to select content.  An advanced mode may also be used by an organization without another accessible method of selecting books, e.g. a library providing service to a developing nation that may not have an OPAC or a reader services department.

# Strategy overviews #

These are high-level summaries of ways of separating basic functionality from advanced.

## Required vs. optional approach ##

One way of designing basic and advanced services in the specification would be to identify a group of **core** components that would be required to make the basic service operate, and leave the rest to be **optional**.

### Advantages ###

  * Simple definition of basic and advanced functionality.

### Risks ###

  * There may be unaddressed incompatibilities between an advanced client and an advanced server if they did not implement the same optional components.
  * Optional components may not receive scrutiny during development of the specification or of implementations.
  * There may be functionality that needs to be served by a group of components that cannot be performed if one of the components is absent.

## Two-level approach ##

A group of core functions and data types are identified as necessary and sufficient to support a basic service.  Those functions and data types are required for the **basic level** (or profile) of conformance.

All functions and data types are required for the **advanced level** of conformance.

It may be desirable to have three levels.  Beyond three levels, though, a modular approach is probably more viable.

### Advantages ###

  * Simple definition of basic and advanced functionality.
  * Simple conformance testing (only two modes of operation need to be tested for client and server).

### Risks ###

  * Advanced components may not receive scrutiny during development of the specification or of implementations.
  * Implementers of advanced systems must implement all functionality.

## Modular approach ##

As above, a group of core functions and data types are identified as necessary and sufficient to support a basic service.  Those functions and data types are required for the **basic level** (or profile) of conformance.

Groups of functions and data types are identified as necessary and sufficient a number of independent modes of operation (e.g., dynamic menu support, PDTB2 support, service announcement support, etc.)  Each set of requirements for each mode becomes a **module**.

It may be advantageous to define a two-level approach as described above instead as a basic level with one module (the "advanced" module).  This would allow for easier extensibility in future versions of the specification.

### Advantages ###

  * Implementers can pick and choose what modules to implement.
  * Modular approach is more extensible in the future: to add new functionality, add new modules.

### Risks ###

  * Advanced components may not receive scrutiny during development of the specification or of implementations.
  * Conformance testing would likely need to involve testing of each component in isolation and in conjunction with any number of other components.  The number of tests goes up exponentially with the number of optional modules supported, O(2<sup>n</sup>).
  * Similarly, this creates a large number of different versions of the specification, complicating things greatly for implementors who wish to wish to create universal servers or clients that work with any combination of modules.

# Detailed strategies #

There are none at this time.  They will be written after the coming requirements/scope review.  Given the current scope, it is unlikely there would be more than a few strategies to consider.

## Division of the specification ##

These sections will name which components of the specification are basic and which are advanced.

### Definitely basic ###

This section will name the components are certainly necessary for basic functionality.

### Possibly basic ###

This section will name the components that might be beneficial to require for basic functionality.  This section should disappear before the strategy is nailed down.

### Definitely advanced ###

This section will name the components that are certainly not required for basic functionality.