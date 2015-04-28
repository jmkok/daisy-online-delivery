

Present: George, Simon, Jelle, Geoff, Matt, Markus, Nick, Kenny

Regrets:

## Action Item Summary ##

### New Action Items ###

### Previous Unfinished Action Items ###
  * Jelle: propose resolution to [Issue 118](https://code.google.com/p/daisy-online-delivery/issues/detail?id=118)
  * Geoff and Markus analyze RequirementsDocument vs current API. {ONGOING}

## Agenda/Minutes ##

Target: solve the below and distribute action items to implement changes


### Faults ###
  * Add a dedicated fault when invoking an operation when session has expired?
    * (Is a fault code embedded in invalidOperationFault an alternative?)
  * expanding the Fault documentation prose - who?

**Resolution**: Markus add: NoActiveSession Fault : cover both expiration and not logged in. Throwable by all except logon.

**Geoff clarify session in terminology**

**Markus: expand prose for all faults**


### Borrow/Return ###
Matt:
> In addition to the other todo remarks in the Content Return section,
> the only mention  made in the specification about borrowing content
> is one sentence in this return section.

> The section should probably be renamed to "Lending Content" and have
> subsections for borrowing and returning. And be moved into 5.4.

**Resolution: Geoff to add prose**


### Return date ###

  * Do we need an explicit return date in contentMetadata (when @requiresReturn=true)

**Resolution**: Markus add optional attribute **returnBy**, optional even when requiresReturn is set to true, and must not be present when requires return is false.

**Markus:**Make **requiresReturn** optional, default to false.


### Normative/Informative ###
Matt:
> One thing I have noticed is some inconsistency in applying the
> normative/informative designation on chapters/sections. Would be
> good to have someone in the group go through after I'm done and
> re-apply those consistently to whatever scheme the group wants
> to use for them.

**Resolution: Markus go through**

### Service Models ###

Keep/remove? If removed, spec needs to be generalized.

**Resolution:** Geoff take a stab at rewrite


### Reading System Conformance Requirements ###
  * Section still marked as TODO. How to approach this?

**Resolution:** Matt: take section 3 out, may reintroduce after draft stage.


### Terminology ###

Matt:
> So, to be 100% sure we're on the same page. Operations are
> operations. Primary types are types. Then all the
> elements/attributes in the element reference section will
> be referred to by their xml types?


**Resolution** Matt fix it.


### rules surrounding the issueContent and getContentResources operations ###
**Resolution**: Matt: make sure we have **may** throw fault at getContentList when issue has not been called prior.

### Move Appendix B to separate informative dynamic menus primer ###

**Resolution**: Markus do this. Remove Appendix, list from top of doc somehow instead.


### Collect and add complete contributor list ###
**Markus**: make all three lists.


### Check if we can reintroduce some of the samples into the types section ###
**Markus**: add Geoff's contentResources for PDTB2 DTB, contentMetadata?, then notify Geoff


### AOB ###
Nick. Notifies the group of the existance, IMDA Internet Media Device Alliance. We should investigate and see what the connections are.