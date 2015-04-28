## Summary ##

The following discussion has been captured from the Daisy Online mailing list. The discussion pertains to the implications of using multiple reading systems with the Daisy Online protocol, and the suggested approaches.

## Discussion ##

Johan:

1. Is the protocol, as is, supposed to support several RSs per user?
(Yes/No) I think yes but believe it's not possible. The serialNumber in rSA must be required in order for a service provider to track RSs. Now it's optional.

The following questions are only relevant if the answer to question 1 is Yes

2. Should two or more RSs belonging to the same user be allowed to log on to a service and listen to content simultaneously? (Yes/No) My opinion is that this should be prohibited as the the service could be misused.

3. Should contentLists (new, issued, and expired) be personal for each RS or should the they be identical on each RS? (Personal/Identical) My opinion is identical.

The following questions are only relevant if the answer to question 3 is Identical.

Suppose that a user has two RSs. The user issues and downloads a book on RS1. The next day the user downloads the same book on RS2. After a month or two the book is listed under the 'expired' list and the powers on RS1. RS1 requests the 'expired' list, notices that the book must be returned and informs the user. The user returns the book, what happens next?

4. Should returnContent return 'true' or something we not yet have defined? (True/Undefined) My opinion is True

5. Should the book still be listed under the expired list until RS2 returns the book? (Yes/No) My opinion is Yes.


What are your thoughts on this?

Geoff:

This came up in discussions a few times. We decided that, beyond PDTB, we weren't going to address the issue ourselves, since any robust solution would require DRM. So, the spec itself does nothing to prevent multiple downloads; instead the question is left with the service. (Permitting multiple RSes to access content was a requirement.)

So, the service can forbid multiple calls to getContentResources, or only permit one user agent to access HTTP resources, or only allow one download of each resource, or there may be some other way to try to limit the number of copies out. Service providers who want to allow multiple RSes to access a book have to deal with the synchronization problems that arise.

Ultimately, though, the problem boils down to copy protection, since the same synchronization problems arise if the user has an RS with removable media and copies books to their hard drive.

Kenny:

1. Is the protocol, as is, supposed to support several RSs per user?
(Yes/No) I think yes but believe it's not possible. The serialNumber in rSA must be required in order for a service provider to track RSs. Now it's optional.

Kenny: As Geoff mentions, using multiple reading systems with the protocol has been discussed several times. The protocol does not require that a Service track multiple reading systems. The serialNumber attribute is optional thus.

2. Should two or more RSs belonging to the same user be allowed to log on to a service and listen to content simultaneously? (Yes/No) My opinion is that this should be prohibited as the the service could be misused.

Kenny: Whether a service decides to allow multiple downloads of issued content, allows issued content to be streamed for lets say thirty days are all service behaviours. However, if you see a glaring issue with allowing multiple reading systems  to simultaneously listen to content, we could look at it in the maintenance phase.

3. Should contentLists (new, issued, and expired) be personal for each RS or should the they be identical on each RS? (Personal/Identical) My opinion is identical.

Kenny: The new, issued and expired contentlists to the best of my understanding, are user specific and not RS specific. Do you think this needs clarification in the spec?

4. Suppose that a user has two RSs. The user issues and downloads a book on RS1. The next day the user downloads the same book on RS2. After a month or two the book is listed under the 'expired' list and the powers on RS1. RS1 requests the 'expired' list, notices that the book must be returned and informs the user. The user returns the book, what happens next?

Kenny: In this scenario the book would be deleted from RS1, the service would be informed that the book has been returned through the returnContent operation, but the book would still be available on rs2. I don't see a definitive way around this problem unless pdtb2 is used. RS2 could always scan the issued contentlist, and if it has some content from the service that had @requiresReturn=true in its contentMetadata but is not listed in the issued contentList, prompt the user that the content has expired and will be removed. This relies on the assumption that RS2 cached the contentMetadata type for the downloaded content. The issued contentlist on its own Is not an indicator of what content should be present on a reading system as its definition says the following in the spec:

Issued contentlist

Refers to a list of Content items that the Service currently has recorded as issued  to the User (refer to issueContent).

The list must include all Borrowable Content items that have been issued regardless of whether they have been downloaded or not. The list may include Purchasable Content items that have been issued. The list excludes Content items that have expired.

Services that provide Borrowable Content must recognize this identifier.

i.e. RS2 would need to record what content from a service is purchasable or borrowable as purchasable content may or may not be listed in the issued contentlist.

5. Should returnContent return 'true' or something we not yet have defined? (True/Undefined) My opinion is True

Kenny: returnContent should return true as the definition of this operation in the spec states:
...
A Service must return true if the Content item has already been returned prior to this call.
...

How would RS2 determine whether it needs to call returnContent though? The content would no longer be listed in the expired contentList as rs1 already returned it. It could either scan the issued contentList and compare it against  the stored content that has @requiresReturn=true in its contentMetadata, or look at @returnBy in its resources. @returnBy cannot be a definitive indicator as its definition states the following in the spec:
...
This attribute may be present when the requiresReturn attribute of this Content item's contentMetadata  is true, and must not be present when that attribute is false.

i.e. this attribute may or may not be present for content that is returnable.

6. Should the book still be listed under the expired list until RS2 returns the book? (Yes/No) My opinion is Yes.

Kenny: My opinion is no. rs1 has returned the book which should remove the book from the expired coontentlist. To keep it still listed in the expired contentlist, the service would need to track reading systems which is not possible as the serialNumber is an optional attribute in ReadingSystemAttributes.

I think we have two distinct paths here:
1. We make serialNumber a required attribute and define behaviours in the spec that address each of Johan's questions.

2. We keep serialNumber optional, but clarify how multiple reading systems can address each of Johan's questions as suggested above (or in a more expedient manner).

Johan:

> 1. Is the protocol, as is, supposed to support several RSs per user?
> (Yes/No) I think yes but believe it's not possible. The serialNumber in rSA must be required in order for a service provider to track RSs. Now it's optional.
>
> Kenny: As Geoff mentions, using multiple reading systems with the protocol has been discussed several times. The protocol does not require that a Service track multiple reading systems. The serialNumber attribute is optional thus.
>

Johan: We can rule out this question as we have a requirement stating "The protocol must allow a user to download the same book to multiple Reading Systems"

> 2. Should two or more RSs belonging to the same user be allowed to log on to a service and listen to content simultaneously? (Yes/No) My opinion is that this should be prohibited as the the service could be misused.
>
> Kenny: Whether a service decides to allow multiple downloads of issued content, allows issued content to be streamed for lets say thirty days are all service behaviours. However, if you see a glaring issue with allowing multiple reading systems  to simultaneously listen to content, we could look at it in the maintenance phase.
>

Johan: Personally I believe that a person is not capable to listen on
two separate channels at the same time or read two separate texts
simultaneously and remember the information in both medium. Thus, why
allow it in the protocol. If we choose to allow two or more reading
systems to simultaneously download or stream content we MUST make a
decision who content is access prior to the daisy online session. We
have chosen not to allow streaming or downloading outside an daisy
online session and since we can't differ between RSs when the initialize
a session we have to throw out the RS currently downloading or
streaming. Setting the serialNumber as a required element may solve our
issue as long as it is used correctly. This would allow us to track
which RSs currently are logged in and change our downloading and
streaming model to device level instead of user level.

Johan: With this said I think we must decide whether to allow it or not
and clarify it in the spec. My vote is to not allow it.

>
> 3. Should contentLists (new, issued, and expired) be personal for each RS or should the they be identical on each RS? (Personal/Identical) My opinion is identical.
>
> Kenny: The new, issued and expired contentlists to the best of my understanding, are user specific and not RS specific. Do you think this needs clarification in the spec?

Johan: We should maybe add a section clarifying the support for multiple
reading systems once we know how the RSs and Service should behave. As
for the content lists I think that only the 'expired' content list must
be RS specific. It would be even better if we leave it up to the service
to decide, but we need to clarify it in the spec.

>
>
> 4. Suppose that a user has two RSs. The user issues and downloads a book on RS1. The next day the user downloads the same book on RS2. After a month or two the book is listed under the 'expired' list and the powers on RS1. RS1 requests the 'expired' list, notices that the book must be returned and informs the user. The user returns the book, what happens next?
>
> Kenny: In this scenario the book would be deleted from RS1, the service would be informed that the book has been returned through the returnContent operation, but the book would still be available on rs2. I don't see a definitive way around this problem unless pdtb2 is used. RS2 could always scan the issued contentlist, and if it has some content from the service that had @requiresReturn=true in its contentMetadata but is not listed in the issued contentList, prompt the user that the content has expired and will be removed. This relies on the assumption that RS2 cached the contentMetadata type for the downloaded content. The issued contentlist on its own Is not an indicator of what content should be present on a reading system as its definition says the following in the spec:
>
> Issued contentlist
>
> Refers to a list of Content items that the Service currently has recorded as
> issued
>   to the User (refer to
> issueContent).
>
> The list must include all Borrowable Content items that have been issued regardless of whether they have been downloaded or not. The list may include Purchasable
> Content items that have been issued. The list excludes Content items that have
> expired.
>
> Services that provide Borrowable Content must recognize this identifier.
>
> i.e. RS2 would need to record what content from a service is purchasable or borrowable as purchasable content may or may not be listed in the issued contentlist.
>

Johan: My point is that I still would like to allow RS2 to listen on the
book even though it has been returned by RS1. RS1 may also be allowed to
download the content again as content listed under the expired list is
still issued. RS specific 'expired' list would solve this issue but
requires the service to track downloading and streaming which might be
impossible if the actual content resides on a different server.

> 5. Should returnContent return 'true' or something we not yet have defined? (True/Undefined) My opinion is True
>
> Kenny: returnContent should return true as the definition of this operation in the spec states:
> ...
> A Service must return true if the Content item has already been returned prior to this call.
> ...
>
> How would RS2 determine whether it needs to call returnContent though? The content would no longer be listed in the expired contentList as rs1 already returned it. It could either scan the issued contentList and compare it against  the stored content that has @requiresReturn=true in its contentMetadata, or look at @returnBy in its resources. @returnBy cannot be a definitive indicator as its definition states the following in the spec:
> ...
> This attribute may be present when the requiresReturn attribute of this Content item's
> contentMetadata
>   is true, and must not be present when that attribute is false.
>
> i.e. this attribute may or may not be present for content that is returnable.
>

Johan: RS specific 'expired' list would solve this.

> 6. Should the book still be listed under the expired list until RS2 returns the book? (Yes/No) My opinion is Yes.
>
> Kenny: My opinion is no. rs1 has returned the book which should remove the book from the expired coontentlist. To keep it still listed in the expired contentlist, the service would need to track reading systems which is not possible as the serialNumber is an optional attribute in ReadingSystemAttributes.

Johan: RS specific 'expired' list would solve this.

>
>
> I think we have two distinct paths here:
> 1. We make serialNumber a required attribute and define behaviours in the spec that address each of Johan's questions.
>
> 2. We keep serialNumber optional, but clarify how multiple reading systems can address each of Johan's questions as suggested above (or in a more expedient manner).

Johan: My vote is to make serialNumber required and clarify multiple RSs
in the spec. However, it might not be an easy issue to tackle as we must
decide what should be RS specific. Problems might occur with bookmarks,
dynamic menus, announcements etc.

Geoff:

Quick response to one question, the rest clipped.

> Johan: Personally I believe that a person is not capable to listen on
> two separate channels at the same time or read two separate texts
> simultaneously and remember the information in both medium.

That's assuming the user is a single person. There are cases where a service provider may want to give multiple people access under the same account (e.g. an anonymous login).

Johan:

You are absolutely right, we must allow it but then it's better to let the service decide.

Geoff:

Exactly.

Kenny:

Johan, what are your proposed changes after the discussion?

Johan:

We add a note in section 4.2.2 mentioning that a service can choose whether to allow one user to establish several active sessions or kill the currently active session when a new is established. Not exactly these words though.

I'm not sure yet if RS specific expired lists is a suitable solution. I'll get back to you when I've had time to find other solutions, but in my opinion we need to clarify the return of content better, especially when the content may have been downloaded on several reading systems.