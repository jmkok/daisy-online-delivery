

Present:

## Action Item Summary ##
### New Action Items ###

Geoff and Kenny to reorganise the requirements.

Nick to go through the wiki and add comments based on the historical discussions of the group.

Kenny to add the https vs getResource issue to the tracker.

Geoff to go through James e-mail and add any additional issues to the tracker.

Markus to provide a sample rebuild of the specification.

Geoff to provide some alternative dates for a face-to-face meeting.

### Previous Unfinished Action Items ###
  * @markus put all classic TSG req docs on SVN
  * @kenny enter atomic issues reported so far to google code tracker
  * @markus, @kenny draft one or several hypotheses on spec documents reorganization

## Agenda/Minutes ##

### Status update ###
#### Requirements revisit ####
Bucket is closed. Are all proposed changes to requirements document logged at issue tracker?

Markus noted that there are 87 issues in the tracker including those on requirements and general comments about the API and DOML.

Kenny and Markus have reviewed Geoff’s comments on the requirements.

Markus proposed producing a clarified requirements documents on the wiki.

Kenny asked whether those clarifying the requirements need to speak to the origanator of each requirement. It was noted that the named person was the originator of the user story not the resultant requirements.

Markus observed that we should be equally clear about out-of-scope as well as in-scope requirements.

Nick asked whether we had requirements – we have user stories and a mapping to functions. Geoff clarified that his comments were referring to the requirements not the user stories.

Markus questioned whether we should republish the user stories. It was suggested that we produce two interlinked documents – one for the requirements and one for the user stories.

Markus asked if all the issues were covered by the requirements and suggested that the answer was no. Geoff noted that requirement 17 dealing with PDTB2 keys was not actually covered.

Markus noted that we have previously agreed that library-to-library exchange is out-of-scope for version 1.

Kenny asked whether we are clarifying the issues in the tracker or are we allowing for additional requirements. Geoff suggested that we re-organise them first and then deal with any issues.

Markus noted that the only extra requirement is about PDTB2 keys which was an original requirement that may have been de-scoped but is now back in scope.

Kenny noted that in an earlier call it had been suggested that a request for additional comments should be sent to the wider daisy list. Dominic was concerned that only a few daisy members would support the standard. George commented that at the board meeting many organisations expressed interest in using the standard over the next couple of years. George did not think that it would be possible to market the spec to those who are not currently in the group and that there will be a marketing piece when we have a standard for test use.

Markus noted that it is hard to progress a project if one is constantly rechecking scope with different groups of potential users.

Geoff and Kenny offered to reorganise the requirements. Nick offered to go through the wiki and add comments based on the historical discussions of the group.

George asked how much linkage between requirements an user stories was required. It was agreed that the requirements should back link to user stories.

#### Issue Tracker ####
Are there any yet unpublished (non-requirements-related) issues?

Markus asked for any non-requirements related issues that have not been posted to the issues tracker. Kenny asked if the issue about the getResource function had been logged. Geoff suggested closing [issue 42](https://code.google.com/p/daisy-online-delivery/issues/detail?id=42) as the specific issue that Geoff had is no longer an issue.

### Single issue discussion: getResource vs http data transfer ###
Latest addition to discussion by Geoff to list on June 3:

> Okay, I've sat down with the specs and I think I've sorted this out in my mind a bit better.  The canonical way of sending binary data in XML is base64-encoded.
> If the XML is then encoded in UTF-8 (or a single-byte encoding like latin-1), then this adds 33% to the size of the data.  (UTF-16 and double-byte encodings add 166%, etc.)

> What MTOM does is allow you to extract base64 data from an XML stream, decode it into binary data, then send the XML and the binary portions as a multipart MIME message.
> The XML message now has references to the parts of the MIME message. The XML document can then be reconstituted on the receiving end by reencoding the referenced attachments as base64.

> This mitigates the transport overhead almost completely.

> The risk with this is that there only seem to be MTOM implementations for .NET and Java, which reduces the field for servers and clients.
> I'm not sure how much power a reading system would need to run WCF or Metro.  I'm not sure how those implementations work.
> I think an important question is whether, on the receiving end, the binary attachments are reencoded as base64 and you have to decode them yourself, or whether you can access them by reference from the MOTM-encoded data.
> This has profound implications for low-power devices. The alternative is writing your own MTOM implementation for your platform, which I suspect is nontrivial.

Kenny offered to add the https vs getResource issue to the tracker.

Geoff offered to go through James e-mail and add any additional issues to the tracker.

Geoff noted that there is an Apache C library that supports MTOM.

Jelle noted that WSO has gSoap has MTOM support. WSO has support in php and some others.

Geoff felt that there is an issue about using MTOM if we consider interrupted transfer.

Jelle felt that the overhead was not necessarily mitigated by MTOM as the server can still use base64 encoding.

Simon felt that as long as there are tools for MTOM there is no problem.

Hiro agreed with Simon.

Jelle asked if http was still an option alongside getResource.

Markus preferred a single method.

Jelle did not wish to drop http.

Nick asked what was the reason for preferring a single method rather that an choice of two and if there is no 33 percent additional bandwidth use what other issue was there.

Jelle outlined what supporting both methods would mean – that players would implement both methods and the service provider can choose.

George asked if they were mutually exclusive.

Geoff observed that there may be future cases involving requesting content from a further organisation where you might want both methods in the same service.

Kenny noted that there are ways of performing the content abstraction via http / https.

Nick suggested that we drop the getResource function.

Jelle suggested that the reading system manufacturers have the final say and that the service can handle the logging functions which lead to the creation of getResource.

Nick noted that authentication of users was also simpler via getResource.

Kenny suggested that the protocol need not concern itself with the abstraction that getResource provides.

Jelle expressed concern that handling of range headers etc through scripts on servers was easy to get wrong.

Geoff suggested that the test suite include http requests containing range headers.

Kenny mentioned that dropping MTOM means more to the spec than the getResource function eg the Message fragment also includes MTOM for embedded audio.

We agreed to suggest dropping MTOM everywhere and getResource and to consider the ramifications on the list.

### Next steps ###
Proposal:
  * 1. publish revised/updated requirements document (Wiki format) based on issue tracker entries.
  * 2. specification rebuild, with the following characteristics:
    * Based on a new document structure (Markus has action item to propose a revised structure)
    * Take required vs Optional levels of API into account (we could start with building prototypes of required API in an inwards-out fashion)
    * Address logged issues one-by-one as they occur during rebuild process
    * Carefully log all actual API changes so that existing implementations can be adapted swiftly
    * Constant rechecks with requirements document

Markus suggested that specification rebuild in the first next step. This would cover the required / optional API.

Markus offered to provide a sample rebuild of the specification.

George asked if this would remove the need for a separate primer.

Markus replied that the new structure would probably mix normative and informative sections.

Markus suggested that the ontology document could be generated from the spec rather than authored separately.

George expressed preference for a single document.

Markus noted that we need to maintain a change log for API changes.

### F2F ###
Once specification structure is settled and the rebuilding process has begun, we could hold a WG F2F to expedite the process of issue fixing and spec authoring.
  * Who could join?
  * Appropriate dates?

George noted that the board wants the spec delivered as soon as possible and is willing to accept a “draft standard for test use” by mid September ready for the meeting in late September.

Markus suggested a four day long face-to-face in July / August. CNIB offered to host such a meeting in Toronto.

Geoff offered to provide some alternative dates for a meeting.

### Next concall ###

Next Tuesday 1400 UTC.