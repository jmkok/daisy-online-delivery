present: Simon, Geoff, Kenny, Jelle, Johan, Nick and Hiro.

Regrets: George, Dominik.

scribe: Kenny

## Action Item Summary ##

### New Action Items ###

  * Kenny add a feature request to the Daisy Online issue tracker on the Daisy website to provide a direct mechanism in dynamic menus for a Service to return resource ids, and close [Issue 237](https://code.google.com/p/daisy-online-delivery/issues/detail?id=237). **done**
  * Kenny make modification to the types xsd to make the input element a required element, and close [issue 238](https://code.google.com/p/daisy-online-delivery/issues/detail?id=238). **done**
  * Kenny clarify in the spec that the getContentList operation must return an empty contentList when the supplied start and end parameters are invalid, but return the actual size of the entire contentList in the totalItems attribute in the resultant contentList, and close [Issue 239](https://code.google.com/p/daisy-online-delivery/issues/detail?id=239). **done**
  * Geoff mention in the Systems Testing report that the getKeyExchangeObject operation test was partially successful.

> ### Previous Unfinished Action Items ###

  * Johan, Geoff (types reference and API) and kenny to proof read the spec before the next telecon. **geoff: done, kenny: done, Johan: done**
  * Johan and kenny to proof read the primer before the next telecon. **kenny: done, Johan: done**
  * Simon ask colleagues in HumanWare if they could proof read the spec and primer before the next telecon. **nobody had time**
  * Jelle talk to Geoff offline about the Systems Testing report. **done**
  * Simon to add the minOccurs and maxOccurs tweak to the tweaks page. **done**
  * Markus fix the &apos; entity problem. (outstanding; bug in IE.) (Markus will fix this when ready to publish.) **done**

### Group Action Items ###

#### Action items for formal recommendation to the Board on April 5, 2010 ####

  * Deliver the final version of the spec.
  * Provide information on comments received, and how they were addressed.
  * Make the System Testing document available on the wiki.
  * Make a formal Recommendation to the board for approval that includes:
    * A one page document that contains the recommendation by the WG including a link to the spec, and a link to the Primer.
    * An appendix containing the System Testing Report.

## Agenda/Minutes ##

### Issues ###

#### [Issue 237](https://code.google.com/p/daisy-online-delivery/issues/detail?id=237) ####

Jelle: Currently you can only return a content list ref.
I think it would be essential that the getQuestion can return a list of
resource ids.

This will ease up enormously on search and other functionality where
currently the content list is just a huge burden which always needs to be
placed in between...

Nick: I think the reason it was done this way was because you could get a contentList bit by bit with this approach.

Geoff: I remember a discussion in July last year where this was discussed, and we decided for the contentList due to the possibility of very large content lists.

Geoff: Is it a showstopper?

Jelle: No.

Simon: Perhaps we could have this in a future version of the spec?

( Consensus: The group agreed to add a feature request to the Daisy Online issue tracker on the Daisy website to provide a direct mechanism in dynamic menus for a Service to return resource ids.)

#### [Issue 238](https://code.google.com/p/daisy-online-delivery/issues/detail?id=238) ####

Geoff: Currently the model for an inputQuestion allows zero or one inputTypes
children.  Shouldn't there always be one inputTypes child?

Simon: I agree with Geoff. I ran into this problem while testing.

(Consensus: The group agreed to implement Geoff's recommendation.)

#### [Issue 239](https://code.google.com/p/daisy-online-delivery/issues/detail?id=239) ####

Jelle: getContentList with unsatisfiable ranges should return an empty list and not throw an invalidParameter.
The invalidParameter should only be thrown if the ID is invalid.

examples:
- getContentList("new",5000,6000)
> return an list with totalItems set to 0
- getContentList("-non-existing-",5000,6000)
> throws an invalidParameter

You might argue with the first example, however take the following example into account..
Throwing an invalidParameter would generate issues with the following examples:
- getContentList("new",0,6000)
> invalidParemeeter or return the amount of items ?!?!
- getContentList("new",100,6000) on a list of exactly 100 items !!!
> invalidParemeeter or return an empty list ?!?!

Geoff: Currently, we don't say anything about this in the spec, but I am in favour of Jelle's suggestion.

Johan: I agree.

(Consensus: The group agreed to clarify in the spec that the getContentList operation must return an empty contentList when the supplied start and end parameters are invalid, but return the actual size of the entire contentList in the totalItems attribute in the resultant contentList.)

#### [Issue 240](https://code.google.com/p/daisy-online-delivery/issues/detail?id=240) ####

Johan (paraphrased): Remove the noActiveSession fault from logOff.

Simon: I don't mind either ways as I don't check what logOff returns.

Jelle: I have no problems with Johan's recommendation.

(consensus: The group agreed to remove the noActiveSession fault from the logOff operation.)

### KeyExchangeObject operation ###

Simon: I’ve been talking with some of you about the getKeyExchangeObject operation. For now, I’ve only been able to test getKeyExchangeObject with Pratsam. And the result on my side are not conclusive. Looking at the actual saop envelope body, I can see what looks like a valid KXO. In fact I’ve been able to manually import this KXO (extract from soap trace) into my player and render encrypted content. But I haven’t been able to do it via the deserialization process. And this is using two different clients (WCF and gSOAP). I’ve been talking with Hiro and he seems to have problems with that operation too. Perhaps he can comment on that.

I think this subject should be discuss during the next telecon.  Unless someone comes up with successful test result, do we want to keep the key delivery as is in the spec ? Do we want to change it for a more general approach (one that does not involve understanding of the KeyExchange type) ? Do we want to remove it from the spec ? I’m not sure where I stand but I think this might be a concern for final approval.

Geoff: I am apprehensive about submitting something to the board that has not been tested. We haven't been able to properly test the getKeyExchangeObject operation as yet.

Simon: I was not able to make the getKeyExchangeObject operation work. I could extract the kxo out of the soap envelope, put it on the stream and make it work though.

kenny: What is the issue with? Is it the xsd, wsdl or our toolkits?

Johan: I had to make modifications to the kxo xsd to make it work in my toolkit.

Simon: I am not necessarily in the favour of removing the getKeyExchangeObject operation, but I have concerns about moving forward with something that has not been tested properly.

Geoff: It seems like a problem with our toolkits. Johan has been able to send a valid kxo, and Simon has been able to decrypt using the kxo. We should make a note in the systems testing report about whats going on here, but I think we could go forward with the submission once its noted in the report.

Jelle: As long as we note it down in the report, we should keep it.

(Consenssus: The group agreed to mention in the Systems Testing report that the getKeyExchangeObject operation test was partially successful, but not remove the getKeyExchangeObject operation from the spec.)

### Test suite Progress review ###

#### [Systems Testing](http://code.google.com/p/daisy-online-delivery/wiki/ProtocolSystemTesting) ####

  * Status of the Systems Testing report

Geoff: We are mostly done. There are a few areas that need improvement e.g. 11.2. Another area is 6.1. I am waiting for three tests from Simon.

Simon: I have these tests done. I will put them up later on today.

Jelle: The namespaces on my bookmarks should now be fixed.

Geoff: Hiro will be sending me an updated report in a few hours.

Geoff: I am hoping to have this done before 4:00 p.m. UTC on thursday, 1 April.

Kenny: I will get Ashish to liaise with Simon in a few hours about our fixes.

### Consensus Check ###

  * Do we have consensus to submit the Daisy Online spec to the Daisy Board for endorsement as a Technical recommendation of the Daisy consortium with:
    * The spec documentation in the svn as it stands right now.
    * the System Testing report as it stands right now.

Simon: Do we have any unresolved tests in the Systems Testing report?

Geoff: Section 11.2 and 6.1 were the only concern areas in the report. I have at least one successful test for everything else.

Simon: If we don't have any major issues in the Systems Testing Report, I am happy for the spec to proceed to submission.

Jelle: Yes.

Nick: Yes.

Geoff: Yes.

Hiro: Yes.

Johan: Yes.

Kenny: yes.

### Submission logisstics ###

Kenny: I will post the formal submission document to the Daisy Online mailing list a few hours from now. After Geoff has posted the Systems Testing report to the list tomorrow, we will give the members of the list 24 hours to raise any objections. If no objections are raised, the formal submission including the Systems Testing report will be sent to Bernhard. Is everyone happy with this?

(consensus: Group agreed to move forward with this course of action.)